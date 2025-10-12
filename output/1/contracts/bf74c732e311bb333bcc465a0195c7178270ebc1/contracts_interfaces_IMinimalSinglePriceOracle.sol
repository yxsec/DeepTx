// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IMinimalSinglePriceOracle {
    function getPriceUSD18(
        address base,
        address quote,
        address a1, // any extra address parameter an implementation may need
        uint256 q1 // any extra uint256 parameter an implementation may need
    ) external view returns (bool isBadData, uint256 price18);
}
