// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IStakingPoolToken {
    event Stake(address indexed executor, address indexed user, uint256 amount);

    event Unstake(address indexed user, uint256 amount);

    function INDEX_FUND() external view returns (address);

    function POOL_REWARDS() external view returns (address);

    function stakingToken() external view returns (address);

    function stakeUserRestriction() external view returns (address);

    function stake(address user, uint256 amount) external;

    function unstake(uint256 amount) external;

    function setPoolRewards(address poolRewards) external;

    function setStakingToken(address stakingToken) external;
}
