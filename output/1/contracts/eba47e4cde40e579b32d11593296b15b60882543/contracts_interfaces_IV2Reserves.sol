// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IV2Reserves {
    function getReserves(address _pair) external view returns (uint112 reserve0, uint112 reserve1);
}
