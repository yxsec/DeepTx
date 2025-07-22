// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.10;

import {DataTypes} from "aave-v3-origin/contracts/protocol/pool/PoolStorage.sol";

library CustomInitialize {
  function _initialize(
    uint256 reservesCount,
    mapping(uint256 => address) storage _reservesList,
    mapping(address => DataTypes.ReserveData) storage _reserves
  ) internal {
    for (uint256 i = 0; i < reservesCount; i++) {
      address currentReserveAddress = _reservesList[i];
      DataTypes.ReserveData storage currentReserve = _reserves[currentReserveAddress];

      // @note The storage slot for `__deprecatedVirtualUnderlyingBalance` was deprecated in v3.4.
      //       Its purpose was effectively moved to `virtualUnderlyingBalance`. This `virtualUnderlyingBalance` slot,
      //       in turn, reuses the storage location previously occupied by the `unbacked` variable
      //       (which existed in v3.3 reserves but was removed in v3.4).
      //       Therefore, this function migrates the value from the old `__deprecatedVirtualUnderlyingBalance` slot
      //       to the new `virtualUnderlyingBalance` slot (and zeroes out the old slot).

      uint128 currentVB = currentReserve.__deprecatedVirtualUnderlyingBalance;
      if (currentVB != 0) {
        currentReserve.virtualUnderlyingBalance = currentVB;
        currentReserve.__deprecatedVirtualUnderlyingBalance = 0;
      }
    }
  }
}