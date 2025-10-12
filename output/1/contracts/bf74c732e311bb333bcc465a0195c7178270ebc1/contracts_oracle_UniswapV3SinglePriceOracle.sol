// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import "@uniswap/v3-core/contracts/libraries/FixedPoint96.sol";
import "../libraries/FullMath.sol";
import "../libraries/TickMath.sol";
import "../interfaces/IERC20Metadata.sol";
import "../interfaces/IMinimalSinglePriceOracle.sol";
import "../interfaces/IUniswapV3Pool.sol";
import "./ChainlinkSinglePriceOracle.sol";

contract UniswapV3SinglePriceOracle is ChainlinkSinglePriceOracle {
    constructor(address _sequencer) ChainlinkSinglePriceOracle(_sequencer) {}

    function getPriceUSD18(
        address _clBaseConversionPoolPriceFeed,
        address _quoteToken,
        address _quoteV3Pool,
        uint256 _twapInterval
    ) external view virtual override returns (bool _isBadData, uint256 _price18) {
        uint256 _quotePriceX96 = _getPoolPriceTokenDenomenator(_quoteToken, _quoteV3Pool, uint32(_twapInterval));
        // default base price to 1, which just means return only quote pool price without any base conversion
        uint256 _basePrice18 = 10 ** 18;
        uint256 _updatedAt = block.timestamp;
        if (_clBaseConversionPoolPriceFeed != address(0)) {
            (_basePrice18, _updatedAt, _isBadData) = _getChainlinkPriceFeedPrice18(_clBaseConversionPoolPriceFeed);
        }
        _price18 = (_quotePriceX96 * _basePrice18) / FixedPoint96.Q96;
        uint256 _maxDelay = feedMaxOracleDelay[_clBaseConversionPoolPriceFeed] > 0
            ? feedMaxOracleDelay[_clBaseConversionPoolPriceFeed]
            : defaultMaxOracleDelay;
        _isBadData = _isBadData || _updatedAt < block.timestamp - _maxDelay;
    }

    function _getPoolPriceTokenDenomenator(address _priceToken, address _pricePool, uint32 _interval)
        internal
        view
        returns (uint256)
    {
        address _t0 = IUniswapV3Pool(_pricePool).token0();
        return _normalizedPriceX96(
            IUniswapV3Pool(_pricePool), _interval, _t0 == _priceToken ? IUniswapV3Pool(_pricePool).token1() : _t0
        );
    }

    function _getSqrtPriceX96FromPool(IUniswapV3Pool _pool, uint32 _interval)
        internal
        view
        returns (uint160 _sqrtPriceX96)
    {
        if (_interval == 0) {
            (_sqrtPriceX96,,,,,,) = _pool.slot0();
        } else {
            uint32[] memory secondsAgo = new uint32[](2);
            secondsAgo[0] = _interval;
            secondsAgo[1] = 0; // to (now)
            (int56[] memory tickCumulatives,) = _pool.observe(secondsAgo);
            int56 tickCumulativesDelta = tickCumulatives[1] - tickCumulatives[0];
            int24 arithmeticMeanTick = int24(tickCumulativesDelta / int32(_interval));
            // Always round to negative infinity
            if (tickCumulativesDelta < 0 && (tickCumulativesDelta % int32(_interval) != 0)) arithmeticMeanTick--;
            _sqrtPriceX96 = TickMath.getSqrtRatioAtTick(arithmeticMeanTick);
        }
    }

    function _normalizedPriceX96(IUniswapV3Pool _pool, uint32 _twapInterval, address _numeratorToken)
        internal
        view
        returns (uint256)
    {
        address _token1 = _pool.token1();
        uint8 _decimals0 = IERC20Metadata(_pool.token0()).decimals();
        uint8 _decimals1 = IERC20Metadata(_token1).decimals();
        uint160 _sqrtPriceX96 = _getSqrtPriceX96FromPool(_pool, _twapInterval);
        uint256 _priceX96 = FullMath.mulDiv(_sqrtPriceX96, _sqrtPriceX96, FixedPoint96.Q96);
        uint256 _correctedPriceX96 = _token1 == _numeratorToken ? _priceX96 : FixedPoint96.Q96 ** 2 / _priceX96;
        return _token1 == _numeratorToken
            ? (_correctedPriceX96 * 10 ** _decimals0) / 10 ** _decimals1
            : (_correctedPriceX96 * 10 ** _decimals1) / 10 ** _decimals0;
    }
}
