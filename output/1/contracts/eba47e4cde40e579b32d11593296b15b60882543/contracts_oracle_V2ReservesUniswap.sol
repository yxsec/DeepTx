// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import "../interfaces/IUniswapV2Pair.sol";
import "../interfaces/IV2Reserves.sol";

contract V2ReservesUniswap is IV2Reserves {
    function getReserves(address _pair) external view virtual override returns (uint112 _reserve0, uint112 _reserve1) {
        (_reserve0, _reserve1,) = IUniswapV2Pair(_pair).getReserves();
    }
}
