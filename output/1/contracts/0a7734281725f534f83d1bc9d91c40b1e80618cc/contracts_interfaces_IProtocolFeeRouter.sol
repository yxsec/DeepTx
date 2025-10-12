// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./IProtocolFees.sol";

interface IProtocolFeeRouter {
    function protocolFees() external view returns (IProtocolFees);
}
