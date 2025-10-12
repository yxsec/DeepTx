// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IRewardsWhitelister {
    event PauseToken(address indexed token, bool isPaused);

    event SetWhitelistFromDebondFees(address addy, bool isWhitelisted);

    event ToggleToken(address indexed token, bool isWhitelisted);

    function isWhitelistedFromDebondFee(address addy) external view returns (bool);

    function paused(address token) external view returns (bool);

    function whitelist(address token) external view returns (bool);

    function getFullWhitelist() external view returns (address[] memory);
}
