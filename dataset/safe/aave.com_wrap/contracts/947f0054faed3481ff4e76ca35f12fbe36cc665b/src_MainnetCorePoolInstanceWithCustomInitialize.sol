// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.10;

import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {IScaledBalanceToken} from "aave-v3-origin/contracts/interfaces/IScaledBalanceToken.sol";
import {PoolInstance} from "aave-v3-origin/contracts/instances/PoolInstance.sol";
import {Errors} from "aave-v3-origin/contracts/protocol/libraries/helpers/Errors.sol";
import {IPoolAddressesProvider} from "aave-v3-origin/contracts/interfaces/IPoolAddressesProvider.sol";
import {IReserveInterestRateStrategy} from "aave-v3-origin/contracts/interfaces/IReserveInterestRateStrategy.sol";
import {DataTypes} from "aave-v3-origin/contracts/protocol/pool/Pool.sol";
import {ReserveConfiguration} from "aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol";

import {AaveV3EthereumAssets, AaveV3Ethereum} from "aave-address-book/AaveV3Ethereum.sol";

import {CustomInitialize} from "./CustomInitialize.sol";

contract MainnetCorePoolInstanceWithCustomInitialize is PoolInstance {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  constructor(IPoolAddressesProvider provider, IReserveInterestRateStrategy interestRateStrategy_)
    PoolInstance(provider, interestRateStrategy_)
  {}

  /// @inheritdoc PoolInstance
  function initialize(IPoolAddressesProvider provider) external virtual override initializer {
    require(provider == ADDRESSES_PROVIDER, Errors.InvalidAddressesProvider());

    CustomInitialize._initialize(_reservesCount, _reservesList, _reserves);

    // 1. Explicitly activate the virtual account feature in the GHO reserve's configuration.
    //    Although virtual accounting is standard for all reserves in v3.4,
    //    this call ensures the specific configuration bit for GHO is set to true.
    DataTypes.ReserveData storage ghoReserveData = _reserves[AaveV3EthereumAssets.GHO_UNDERLYING];
    DataTypes.ReserveConfigurationMap memory ghoConfig = ghoReserveData.configuration;

    ghoConfig.setVirtualAccActive();

    ghoReserveData.configuration = ghoConfig;

    // 2. Initialize `accruedToTreasury` for the GHO reserve.
    //    Due to GHO's reserve factor being set to 100%, this `accruedToTreasury` variable must
    //    capture the entirety of historical GHO interest that has accrued on currently active
    //    (outstanding) loans and is payable to the treasury.
    //
    //    Understanding the state and component values for this calculation:
    //    - `vTokenTotalSupply` (GHO): This represents the total outstanding GHO variable debt. It is the sum of all
    //      currently active (outstanding) GHO principal amounts borrowed by users, plus all interest that has accrued
    //      on this outstanding principal up to this moment.
    //
    //    - `ghoPrincipalComponent`:
    //      This value represents the total *outstanding* GHO principal that was originally minted and backed by the old GHO AToken
    //      facilitator mechanism and is currently borrowed by users. Here's its derivation:
    //        a) In `UpgradePayloadMainnet` (step 2), `levelFromOldFacilitator` was fetched. This `level` was the net GHO
    //           minted by the old GHO AToken facilitator that is still outstanding (i.e., not yet repaid by users and subsequently burned by the facilitator mechanism),
    //           effectively representing the total *currently outstanding* GHO principal borrowed by users under that original facilitation mechanism.
    //        b) In `UpgradePayloadMainnet` (step 6), the new `FACILITATOR` (GhoDirectMinter) minted GHO equal to this
    //           `levelFromOldFacilitator` and supplied it to the Pool, receiving an equivalent amount of GHO ATokens (`aGHO`).
    //        c) These `aGHO` tokens are now held by the `FACILITATOR`, and their `scaledTotalSupply` (assuming GHO liquidity
    //           index is 1 RAY) equals `levelFromOldFacilitator`.
    //      Thus, `ghoPrincipalComponent` accurately reflects the total principal portion of the *currently outstanding* GHO debt.
    //
    uint256 vTokenTotalSupply = IERC20(ghoReserveData.variableDebtTokenAddress).totalSupply();
    uint256 ghoPrincipalComponent = IScaledBalanceToken(AaveV3EthereumAssets.GHO_A_TOKEN).scaledTotalSupply();

    // Calculation for `accruedToTreasury`:
    //   Total Outstanding GHO Debt (vTokenTotalSupply) = (Total Outstanding GHO Principal Borrowed by Users) + (Total Accrued GHO Interest on Outstanding Principal)
    //   GHO Principal Component (ghoPrincipalComponent) = (Total Outstanding GHO Principal Borrowed by Users)
    //
    //   Therefore: `accruedToTreasury` = `vTokenTotalSupply` - `ghoPrincipalComponent`
    //                                 = (Total Accrued GHO Interest on Outstanding Principal).
    //
    // This calculation assumes GHO's liquidity index is effectively 1 RAY (1e27). If the index is 1 RAY,
    // `scaledTotalSupply()` of GHO AToken directly represents the actual GHO token amount for the principal.
    // The 100% reserve factor for GHO helps maintain this stable index.
    ghoReserveData.accruedToTreasury = uint128(vTokenTotalSupply - ghoPrincipalComponent);
  }
}
