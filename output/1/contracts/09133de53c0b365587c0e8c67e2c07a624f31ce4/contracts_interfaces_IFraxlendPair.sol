// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/interfaces/IERC20.sol";
import {VaultAccount} from "../libraries/VaultAccount.sol";

interface IFraxlendPair is IERC20 {
    struct CurrentRateInfo {
        uint32 lastBlock;
        uint32 feeToProtocolRate; // Fee amount 1e5 precision
        uint64 lastTimestamp;
        uint64 ratePerSec;
        uint64 fullUtilizationRate;
    }

    struct ExchangeRateInfo {
        address oracle;
        uint32 maxOracleDeviation; // % of larger number, 1e5 precision
        uint184 lastTimestamp;
        uint256 lowExchangeRate;
        uint256 highExchangeRate;
    }

    function exchangeRateInfo() external view returns (ExchangeRateInfo memory);

    function totalBorrow() external view returns (VaultAccount memory);

    function asset() external view returns (address);

    function collateralContract() external view returns (address);

    function convertToAssets(uint256 shares) external view returns (uint256 assets);

    function convertToShares(uint256 assets) external view returns (uint256 shares);

    function userCollateralBalance(address user) external view returns (uint256); // amount of collateral each user is backed

    function userBorrowShares(address user) external view returns (uint256); // represents the shares held by individuals

    function previewAddInterest()
        external
        view
        returns (
            uint256 _interestEarned,
            uint256 _feesAmount,
            uint256 _feesShare,
            CurrentRateInfo memory _newCurrentRateInfo,
            VaultAccount memory _totalAsset,
            VaultAccount memory _totalBorrow
        );

    function addInterest(bool _returnAccounting)
        external
        returns (uint256, uint256, uint256, CurrentRateInfo memory, VaultAccount memory, VaultAccount memory);

    function updateExchangeRate()
        external
        returns (bool _isBorrowAllowed, uint256 _lowExchangeRate, uint256 _highExchangeRate);

    function deposit(uint256 _amount, address _receiver) external returns (uint256 _sharesReceived);

    function redeem(uint256 _shares, address _receiver, address _owner) external returns (uint256 _amountToReturn);

    function borrowAsset(uint256 _borrowAmount, uint256 _collateralAmount, address _receiver)
        external
        returns (uint256 _shares);

    function repayAsset(uint256 _shares, address _borrower) external returns (uint256 _amountToRepay);

    function addCollateral(uint256 _collateralAmount, address _borrower) external;

    function removeCollateral(uint256 _collateralAmount, address _receiver) external;
}
