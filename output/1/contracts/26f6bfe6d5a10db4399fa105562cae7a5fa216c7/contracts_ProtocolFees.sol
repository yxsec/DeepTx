// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IProtocolFees.sol";

contract ProtocolFees is IProtocolFees, Ownable {
    uint256 public constant override DEN = 10000;

    uint256 public override yieldAdmin;
    uint256 public override yieldBurn;

    constructor() Ownable(_msgSender()) {}

    function setYieldAdmin(uint256 _yieldAdmin) external onlyOwner {
        require(_yieldAdmin <= (DEN * 20) / 100, "lte20%");
        yieldAdmin = _yieldAdmin;
        emit SetYieldAdmin(_yieldAdmin);
    }

    function setYieldBurn(uint256 _yieldBurn) external onlyOwner {
        require(_yieldBurn <= (DEN * 20) / 100, "lte20%");
        yieldBurn = _yieldBurn;
        emit SetYieldBurn(_yieldBurn);
    }
}
