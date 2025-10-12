// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IDexAdapter {
    function ASYNC_INITIALIZE() external view returns (bool);

    function V2_ROUTER() external view returns (address);

    function V3_ROUTER() external view returns (address);

    function WETH() external view returns (address);

    function getV3Pool(address _token0, address _token1, int24 _tickSpacing) external view returns (address _pool);

    function getV3Pool(address _token0, address _token1, uint24 _poolFee) external view returns (address _pool);

    function getV2Pool(address _token0, address _token1) external view returns (address _pool);

    function createV2Pool(address _token0, address _token1) external returns (address _pool);

    function getReserves(address _pool) external view returns (uint112, uint112);

    function swapV2Single(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint256 _amountOutMin,
        address _recipient
    ) external returns (uint256 _amountOut);

    function swapV2SingleExactOut(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountInMax,
        uint256 _amountOut,
        address _recipient
    ) external returns (uint256 _amountInUsed);

    function swapV3Single(
        address _tokenIn,
        address _tokenOut,
        uint24 _fee,
        uint256 _amountIn,
        uint256 _amountOutMin,
        address _recipient
    ) external returns (uint256 _amountOut);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external;

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external;
}
