// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.28;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@uniswap/v3-core/contracts/libraries/FixedPoint96.sol";
import "./interfaces/IDecentralizedIndex.sol";
import "./interfaces/IDexAdapter.sol";
import "./interfaces/IInitializeSelector.sol";
import "./interfaces/IPEAS.sol";
import "./interfaces/IRewardsWhitelister.sol";
import "./interfaces/IProtocolFees.sol";
import "./interfaces/IProtocolFeeRouter.sol";
import "./interfaces/ITokenRewards.sol";
import "./interfaces/IV3TwapUtilities.sol";

contract TokenRewards is Initializable, IInitializeSelector, ContextUpgradeable, ITokenRewards {
    using SafeERC20 for IERC20;

    uint256 constant PRECISION = 10 ** 27;
    uint256 constant REWARDS_SWAP_SLIPPAGE = 20; // 2%
    uint24 constant REWARDS_POOL_FEE = 10000; // 1%
    int24 constant REWARDS_TICK_SPACING = 200;

    uint256 REWARDS_SWAP_OVERRIDE_MIN;
    address INDEX_FUND;
    address PAIRED_LP_TOKEN;
    bool LEAVE_AS_PAIRED_LP_TOKEN;
    IProtocolFeeRouter PROTOCOL_FEE_ROUTER;
    IRewardsWhitelister REWARDS_WHITELISTER;
    IDexAdapter DEX_ADAPTER;
    IV3TwapUtilities V3_TWAP_UTILS;

    struct Reward {
        uint256 excluded;
        uint256 realized;
    }

    address public override trackingToken;
    address public override rewardsToken;
    uint256 public override totalShares;
    uint256 public override totalStakers;
    mapping(address => uint256) public shares;
    mapping(address => mapping(address => Reward)) public rewards;

    uint256 _rewardsSwapAmountInOverride;
    mapping(address => uint256) _rewardsPerShare;
    mapping(address => uint256) public rewardsDistributed;
    mapping(address => uint256) public rewardsDeposited;
    address[] _allRewardsTokens;
    mapping(address => bool) _depositedRewardsToken;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address _indexFund, address _trackingToken, bool _leaveAsPaired, bytes memory _immutables)
        public
        initializer
    {
        __Context_init();

        (
            address _pairedLpToken,
            address _lpRewardsToken,
            ,
            address _feeRouter,
            address _rewardsWhitelist,
            address _v3TwapUtilities,
            address _dexAdapter
        ) = abi.decode(_immutables, (address, address, address, address, address, address, address));

        PROTOCOL_FEE_ROUTER = IProtocolFeeRouter(_feeRouter);
        REWARDS_WHITELISTER = IRewardsWhitelister(_rewardsWhitelist);
        DEX_ADAPTER = IDexAdapter(_dexAdapter);
        V3_TWAP_UTILS = IV3TwapUtilities(_v3TwapUtilities);
        INDEX_FUND = _indexFund;
        PAIRED_LP_TOKEN = _pairedLpToken;
        LEAVE_AS_PAIRED_LP_TOKEN = _leaveAsPaired;
        trackingToken = _trackingToken;
        rewardsToken = _lpRewardsToken;

        // Setup min swap to be small amount of paired LP token to prevent DOS attemps
        uint8 _pd = IERC20Metadata(_pairedLpToken).decimals();
        uint256 _minSwap = 10 ** (_pd / 2);
        REWARDS_SWAP_OVERRIDE_MIN = _minSwap == 0 ? 10 ** _pd : _minSwap;
    }

    function initializeSelector() external pure override returns (bytes4) {
        return this.initialize.selector;
    }

    function setShares(address _wallet, uint256 _amount, bool _sharesRemoving) external override {
        require(_msgSender() == trackingToken, "UNAUTHORIZED");
        _setShares(_wallet, _amount, _sharesRemoving);
    }

    function _setShares(address _wallet, uint256 _amount, bool _sharesRemoving) internal {
        _processFeesIfApplicable();
        if (_sharesRemoving) {
            _removeShares(_wallet, _amount);
            emit RemoveShares(_wallet, _amount);
        } else {
            _addShares(_wallet, _amount);
            emit AddShares(_wallet, _amount);
        }
    }

    function _addShares(address _wallet, uint256 _amount) internal {
        if (shares[_wallet] > 0) {
            _distributeReward(_wallet);
        }
        uint256 sharesBefore = shares[_wallet];
        totalShares += _amount;
        shares[_wallet] += _amount;
        if (sharesBefore == 0 && shares[_wallet] > 0) {
            totalStakers++;
        }
        _resetExcluded(_wallet);
    }

    function _removeShares(address _wallet, uint256 _amount) internal {
        require(shares[_wallet] > 0 && _amount <= shares[_wallet], "RE");
        _distributeReward(_wallet);
        totalShares -= _amount;
        shares[_wallet] -= _amount;
        if (shares[_wallet] == 0) {
            totalStakers--;
        }
        _resetExcluded(_wallet);
    }

    function _processFeesIfApplicable() internal {
        IDecentralizedIndex(INDEX_FUND).processPreSwapFeesAndSwap();
    }

    function depositFromPairedLpToken(uint256 _amountTknDepositing) public override {
        require(PAIRED_LP_TOKEN != rewardsToken, "R");
        if (_amountTknDepositing > 0) {
            IERC20(PAIRED_LP_TOKEN).safeTransferFrom(_msgSender(), address(this), _amountTknDepositing);
        }
        uint256 _unclaimedPairedLpTkns = rewardsDeposited[PAIRED_LP_TOKEN] - rewardsDistributed[PAIRED_LP_TOKEN];
        uint256 _amountTkn = IERC20(PAIRED_LP_TOKEN).balanceOf(address(this)) - _unclaimedPairedLpTkns;
        require(_amountTkn > 0, "A");
        uint256 _adminAmt = _getAdminFeeFromAmount(_amountTkn);
        _amountTkn -= _adminAmt;

        if (LEAVE_AS_PAIRED_LP_TOKEN) {
            (, uint256 _yieldBurnFee) = _getYieldFees();
            uint256 _burnAmount = (_amountTkn * _yieldBurnFee) / PROTOCOL_FEE_ROUTER.protocolFees().DEN();
            _adminAmt += _burnAmount;
            _amountTkn -= _burnAmount;
            if (_adminAmt > 0) {
                _processAdminFee(_adminAmt);
            }
            _depositRewards(PAIRED_LP_TOKEN, _amountTkn);
            return;
        }

        (address _token0, address _token1) =
            PAIRED_LP_TOKEN < rewardsToken ? (PAIRED_LP_TOKEN, rewardsToken) : (rewardsToken, PAIRED_LP_TOKEN);
        address _pool;
        try DEX_ADAPTER.getV3Pool(_token0, _token1, REWARDS_POOL_FEE) returns (address __pool) {
            _pool = __pool;
        } catch {
            _pool = DEX_ADAPTER.getV3Pool(_token0, _token1, REWARDS_TICK_SPACING);
        }
        uint160 _rewardsSqrtPriceX96 = V3_TWAP_UTILS.sqrtPriceX96FromPoolAndInterval(_pool);
        uint256 _rewardsPriceX96 = V3_TWAP_UTILS.priceX96FromSqrtPriceX96(_rewardsSqrtPriceX96);
        uint256 _amountOut = _token0 == PAIRED_LP_TOKEN
            ? (_rewardsPriceX96 * _amountTkn) / FixedPoint96.Q96
            : (_amountTkn * FixedPoint96.Q96) / _rewardsPriceX96;
        _swapForRewards(_amountTkn, _amountOut, _adminAmt);
    }

    function depositRewards(address _token, uint256 _amount) external override {
        _depositRewardsFromToken(_msgSender(), _token, _amount, true);
    }

    function depositRewardsNoTransfer(address _token, uint256 _amount) external override {
        require(_msgSender() == INDEX_FUND, "AUTH");
        _depositRewardsFromToken(_msgSender(), _token, _amount, false);
    }

    function _depositRewardsFromToken(address _user, address _token, uint256 _amount, bool _shouldTransfer) internal {
        require(_amount > 0, "A");
        require(_isValidRewardsToken(_token), "V");
        uint256 _finalAmt = _amount;
        if (_shouldTransfer) {
            uint256 _balBefore = IERC20(_token).balanceOf(address(this));
            IERC20(_token).safeTransferFrom(_user, address(this), _finalAmt);
            _finalAmt = IERC20(_token).balanceOf(address(this)) - _balBefore;
        }
        uint256 _adminAmt = _getAdminFeeFromAmount(_finalAmt);
        if (_adminAmt > 0) {
            IERC20(_token).safeTransfer(OwnableUpgradeable(address(V3_TWAP_UTILS)).owner(), _adminAmt);
            _finalAmt -= _adminAmt;
        }
        _depositRewards(_token, _finalAmt);
    }

    function _depositRewards(address _token, uint256 _amountTotal) internal {
        if (_amountTotal == 0) {
            return;
        }
        if (!_depositedRewardsToken[_token]) {
            _depositedRewardsToken[_token] = true;
            _allRewardsTokens.push(_token);
        }
        if (totalShares == 0) {
            require(_token == rewardsToken, "R");
            _burnRewards(_amountTotal);
            return;
        }

        uint256 _depositAmount = _amountTotal;
        if (_token == rewardsToken) {
            (, uint256 _yieldBurnFee) = _getYieldFees();
            if (_yieldBurnFee > 0) {
                uint256 _burnAmount = (_amountTotal * _yieldBurnFee) / PROTOCOL_FEE_ROUTER.protocolFees().DEN();
                if (_burnAmount > 0) {
                    _burnRewards(_burnAmount);
                    _depositAmount -= _burnAmount;
                }
            }
        }
        rewardsDeposited[_token] += _depositAmount;
        _rewardsPerShare[_token] += (PRECISION * _depositAmount) / totalShares;
        emit DepositRewards(_msgSender(), _token, _depositAmount);
    }

    function _distributeReward(address _wallet) internal {
        if (shares[_wallet] == 0) {
            return;
        }
        for (uint256 _i; _i < _allRewardsTokens.length; _i++) {
            address _token = _allRewardsTokens[_i];

            if (REWARDS_WHITELISTER.paused(_token)) {
                continue;
            }

            uint256 _amount = getUnpaid(_token, _wallet);
            rewards[_token][_wallet].realized += _amount;
            rewards[_token][_wallet].excluded = _cumulativeRewards(_token, shares[_wallet], true);
            if (_amount > 0) {
                rewardsDistributed[_token] += _amount;
                IERC20(_token).safeTransfer(_wallet, _amount);
                emit DistributeReward(_wallet, _token, _amount);
            }
        }
    }

    function _resetExcluded(address _wallet) internal {
        for (uint256 _i; _i < _allRewardsTokens.length; _i++) {
            address _token = _allRewardsTokens[_i];
            rewards[_token][_wallet].excluded = _cumulativeRewards(_token, shares[_wallet], true);
        }
    }

    function _burnRewards(uint256 _burnAmount) internal {
        try IPEAS(rewardsToken).burn(_burnAmount) {}
        catch {
            IERC20(rewardsToken).safeTransfer(address(0xdead), _burnAmount);
        }
    }

    function _isValidRewardsToken(address _token) internal view returns (bool) {
        return _token == rewardsToken || REWARDS_WHITELISTER.whitelist(_token);
    }

    function _getAdminFeeFromAmount(uint256 _amount) internal view returns (uint256) {
        (uint256 _yieldAdminFee,) = _getYieldFees();
        if (_yieldAdminFee == 0) {
            return 0;
        }
        return (_amount * _yieldAdminFee) / PROTOCOL_FEE_ROUTER.protocolFees().DEN();
    }

    function _getYieldFees() internal view returns (uint256 _admin, uint256 _burn) {
        IProtocolFees _fees = PROTOCOL_FEE_ROUTER.protocolFees();
        if (address(_fees) != address(0)) {
            _admin = _fees.yieldAdmin();
            _burn = _fees.yieldBurn();
        }
    }

    function _swapForRewards(uint256 _amountIn, uint256 _amountOut, uint256 _adminAmt) internal {
        if (_rewardsSwapAmountInOverride > 0) {
            _adminAmt = (_adminAmt * _rewardsSwapAmountInOverride) / _amountIn;
            _amountOut = (_amountOut * _rewardsSwapAmountInOverride) / _amountIn;
            _amountIn = _rewardsSwapAmountInOverride;
        }
        uint256 _balBefore = IERC20(rewardsToken).balanceOf(address(this));
        IERC20(PAIRED_LP_TOKEN).safeIncreaseAllowance(address(DEX_ADAPTER), _amountIn);
        try DEX_ADAPTER.swapV3Single(
            PAIRED_LP_TOKEN,
            rewardsToken,
            REWARDS_POOL_FEE,
            _amountIn,
            _amountIn == REWARDS_SWAP_OVERRIDE_MIN ? 0 : (_amountOut * (1000 - REWARDS_SWAP_SLIPPAGE)) / 1000,
            address(this)
        ) {
            _rewardsSwapAmountInOverride = 0;
            if (_adminAmt > 0) {
                _processAdminFee(_adminAmt);
            }
            _depositRewards(rewardsToken, IERC20(rewardsToken).balanceOf(address(this)) - _balBefore);
        } catch {
            _rewardsSwapAmountInOverride =
                _amountIn / 2 < REWARDS_SWAP_OVERRIDE_MIN ? REWARDS_SWAP_OVERRIDE_MIN : _amountIn / 2;
            IERC20(PAIRED_LP_TOKEN).safeDecreaseAllowance(address(DEX_ADAPTER), _amountIn);
            emit RewardSwapError(_amountIn);
        }
    }

    function _processAdminFee(uint256 _amount) internal {
        IERC20(PAIRED_LP_TOKEN).safeTransfer(OwnableUpgradeable(address(V3_TWAP_UTILS)).owner(), _amount);
    }

    function claimReward(address _wallet) external override {
        _processFeesIfApplicable();
        _distributeReward(_wallet);
        emit ClaimReward(_wallet);
    }

    function getAllRewardsTokens() external view override returns (address[] memory) {
        return _allRewardsTokens;
    }

    function getUnpaid(address _token, address _wallet) public view returns (uint256) {
        if (shares[_wallet] == 0) {
            return 0;
        }
        uint256 earnedRewards = _cumulativeRewards(_token, shares[_wallet], false);
        uint256 rewardsExcluded = rewards[_token][_wallet].excluded;
        if (earnedRewards <= rewardsExcluded) {
            return 0;
        }
        return earnedRewards - rewardsExcluded;
    }

    function _cumulativeRewards(address _token, uint256 _share, bool _roundUp) internal view returns (uint256 _r) {
        _r = (_share * _rewardsPerShare[_token]) / PRECISION;
        if (_roundUp && (_share * _rewardsPerShare[_token]) % PRECISION > 0) {
            _r = _r + 1;
        }
    }
}
