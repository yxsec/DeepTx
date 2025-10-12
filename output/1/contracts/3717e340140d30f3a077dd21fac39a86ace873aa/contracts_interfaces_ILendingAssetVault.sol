// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface ILendingAssetVault {
    event DonateAssets(address indexed user, uint256 amount, uint256 newShares);

    event PayBackUsedAssets(address indexed user, uint256 amount);

    event DepositToVault(address indexed vault, uint256 assets, uint256 shares);

    event RedeemFromVault(address indexed vault, uint256 shares, uint256 assets);

    event SetMaxVaults(uint8 oldMax, uint8 newMax);

    event SetVaultWhitelist(address indexed vault, bool isWhitelisted);

    event SetLastDepEnabled(bool isEnabled);

    event SetVaultMaxAllocation(address indexed vault, uint256 allocation);

    event UpdateAssetMetadataFromVault(address indexed vault, uint256 totalAssets, uint256 assetsUtilized);

    event WhitelistDeposit(address indexed user, uint256 amount);

    event WhitelistWithdraw(address indexed user, uint256 amount);

    function vaultDeposits(address vault) external view returns (uint256);

    function vaultUtilization(address vault) external view returns (uint256);

    function vaultMaxAllocation(address vault) external view returns (uint256);

    function totalAssetsUtilized() external view returns (uint256);

    function totalAvailableAssets() external view returns (uint256);

    function totalAvailableAssetsForVault(address vault) external view returns (uint256);

    function getAllWhitelistedVaults() external returns (address[] memory);

    function whitelistUpdate(bool onlyCaller) external;

    function whitelistDeposit(uint256 amount) external;

    function whitelistWithdraw(uint256 amount) external;
}
