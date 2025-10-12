// https://peapods.finance

// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PermitUpgradeable.sol";
import "@uniswap/v3-core/contracts/libraries/FixedPoint96.sol";
import "./libraries/FullMath.sol";
import "./interfaces/IInitializeSelector.sol";
import "./DecentralizedIndex.sol";

contract WeightedIndex is Initializable, IInitializeSelector, DecentralizedIndex {
    using SafeERC20 for IERC20;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /// @notice The ```initialize``` function initializes a new WeightedIndex pod
    /// @param _name The name of the ERC20 token of the pod
    /// @param _symbol The symbol/ticker of the ERC20 token of the pod
    /// @param _baseConfig A packed set of vars that represents some core pod data
    ///     @param _baseConfig[0] = _config A struct containing some pod-level, one off configuration for the pod
    ///     @param _baseConfig[1] = _fees A struct holding all pod-level fees
    ///     @param _baseConfig[2] = _tokens The ERC20 token addresses that make up the pod
    ///     @param _baseConfig[3] = _weights The weights that each ERC20 token makes up in the pod, defined by token amount
    /// @param _immutables A number of immutable options/addresses to help the pod function properly on the current network, see DecentralizedIndex for unpacking info
    function initialize(string memory _name, string memory _symbol, bytes memory _baseConfig, bytes memory _immutables)
        public
        initializer
    {
        (Config memory _config, Fees memory _fees, address[] memory _tokens, uint256[] memory _weights,,) =
            abi.decode(_baseConfig, (Config, Fees, address[], uint256[], address, bool));

        __DecentralizedIndex_init(_name, _symbol, IndexType.WEIGHTED, _config, _fees, _immutables);
        __WeightedIndex_init(_tokens, _weights);
    }

    function initializeSelector() external pure override returns (bytes4) {
        return this.initialize.selector;
    }

    function __WeightedIndex_init(address[] memory _tokens, uint256[] memory _weights) internal {
        require(_tokens.length == _weights.length, "V");
        uint256 _totalWeights;
        uint256 _tl = _tokens.length;
        for (uint8 _i; _i < _tl; _i++) {
            require(!_isTokenInIndex[_tokens[_i]], "D");
            require(_weights[_i] > 0, "W");
            indexTokens.push(
                IndexAssetInfo({
                    token: _tokens[_i],
                    basePriceUSDX96: 0,
                    weighting: _weights[_i],
                    c1: address(0),
                    q1: 0 // amountsPerIdxTokenX96
                })
            );
            _totalWeights += _weights[_i];
            _fundTokenIdx[_tokens[_i]] = _i;
            _isTokenInIndex[_tokens[_i]] = true;
        }
        // at idx == 0, need to find X in [1/X = tokenWeightAtIdx/totalWeights]
        // at idx > 0, need to find Y in (Y/X = tokenWeightAtIdx/totalWeights)
        uint256 _xX96 = (FixedPoint96.Q96 * _totalWeights) / _weights[0];
        for (uint256 _i; _i < _tl; _i++) {
            indexTokens[_i].q1 = (_weights[_i] * _xX96 * 10 ** IERC20Metadata(_tokens[_i]).decimals()) / _totalWeights;
        }
    }

    /// @notice The ```totalAssets``` function returns the number of assets for the first underlying TKN in the pod
    /// @return _totalManagedAssets Number of TKN[0] currently in the pod
    function totalAssets() public view override returns (uint256 _totalManagedAssets) {
        _totalManagedAssets = _totalAssets[indexTokens[0].token];
    }

    /// @notice The ```totalAssets``` function returns the number of assets for the specified TKN in the pod
    /// @param _asset The asset we're querying for the total managed assets
    /// @return _totalManagedAssets Number of tkns currently in the pod
    function totalAssets(address _asset) public view override returns (uint256 _totalManagedAssets) {
        _totalManagedAssets = _totalAssets[_asset];
    }

    /// @notice The ```convertToShares``` function returns the number of pTKN minted based on _assets TKN excluding fees
    /// @param _assets Number of underlying TKN[0] to determine how many pTKNs to be minted
    /// @return _shares Number of pTKN to be minted
    function convertToShares(uint256 _assets) external view override returns (uint256 _shares) {
        bool _firstIn = _isFirstIn();
        if (_firstIn) {
            _shares = FullMath.mulDiv(_assets, FixedPoint96.Q96 * 10 ** decimals(), indexTokens[0].q1);
        } else {
            uint256 _tokenAmtSupplyRatioX96 =
                FullMath.mulDiv(_assets, FixedPoint96.Q96, _totalAssets[indexTokens[0].token]);
            _shares = FullMath.mulDiv(_totalSupply, _tokenAmtSupplyRatioX96, FixedPoint96.Q96);
        }
        _shares -= FullMath.mulDiv(_shares, _fees.bond, DEN);
    }

    /// @notice The ```convertToAssets``` function returns the number of TKN returned based on burning _shares pTKN excluding fees
    /// @param _shares Number of pTKN to burn
    /// @return _assets Number of TKN[0] to be returned to user from pod
    function convertToAssets(uint256 _shares) external view override returns (uint256 _assets) {
        _assets = _convertToAssets(_shares, _totalAssets[indexTokens[0].token], _totalSupply);
    }

    /// @notice The ```convertToAssetsPreFlashMint``` function returns the number of TKN returned based on burning _shares pTKN excluding fees before a flash mint starts
    /// @param _shares Number of pTKN to burn
    /// @return _assets Number of TKN[0] to be returned to user from pod
    function convertToAssetsPreFlashMint(uint256 _shares) external view override returns (uint256 _assets) {
        _assets = _convertToAssets(_shares, _totalAssets0PreFlashMint, _totalSupplyPreFlashMint);
    }

    function _convertToAssets(uint256 _shares, uint256 _localTotalAssets0, uint256 _localTotalSupply)
        internal
        view
        returns (uint256 _assets)
    {
        bool _firstIn = _isFirstIn();
        if (_firstIn) {
            _assets = FullMath.mulDiv(_shares, indexTokens[0].q1, FixedPoint96.Q96 * 10 ** decimals());
        } else {
            uint256 _percSharesX96 = FullMath.mulDiv(_shares, FixedPoint96.Q96, _localTotalSupply);
            _assets = FullMath.mulDiv(_localTotalAssets0, _percSharesX96, FixedPoint96.Q96);
        }
        _assets -= FullMath.mulDiv(_assets, _fees.debond, DEN);
    }

    /// @notice The ```bond``` function wraps a user into a pod and mints new pTKN
    /// @param _token The token used to calculate the amount of pTKN minted
    /// @param _amount Number of _tokens used to wrap into the pod
    /// @param _amountMintMin Number of pTKN minimum that should be minted (slippage)
    function bond(address _token, uint256 _amount, uint256 _amountMintMin) external override lock noSwapOrFee {
        _bond(_token, _amount, _amountMintMin, _msgSender());
    }

    function _bond(address _token, uint256 _amount, uint256 _amountMintMin, address _user) internal {
        require(_isTokenInIndex[_token], "IT");
        uint256 _tokenIdx = _fundTokenIdx[_token];

        bool _firstIn = _isFirstIn();
        uint256 _tokenAmtSupplyRatioX96 =
            _firstIn ? FixedPoint96.Q96 : (_amount * FixedPoint96.Q96) / _totalAssets[_token];
        uint256 _tokensMinted;
        if (_firstIn) {
            _tokensMinted = (_amount * FixedPoint96.Q96 * 10 ** decimals()) / indexTokens[_tokenIdx].q1;
        } else {
            _tokensMinted = (_totalSupply * _tokenAmtSupplyRatioX96) / FixedPoint96.Q96;
        }
        uint256 _feeTokens = _canWrapFeeFree(_user) ? 0 : (_tokensMinted * _fees.bond) / DEN;
        require(_tokensMinted - _feeTokens >= _amountMintMin, "M");
        _totalSupply += _tokensMinted;
        _mint(_user, _tokensMinted - _feeTokens);
        if (_feeTokens > 0) {
            _mint(address(this), _feeTokens);
            _processBurnFee(_feeTokens);
        }
        uint256 _il = indexTokens.length;
        for (uint256 _i; _i < _il; _i++) {
            uint256 _transferAmt = _firstIn
                ? getInitialAmount(_token, _amount, indexTokens[_i].token)
                : FullMath.mulDivRoundingUp(_totalAssets[indexTokens[_i].token], _tokenAmtSupplyRatioX96, FixedPoint96.Q96);
            require(_transferAmt > 0, "T0");
            _totalAssets[indexTokens[_i].token] += _transferAmt;
            _transferFromAndValidate(IERC20(indexTokens[_i].token), _user, _transferAmt);
        }
        _internalBond();
        emit Bond(_user, _token, _amount, _tokensMinted);
    }

    /// @notice The ```debond``` function unwraps a user out of a pod and burns pTKN
    /// @param _amount Number of pTKN to burn
    function debond(uint256 _amount, address[] memory, uint8[] memory) external override lock noSwapOrFee {
        uint256 _amountAfterFee = _isLastOut(_amount) || REWARDS_WHITELIST.isWhitelistedFromDebondFee(_msgSender())
            ? _amount
            : (_amount * (DEN - _fees.debond)) / DEN;
        uint256 _percSharesX96 = (_amountAfterFee * FixedPoint96.Q96) / _totalSupply;
        super._transfer(_msgSender(), address(this), _amount);
        _totalSupply -= _amountAfterFee;
        _burn(address(this), _amountAfterFee);
        _processBurnFee(_amount - _amountAfterFee);
        uint256 _il = indexTokens.length;
        for (uint256 _i; _i < _il; _i++) {
            uint256 _debondAmount = (_totalAssets[indexTokens[_i].token] * _percSharesX96) / FixedPoint96.Q96;
            if (_debondAmount > 0) {
                _totalAssets[indexTokens[_i].token] -= _debondAmount;
                IERC20(indexTokens[_i].token).safeTransfer(_msgSender(), _debondAmount);
            }
        }
        // an arbitrage path of buy pTKN > debond > sell TKN does not trigger rewards
        // so let's trigger processing here at debond to keep things moving along
        _processPreSwapFeesAndSwap();
        emit Debond(_msgSender(), _amount);
    }

    /// @notice The ```getInitialAmount``` function determines the initial amount of TKN2 needed
    /// @notice based on an amount of TKN1 to wrap with. After an initial bond, vault share takes over
    /// @param _sourceToken TKN we're referencing
    /// @param _sourceAmount Amount of TKN we're referencing
    /// @param _targetToken Target TKN we will return the amount that is needed
    /// @return _amtTargetTkn Amount of _targetToken needed to wrap with
    function getInitialAmount(address _sourceToken, uint256 _sourceAmount, address _targetToken)
        public
        view
        override
        returns (uint256)
    {
        uint256 _sourceTokenIdx = _fundTokenIdx[_sourceToken];
        uint256 _targetTokenIdx = _fundTokenIdx[_targetToken];
        return (_sourceAmount * indexTokens[_targetTokenIdx].weighting * 10 ** IERC20Metadata(_targetToken).decimals())
            / indexTokens[_sourceTokenIdx].weighting / 10 ** IERC20Metadata(_sourceToken).decimals();
    }
}
