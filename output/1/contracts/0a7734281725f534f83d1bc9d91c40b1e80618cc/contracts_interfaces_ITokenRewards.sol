// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface ITokenRewards {
    event AddShares(address indexed wallet, uint256 amount);

    event RemoveShares(address indexed wallet, uint256 amount);

    event ClaimReward(address indexed wallet);

    event DistributeReward(address indexed wallet, address indexed token, uint256 amount);

    event DepositRewards(address indexed wallet, address indexed token, uint256 amount);

    event RewardSwapError(uint256 amountIn);

    function totalShares() external view returns (uint256);

    function totalStakers() external view returns (uint256);

    function rewardsToken() external view returns (address);

    function trackingToken() external view returns (address);

    function depositFromPairedLpToken(uint256 amount) external;

    function depositRewards(address token, uint256 amount) external;

    function depositRewardsNoTransfer(address token, uint256 amount) external;

    function claimReward(address wallet) external;

    function getAllRewardsTokens() external view returns (address[] memory);

    function setShares(address wallet, uint256 amount, bool sharesRemoving) external;
}
