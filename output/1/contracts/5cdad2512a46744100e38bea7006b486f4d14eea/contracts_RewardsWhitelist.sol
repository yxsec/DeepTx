// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IRewardsWhitelister.sol";

contract RewardsWhitelist is IRewardsWhitelister, Ownable {
    uint8 constant MAX = 12;

    mapping(address => bool) public override isWhitelistedFromDebondFee;

    mapping(address => bool) public override paused;
    mapping(address => bool) public override whitelist;
    address[] public _whitelistAry;
    mapping(address => uint256) _whitelistAryIdx;

    constructor() Ownable(_msgSender()) {}

    function getFullWhitelist() external view override returns (address[] memory) {
        return _whitelistAry;
    }

    function setWhitelistFromDebondFees(address _address, bool _isWhitelisted) external onlyOwner {
        require(isWhitelistedFromDebondFee[_address] != _isWhitelisted, "T");
        isWhitelistedFromDebondFee[_address] = _isWhitelisted;
        emit SetWhitelistFromDebondFees(_address, _isWhitelisted);
    }

    function setPaused(address _token, bool _isPaused) external onlyOwner {
        require(paused[_token] != _isPaused, "OPP");
        paused[_token] = _isPaused;
        emit PauseToken(_token, _isPaused);
    }

    function toggleRewardsToken(address _token, bool _isWhitelisted) external onlyOwner {
        require(whitelist[_token] != _isWhitelisted, "OPP");
        whitelist[_token] = _isWhitelisted;
        if (_isWhitelisted) {
            require(_whitelistAry.length < MAX, "MAX");
            _whitelistAryIdx[_token] = _whitelistAry.length;
            _whitelistAry.push(_token);
        } else {
            uint256 _idx = _whitelistAryIdx[_token];
            _whitelistAry[_idx] = _whitelistAry[_whitelistAry.length - 1];
            _whitelistAryIdx[_whitelistAry[_idx]] = _idx;
            _whitelistAry.pop();
        }
        emit ToggleToken(_token, _isWhitelisted);
    }
}
