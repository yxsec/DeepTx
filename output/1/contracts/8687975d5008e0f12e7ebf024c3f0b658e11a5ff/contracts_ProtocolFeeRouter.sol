// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IProtocolFees.sol";
import "./interfaces/IProtocolFeeRouter.sol";

contract ProtocolFeeRouter is IProtocolFeeRouter, Ownable {
    event SetProtocolFees(address newProtocolFees, address oldProtocolFees);

    IProtocolFees public override protocolFees;

    constructor(IProtocolFees _fees) Ownable(_msgSender()) {
        protocolFees = _fees;
    }

    function setProtocolFees(IProtocolFees _protocolFees) external onlyOwner {
        address _oldFees = address(protocolFees);
        protocolFees = _protocolFees;
        emit SetProtocolFees(address(_protocolFees), _oldFees);
    }
}
