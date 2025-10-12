// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/interfaces/IERC4626.sol";
import "./spTKNMinimalOracle.sol";

contract aspTKNMinimalOracle is spTKNMinimalOracle {
    address public immutable ASP_TKN; // QUOTE_TOKEN

    constructor(address _aspTKN, bytes memory _requiredImmutables, bytes memory _optionalImmutables)
        spTKNMinimalOracle(_requiredImmutables, _optionalImmutables)
    {
        ASP_TKN = _aspTKN;
    }

    function getPrices()
        public
        view
        virtual
        override
        returns (bool _isBadData, uint256 _priceLow, uint256 _priceHigh)
    {
        uint256 _assetFactor = 10 ** 18;
        uint256 _aspTknPerSpTkn = IERC4626(ASP_TKN).convertToShares(_assetFactor);
        (_isBadData, _priceLow, _priceHigh) = super.getPrices();
        _priceLow = (_priceLow * _aspTknPerSpTkn) / _assetFactor;
        _priceHigh = (_priceHigh * _aspTknPerSpTkn) / _assetFactor;
    }
}
