// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IMinimalOracle {
    function getPrices() external view returns (bool _isBadData, uint256 _priceLow, uint256 _priceHigh);
}
