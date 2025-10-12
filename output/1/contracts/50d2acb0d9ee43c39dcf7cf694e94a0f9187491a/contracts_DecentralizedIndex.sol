// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PermitUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./interfaces/IDecentralizedIndex.sol";
import "./interfaces/IDexAdapter.sol";
import "./interfaces/IFlashLoanRecipient.sol";
import "./interfaces/IProtocolFeeRouter.sol";
import "./interfaces/IRewardsWhitelister.sol";
import "./interfaces/IStakingPoolToken.sol";
import "./interfaces/ITokenRewards.sol";
import "./interfaces/IV3TwapUtilities.sol";

abstract contract DecentralizedIndex is Initializable, ERC20Upgradeable, ERC20PermitUpgradeable, IDecentralizedIndex {
    using SafeERC20 for IERC20;

    uint16 constant DEN = 10000;
    uint8 constant SWAP_DELAY = 20; // seconds

    IProtocolFeeRouter PROTOCOL_FEE_ROUTER;
    IRewardsWhitelister REWARDS_WHITELIST;
    IDexAdapter public override DEX_HANDLER;
    IV3TwapUtilities V3_TWAP_UTILS;

    uint256 public FLASH_FEE_AMOUNT_DAI; // 10 DAI
    address public PAIRED_LP_TOKEN;
    address CREATOR;
    address V2_ROUTER;
    address V3_ROUTER;
    address DAI;
    address WETH;
    address V2_POOL;

    Config _config;
    Fees _fees;

    IndexType public indexType;
    uint256 public created;
    address public lpRewardsToken;
    address public override lpStakingPool;
    uint8 public override unlocked;

    IndexAssetInfo[] public indexTokens;
    mapping(address => bool) _isTokenInIndex;
    mapping(address => uint8) _fundTokenIdx;
    mapping(address => bool) _blacklist; // DEPRECATED: remove in future versions, DO NOT remove until redeploy beacon to prevent breaking current proxy storage
    mapping(address => uint256) _totalAssets;
    uint256 _totalSupply;
    uint64 _partnerFirstWrapped;
    uint64 _lastSwap;
    uint8 _swapping;
    uint8 _swapAndFeeOn;
    uint8 _shortCircuitRewards;
    bool _isSetup;

    uint256 _totalAssets0PreFlashMint;
    uint256 _totalSupplyPreFlashMint;
    uint8 public override isFlashMinting;

    uint256[50] private __gap; // reserved for future upgrades

    modifier lock() {
        require(unlocked == 1, "L");
        unlocked = 0;
        _;
        unlocked = 1;
    }

    modifier onlyPartner() {
        require(_msgSender() == _config.partner, "P");
        _;
    }

    modifier noSwapOrFee() {
        _swapAndFeeOn = 0;
        _;
        _swapAndFeeOn = 1;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

    function __DecentralizedIndex_init(
        string memory _name,
        string memory _symbol,
        IndexType _idxType,
        Config memory __config,
        Fees memory __fees,
        bytes memory _immutables
    ) internal onlyInitializing {
        __ERC20_init(_name, _symbol);
        __ERC20Permit_init(_name);

        CREATOR = _msgSender();
        unlocked = 1;
        _swapAndFeeOn = 1;

        require(__fees.buy <= (uint256(DEN) * 20) / 100);
        require(__fees.sell <= (uint256(DEN) * 20) / 100);
        require(__fees.burn <= (uint256(DEN) * 70) / 100);
        require(__fees.bond <= (uint256(DEN) * 99) / 100);
        require(__fees.debond <= (uint256(DEN) * 99) / 100);
        require(__fees.partner <= (uint256(DEN) * 5) / 100);

        indexType = _idxType;
        created = block.timestamp;
        _fees = __fees;
        _config = __config;
        _config.debondCooldown = __config.debondCooldown == 0 ? 60 days : __config.debondCooldown;

        (
            address _pairedLpToken,
            address _lpRewardsToken,
            address _dai,
            address _feeRouter,
            address _rewardsWhitelister,
            address _v3TwapUtils,
            address _dexAdapter
        ) = abi.decode(_immutables, (address, address, address, address, address, address, address));
        require(_pairedLpToken != address(0), "PLP");
        lpRewardsToken = _lpRewardsToken;
        DAI = _dai;
        PROTOCOL_FEE_ROUTER = IProtocolFeeRouter(_feeRouter);
        REWARDS_WHITELIST = IRewardsWhitelister(_rewardsWhitelister);
        V3_TWAP_UTILS = IV3TwapUtilities(_v3TwapUtils);
        DEX_HANDLER = IDexAdapter(_dexAdapter);
        V2_ROUTER = DEX_HANDLER.V2_ROUTER();
        V3_ROUTER = DEX_HANDLER.V3_ROUTER();
        PAIRED_LP_TOKEN = _pairedLpToken;
        FLASH_FEE_AMOUNT_DAI = 10 * 10 ** IERC20Metadata(_dai).decimals(); // 10 DAI
        WETH = DEX_HANDLER.WETH();
        emit Create(address(this), _msgSender());
    }

    /// @notice The ```setup``` function initialized a new LP pair for the pod + pairedLpAsset
    function setup() external override {
        require(!_isSetup, "O");
        _isSetup = true;
        address _v2Pool = DEX_HANDLER.getV2Pool(address(this), PAIRED_LP_TOKEN);
        if (_v2Pool == address(0)) {
            _v2Pool = DEX_HANDLER.createV2Pool(address(this), PAIRED_LP_TOKEN);
        }
        IStakingPoolToken(lpStakingPool).setStakingToken(_v2Pool);
        Ownable(lpStakingPool).renounceOwnership();
        V2_POOL = _v2Pool;
        emit Initialize(_msgSender(), _v2Pool);
    }

    /// @notice The ```totalSupply``` function returns the total pTKN supply minted, excluding any used for _flashMint
    /// @return _totalSupply Valid supply of pTKN excluding flashMinted pTKNs
    function totalSupply() public view override(IERC20, ERC20Upgradeable) returns (uint256) {
        return _totalSupply;
    }

    /// @notice The ```_update``` function overrides the standard ERC20 _update to handle fee processing for a pod
    /// @param _from Where pTKN are being transferred from
    /// @param _to Where pTKN are being transferred to
    /// @param _amount Amount of pTKN being transferred
    function _update(address _from, address _to, uint256 _amount) internal override {
        require(!_blacklist[_to], "BK");
        if (_from == address(0) || _to == address(0)) {
            super._update(_from, _to, _amount);
            return;
        }
        bool _buy = _from == V2_POOL && _to != V2_ROUTER;
        bool _sell = _to == V2_POOL;
        uint256 _fee;
        if (_swapping == 0 && _swapAndFeeOn == 1) {
            if (_from != V2_POOL) {
                _processPreSwapFeesAndSwap();
            }
            if (_buy && _fees.buy > 0) {
                _fee = (_amount * _fees.buy) / DEN;
                super._update(_from, address(this), _fee);
            } else if (_sell && _fees.sell > 0) {
                _fee = (_amount * _fees.sell) / DEN;
                super._update(_from, address(this), _fee);
            } else if (!_buy && !_sell && _config.hasTransferTax) {
                _fee = _amount / 10000; // 0.01%
                _fee = _fee == 0 && _amount > 0 ? 1 : _fee;
                super._update(_from, address(this), _fee);
            }
        }
        _processBurnFee(_fee);
        super._update(_from, _to, _amount - _fee);
    }

    /// @notice The ```_processPreSwapFeesAndSwap``` function processes fees that could be pending for a pod
    function _processPreSwapFeesAndSwap() internal {
        if (_shortCircuitRewards == 1) {
            return;
        }
        bool _passesSwapDelay = block.timestamp > _lastSwap + SWAP_DELAY;
        if (!_passesSwapDelay) {
            return;
        }
        uint256 _bal = balanceOf(address(this));
        if (_bal == 0) {
            return;
        }
        uint256 _lpBal = balanceOf(V2_POOL);
        uint256 _min = block.chainid == 1 ? _lpBal / 1000 : _lpBal / 4000; // 0.1%/0.025% LP bal
        uint256 _max = _lpBal / 100; // 1%
        if (_bal >= _min && _lpBal > 0) {
            _swapping = 1;
            _lastSwap = uint64(block.timestamp);
            uint256 _totalAmt = _bal > _max ? _max : _bal;
            uint256 _partnerAmt;
            if (_fees.partner > 0 && _config.partner != address(0)) {
                _partnerAmt = (_totalAmt * _fees.partner) / DEN;
                super._update(address(this), _config.partner, _partnerAmt);
            }
            _feeSwap(_totalAmt - _partnerAmt);
            _swapping = 0;
        }
    }

    /// @notice The ```_processBurnFee``` function burns pTKN based on the burn fee, which turns the pod
    /// @notice into a vault where holders have more underlying TKN to pTKN as burn fees process over time
    /// @param _amtToProcess Number of pTKN being burned
    function _processBurnFee(uint256 _amtToProcess) internal {
        if (_amtToProcess == 0 || _fees.burn == 0) {
            return;
        }
        uint256 _burnAmt = (_amtToProcess * _fees.burn) / DEN;
        _totalSupply -= _burnAmt;
        _burn(address(this), _burnAmt);
    }

    /// @notice The ```_feeSwap``` function processes built up fees by converting to pairedLpToken
    /// @param _amount Number of pTKN being processed for yield
    function _feeSwap(uint256 _amount) internal {
        _approve(address(this), address(DEX_HANDLER), _amount);
        address _rewards = IStakingPoolToken(lpStakingPool).POOL_REWARDS();
        uint256 _pairedLpBalBefore = IERC20(PAIRED_LP_TOKEN).balanceOf(_rewards);
        DEX_HANDLER.swapV2Single(address(this), PAIRED_LP_TOKEN, _amount, 0, _rewards);

        if (PAIRED_LP_TOKEN == lpRewardsToken) {
            uint256 _newPairedLpTkns = IERC20(PAIRED_LP_TOKEN).balanceOf(_rewards) - _pairedLpBalBefore;
            if (_newPairedLpTkns > 0) {
                ITokenRewards(_rewards).depositRewardsNoTransfer(PAIRED_LP_TOKEN, _newPairedLpTkns);
            }
        } else if (IERC20(PAIRED_LP_TOKEN).balanceOf(_rewards) > 0) {
            ITokenRewards(_rewards).depositFromPairedLpToken(0);
        }
    }

    /// @notice The ```_transferFromAndValidate``` function is basically the _transfer with hardcoded _to to this CA and executes
    /// @notice a token transfer with balance validation to revert if balances aren't updated as expected
    /// @notice on transfer (i.e. transfer fees, etc.)
    /// @param _token The token we're transferring
    /// @param _sender The token we're transferring
    /// @param _amount Number of tokens to transfer
    function _transferFromAndValidate(IERC20 _token, address _sender, uint256 _amount) internal {
        uint256 _balanceBefore = _token.balanceOf(address(this));
        _token.safeTransferFrom(_sender, address(this), _amount);
        require(_token.balanceOf(address(this)) >= _balanceBefore + _amount, "TV");
    }

    /// @notice The ```_internalBond``` function should be called from external bond() to handle validation and partner logic
    function _internalBond() internal {
        require(_isSetup, "I");
        if (_partnerFirstWrapped == 0 && _msgSender() == _config.partner) {
            _partnerFirstWrapped = uint64(block.timestamp);
        }
    }

    /// @notice The ```_canWrapFeeFree``` function checks if the wrapping user can wrap without fees
    /// @param _wrapper The user wrapping into the pod
    /// @return bool Whether the user can wrap fee free
    function _canWrapFeeFree(address _wrapper) internal view returns (bool) {
        return _isFirstIn()
            || (_wrapper == _config.partner && _partnerFirstWrapped == 0 && block.timestamp <= created + 7 days);
    }

    /// @notice The ```_isFirstIn``` function confirms if the user is the first to wrap
    /// @return bool Whether the user is the first one in
    function _isFirstIn() internal view returns (bool) {
        return _totalSupply == 0;
    }

    /// @notice The ```_isLastOut``` function checks if the user is the last one out
    /// @param _debondAmount Number of pTKN being unwrapped
    /// @return bool Whether the user is the last one out
    function _isLastOut(uint256 _debondAmount) internal view returns (bool) {
        return _debondAmount >= (_totalSupply * 99) / 100;
    }

    /// @notice The ```processPreSwapFeesAndSwap``` function allows the rewards CA for the pod to process fees as needed
    function processPreSwapFeesAndSwap() external override lock {
        require(_msgSender() == IStakingPoolToken(lpStakingPool).POOL_REWARDS(), "R");
        _processPreSwapFeesAndSwap();
    }

    function BOND_FEE() external view override returns (uint16) {
        return _fees.bond;
    }

    function DEBOND_FEE() external view override returns (uint16) {
        return _fees.debond;
    }

    function config() external view override returns (Config memory) {
        return _config;
    }

    function fees() external view override returns (Fees memory) {
        return _fees;
    }

    function isAsset(address _token) public view override returns (bool) {
        return _isTokenInIndex[_token];
    }

    function getAllAssets() external view override returns (IndexAssetInfo[] memory) {
        return indexTokens;
    }

    /// @notice The ```burn``` function allows any user to burn an amount of their pTKN
    /// @param _amount Number of pTKN to burn
    function burn(uint256 _amount) external lock {
        _totalSupply -= _amount;
        _burn(_msgSender(), _amount);
    }

    /// @notice The ```addLiquidityV2``` function mints new liquidity for the pod
    /// @param _pTKNLPTokens Number pTKN to add to liquidity
    /// @param _pairedLPTokens Number of pairedLpToken to add to liquidity
    /// @param _slippage LP slippage with 1000 precision
    /// @param _deadline LP validation deadline
    /// @return _liquidity Number of new liquidity tokens minted
    function addLiquidityV2(
        uint256 _pTKNLPTokens,
        uint256 _pairedLPTokens,
        uint256 _slippage, // 100 == 10%, 1000 == 100%
        uint256 _deadline
    ) external override lock noSwapOrFee returns (uint256) {
        uint256 _idxTokensBefore = balanceOf(address(this));
        uint256 _pairedBefore = IERC20(PAIRED_LP_TOKEN).balanceOf(address(this));

        super._update(_msgSender(), address(this), _pTKNLPTokens);
        _approve(address(this), address(DEX_HANDLER), _pTKNLPTokens);

        IERC20(PAIRED_LP_TOKEN).safeTransferFrom(_msgSender(), address(this), _pairedLPTokens);
        IERC20(PAIRED_LP_TOKEN).safeIncreaseAllowance(address(DEX_HANDLER), _pairedLPTokens);

        uint256 _poolBalBefore = IERC20(DEX_HANDLER.getV2Pool(address(this), PAIRED_LP_TOKEN)).balanceOf(_msgSender());
        DEX_HANDLER.addLiquidity(
            address(this),
            PAIRED_LP_TOKEN,
            _pTKNLPTokens,
            _pairedLPTokens,
            (_pTKNLPTokens * (1000 - _slippage)) / 1000,
            (_pairedLPTokens * (1000 - _slippage)) / 1000,
            _msgSender(),
            _deadline
        );
        IERC20(PAIRED_LP_TOKEN).safeIncreaseAllowance(address(DEX_HANDLER), 0);

        // check & refund excess tokens from LPing
        if (balanceOf(address(this)) > _idxTokensBefore) {
            super._update(address(this), _msgSender(), balanceOf(address(this)) - _idxTokensBefore);
        }
        if (IERC20(PAIRED_LP_TOKEN).balanceOf(address(this)) > _pairedBefore) {
            IERC20(PAIRED_LP_TOKEN).safeTransfer(
                _msgSender(), IERC20(PAIRED_LP_TOKEN).balanceOf(address(this)) - _pairedBefore
            );
        }
        emit AddLiquidity(_msgSender(), _pTKNLPTokens, _pairedLPTokens);
        return IERC20(DEX_HANDLER.getV2Pool(address(this), PAIRED_LP_TOKEN)).balanceOf(_msgSender()) - _poolBalBefore;
    }

    /// @notice The ```removeLiquidityV2``` function burns pod liquidity
    /// @param _lpTokens Number of liquidity tokens to burn/remove
    /// @param _minIdxTokens Number of pTKN to receive at a minimum, slippage
    /// @param _minPairedLpToken Number of pairedLpToken to receive at a minimum, slippage
    /// @param _deadline LP validation deadline
    function removeLiquidityV2(
        uint256 _lpTokens,
        uint256 _minIdxTokens, // 0 == 100% slippage
        uint256 _minPairedLpToken, // 0 == 100% slippage
        uint256 _deadline
    ) external override lock noSwapOrFee {
        _lpTokens = _lpTokens == 0 ? IERC20(V2_POOL).balanceOf(_msgSender()) : _lpTokens;
        require(_lpTokens > 0, "LT");

        IERC20(V2_POOL).safeTransferFrom(_msgSender(), address(this), _lpTokens);
        IERC20(V2_POOL).safeIncreaseAllowance(address(DEX_HANDLER), _lpTokens);
        DEX_HANDLER.removeLiquidity(
            address(this), PAIRED_LP_TOKEN, _lpTokens, _minIdxTokens, _minPairedLpToken, _msgSender(), _deadline
        );
        emit RemoveLiquidity(_msgSender(), _lpTokens);
    }

    /// @notice The ```flash``` function allows to flash loan underlying TKN from the pod
    /// @param _recipient User to receive underlying TKN for the flash loan
    /// @param _token TKN to borrow
    /// @param _amount Number of underying TKN to borrow
    /// @param _data Any data the recipient wants to be passed on the flash loan callback
    function flash(address _recipient, address _token, uint256 _amount, bytes calldata _data) external override lock {
        require(_isTokenInIndex[_token], "X");
        address _rewards = IStakingPoolToken(lpStakingPool).POOL_REWARDS();
        address _feeRecipient = lpRewardsToken == DAI
            ? address(this)
            : PAIRED_LP_TOKEN == DAI ? _rewards : Ownable(address(V3_TWAP_UTILS)).owner();
        IERC20(DAI).safeTransferFrom(_msgSender(), _feeRecipient, FLASH_FEE_AMOUNT_DAI);
        if (lpRewardsToken == DAI) {
            IERC20(DAI).safeIncreaseAllowance(_rewards, FLASH_FEE_AMOUNT_DAI);
            ITokenRewards(_rewards).depositRewards(DAI, FLASH_FEE_AMOUNT_DAI);
        } else if (PAIRED_LP_TOKEN == DAI) {
            ITokenRewards(_rewards).depositFromPairedLpToken(0);
        }
        uint256 _balance = IERC20(_token).balanceOf(address(this));
        IERC20(_token).safeTransfer(_recipient, _amount);
        IFlashLoanRecipient(_recipient).callback(_data);
        require(IERC20(_token).balanceOf(address(this)) >= _balance, "FA");
        emit FlashLoan(_msgSender(), _recipient, _token, _amount);
    }

    /// @notice The ```flashMint``` function allows to flash mint pTKN and burn it + 0.1% at the end of the transaction
    /// @param _recipient User to receive pTKN for the flash mint
    /// @param _amount Number of pTKN to receive/mint
    /// @param _data Any data the recipient wants to be passed on the flash mint callback
    function flashMint(address _recipient, uint256 _amount, bytes calldata _data) external override lock {
        isFlashMinting = 1;
        _shortCircuitRewards = 1;
        _totalAssets0PreFlashMint = _totalAssets[indexTokens[0].token];
        _totalSupplyPreFlashMint = _totalSupply;

        uint256 _fee = _amount / 1000;
        _fee = _fee == 0 ? 1 : _fee;

        uint256 _balance = balanceOf(address(this));
        _mint(_recipient, _amount);
        IFlashLoanRecipient(_recipient).callback(_data);
        // recipient should have transferred pTKN back here to burn
        require(balanceOf(address(this)) >= _balance + _amount + _fee, "FMA");
        // only adjust _totalSupply by fee since we didn't add to supply at mint during flash mint
        _totalSupply -= _fee;
        _burn(address(this), _amount + _fee);

        _totalAssets0PreFlashMint = 0;
        _totalSupplyPreFlashMint = 0;
        _shortCircuitRewards = 0;
        isFlashMinting = 0;
        emit FlashMint(_msgSender(), _recipient, _amount);
    }

    function setPartner(address _partner) external onlyPartner {
        _config.partner = _partner;
        emit SetPartner(_msgSender(), _partner);
    }

    function setPartnerFee(uint16 _fee) external onlyPartner {
        require(_fee < _fees.partner, "L");
        _fees.partner = _fee;
        emit SetPartnerFee(_msgSender(), _fee);
    }

    function setLpStakingPool(address _pool) external {
        require(_msgSender() == CREATOR && lpStakingPool == address(0), "I");
        lpStakingPool = _pool;
    }

    receive() external payable {}
}
