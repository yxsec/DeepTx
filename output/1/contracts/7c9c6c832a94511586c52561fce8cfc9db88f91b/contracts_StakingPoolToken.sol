// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./interfaces/IDexAdapter.sol";
import "./interfaces/IInitializeSelector.sol";
import "./interfaces/IRewardsWhitelister.sol";
import "./interfaces/IProtocolFeeRouter.sol";
import "./interfaces/IStakingPoolToken.sol";
import "./TokenRewards.sol";

contract StakingPoolToken is
    Initializable,
    IInitializeSelector,
    IStakingPoolToken,
    ERC20Upgradeable,
    OwnableUpgradeable
{
    using SafeERC20 for IERC20;

    address public override INDEX_FUND;
    address public override POOL_REWARDS;

    address public override stakeUserRestriction;
    address public override stakingToken;

    IDexAdapter public DEX_ADAPTER;
    IV3TwapUtilities public V3_TWAP_UTILS;

    modifier onlyRestricted() {
        require(_msgSender() == stakeUserRestriction, "R");
        _;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(
        string memory _name,
        string memory _symbol,
        address _indexFund,
        address _stakeUserRestriction,
        bytes memory _immutables
    ) public initializer {
        __ERC20_init(_name, _symbol);
        __Ownable_init(_msgSender());

        stakeUserRestriction = _stakeUserRestriction;
        INDEX_FUND = _indexFund;

        (,,,,, address _v3TwapUtilities, address _dexAdapter) =
            abi.decode(_immutables, (address, address, address, address, address, address, address));

        DEX_ADAPTER = IDexAdapter(_dexAdapter);
        V3_TWAP_UTILS = IV3TwapUtilities(_v3TwapUtilities);
    }

    function initializeSelector() external pure override returns (bytes4) {
        return this.initialize.selector;
    }

    function stake(address _user, uint256 _amount) external override {
        require(stakingToken != address(0), "I");
        if (stakeUserRestriction != address(0)) {
            require(_user == stakeUserRestriction, "U");
        }
        _mint(_user, _amount);
        IERC20(stakingToken).safeTransferFrom(_msgSender(), address(this), _amount);
        emit Stake(_msgSender(), _user, _amount);
    }

    function unstake(uint256 _amount) external override {
        _burn(_msgSender(), _amount);
        IERC20(stakingToken).safeTransfer(_msgSender(), _amount);
        emit Unstake(_msgSender(), _amount);
    }

    function setPoolRewards(address _rewards) external onlyOwner {
        require(POOL_REWARDS == address(0), "I");
        POOL_REWARDS = _rewards;
    }

    function setStakingToken(address _stakingToken) external onlyOwner {
        require(stakingToken == address(0), "S");
        stakingToken = _stakingToken;
    }

    function removeStakeUserRestriction() external onlyRestricted {
        stakeUserRestriction = address(0);
    }

    function setStakeUserRestriction(address _user) external onlyRestricted {
        stakeUserRestriction = _user;
    }

    function _update(address _from, address _to, uint256 _value) internal override {
        super._update(_from, _to, _value);
        if (_from != address(0)) {
            TokenRewards(POOL_REWARDS).setShares(_from, _value, true);
        }
        if (_to != address(0) && _to != address(0xdead)) {
            TokenRewards(POOL_REWARDS).setShares(_to, _value, false);
        }
    }
}
