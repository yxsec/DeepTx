// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IInitializeSelector {
    function initializeSelector() external view returns (bytes4);
}
