// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/interfaces/IERC4626.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./interfaces/ILendingAssetVault.sol";
import "./interfaces/IFraxlendPair.sol";
import {VaultAccount, VaultAccountingLibrary} from "./libraries/VaultAccount.sol";

contract LendingAssetVault is IERC4626, ILendingAssetVault, ERC20, ERC20Permit, Ownable {
    using SafeERC20 for IERC20;
    using VaultAccountingLibrary for VaultAccount;

    uint256 constant PRECISION = 10 ** 27;

    address immutable _asset;
    uint8 immutable _decimals;
    uint256 _totalAssets;
    uint256 _totalAssetsUtilized;

    uint8 public maxVaults = 20;
    mapping(address => bool) public vaultWhitelist;
    mapping(address => uint256) public override vaultDeposits;
    mapping(address => uint256) public override vaultUtilization;
    mapping(address => uint256) public override vaultMaxAllocation;
    mapping(address => uint256) _vaultWhitelistCbr;

    address[] _vaultWhitelistAry;
    // vault address => idx in _vaultWhitelistAry
    mapping(address => uint256) _vaultWhitelistAryIdx;

    modifier onlyWhitelist() {
        require(vaultWhitelist[_msgSender()], "WL");
        _;
    }

    constructor(string memory _name, string memory _symbol, address __asset)
        ERC20(_name, _symbol)
        ERC20Permit(_name)
        Ownable(_msgSender())
    {
        _asset = __asset;
        _decimals = IERC20Metadata(__asset).decimals();
    }

    function decimals() public view override(IERC20Metadata, ERC20) returns (uint8) {
        return _decimals;
    }

    function asset() external view override returns (address) {
        return _asset;
    }

    function totalAssets() public view override returns (uint256) {
        return _totalAssets;
    }

    function totalAssetsUtilized() public view override returns (uint256) {
        return _totalAssetsUtilized;
    }

    function totalAvailableAssets() public view override returns (uint256) {
        return _totalAssets - _totalAssetsUtilized;
    }

    function getAllWhitelistedVaults() external view override returns (address[] memory) {
        return _vaultWhitelistAry;
    }

    function totalAvailableAssetsForVault(address _vault) public view override returns (uint256 _totalVaultAvailable) {
        uint256 _overallAvailable = totalAvailableAssets();

        _totalVaultAvailable =
            vaultMaxAllocation[_vault] > vaultDeposits[_vault] ? vaultMaxAllocation[_vault] - vaultDeposits[_vault] : 0;

        _totalVaultAvailable = _overallAvailable < _totalVaultAvailable ? _overallAvailable : _totalVaultAvailable;
    }

    function convertToShares(uint256 _assets) public view override returns (uint256 _shares) {
        _shares = (_assets * PRECISION) / _cbr();
    }

    function convertToAssets(uint256 _shares) public view override returns (uint256 _assets) {
        _assets = (_shares * _cbr()) / PRECISION;
    }

    function _previewConvertToShares(uint256 _assets) internal view returns (uint256 _shares) {
        _shares = (_assets * PRECISION) / _previewCbr();
    }

    function _previewConvertToAssets(uint256 _shares) internal view returns (uint256 _assets) {
        _assets = (_shares * _previewCbr()) / PRECISION;
    }

    function maxDeposit(address) external pure override returns (uint256 maxAssets) {
        maxAssets = type(uint256).max;
    }

    function previewDeposit(uint256 _assets) external view override returns (uint256 _shares) {
        _shares = _previewConvertToShares(_assets);
    }

    function deposit(uint256 _assets, address _receiver) external override returns (uint256 _shares) {
        _updateInterestAndMdInAllVaults(address(0));
        _shares = convertToShares(_assets);
        _deposit(_assets, _shares, _receiver);
    }

    function maxMint(address) external pure override returns (uint256 maxShares) {
        maxShares = type(uint256).max;
    }

    function previewMint(uint256 _shares) external view override returns (uint256 _assets) {
        _assets = _previewConvertToAssets(_shares);
    }

    function mint(uint256 _shares, address _receiver) external override returns (uint256 _assets) {
        _updateInterestAndMdInAllVaults(address(0));
        _assets = convertToAssets(_shares);
        _deposit(_assets, _shares, _receiver);
    }

    function maxWithdraw(address _owner) external view override returns (uint256 _maxAssets) {
        uint256 _totalAvailable = totalAvailableAssets();
        uint256 _ownerMax = (balanceOf(_owner) * _previewCbr()) / PRECISION;
        _maxAssets = _ownerMax > _totalAvailable ? _totalAvailable : _ownerMax;
    }

    function previewWithdraw(uint256 _assets) external view override returns (uint256 _shares) {
        _shares = _previewConvertToShares(_assets);
    }

    function withdraw(uint256 _assets, address _receiver, address _owner) external override returns (uint256 _shares) {
        _updateInterestAndMdInAllVaults(address(0));
        _shares = convertToShares(_assets);
        _withdraw(_shares, _assets, _owner, _msgSender(), _receiver);
    }

    function maxRedeem(address _owner) external view override returns (uint256 _maxShares) {
        uint256 _totalAvailableShares = _previewConvertToShares(totalAvailableAssets());
        uint256 _ownerMax = balanceOf(_owner);
        _maxShares = _ownerMax > _totalAvailableShares ? _totalAvailableShares : _ownerMax;
    }

    function previewRedeem(uint256 _shares) external view override returns (uint256 _assets) {
        return _previewConvertToAssets(_shares);
    }

    function redeem(uint256 _shares, address _receiver, address _owner) external override returns (uint256 _assets) {
        _updateInterestAndMdInAllVaults(address(0));
        _assets = convertToAssets(_shares);
        _withdraw(_shares, _assets, _owner, _msgSender(), _receiver);
    }

    /// @notice Internal function to handle asset deposits
    /// @param _assets The amount of assets to deposit
    /// @param _shares The amount of shares that will be minted
    /// @param _receiver The address that will receive the shares
    function _deposit(uint256 _assets, uint256 _shares, address _receiver) internal {
        require(_assets != 0 && _shares != 0, "M");
        _totalAssets += _assets;
        _mint(_receiver, _shares);
        IERC20(_asset).safeTransferFrom(_msgSender(), address(this), _assets);
        emit Deposit(_msgSender(), _receiver, _assets, _shares);
    }

    /// @notice Internal function to handle share withdrawals
    /// @param _shares The amount of shares to withdraw
    /// @param _assets The amount of assets to withdraw
    /// @param _owner The owner of the shares being withdrawn
    /// @param _caller The address who initiated withdrawing
    /// @param _receiver The address that will receive the assets
    function _withdraw(uint256 _shares, uint256 _assets, address _owner, address _caller, address _receiver) internal {
        if (_caller != _owner) {
            _spendAllowance(_owner, _caller, _shares);
        }
        uint256 _totalAvailable = totalAvailableAssets();
        _totalAssets -= _assets;

        require(_totalAvailable >= _assets, "AV");
        _burn(_owner, _shares);
        IERC20(_asset).safeTransfer(_receiver, _assets);
        emit Withdraw(_owner, _receiver, _receiver, _assets, _shares);
    }

    /// @notice Assumes underlying vault asset has decimals == 18
    function _previewCbr() internal view returns (uint256) {
        uint256 _supply = totalSupply();
        uint256 _previewTotalAssets = _previewAddInterestAndMdInAllVaults();
        return _supply == 0 ? PRECISION : (PRECISION * _previewTotalAssets) / _supply;
    }

    /// @notice Assumes underlying vault asset has decimals == 18
    function _cbr() internal view returns (uint256) {
        uint256 _supply = totalSupply();
        return _supply == 0 ? PRECISION : (PRECISION * _totalAssets) / _supply;
    }

    /// @notice Updates interest and metadata for all whitelisted vaults
    /// @param _vaultToExclude Address of the vault to exclude from the update
    function _updateInterestAndMdInAllVaults(address _vaultToExclude) internal {
        uint256 _l = _vaultWhitelistAry.length;
        for (uint256 _i; _i < _l; _i++) {
            address _vault = _vaultWhitelistAry[_i];
            if (_vault == _vaultToExclude) {
                continue;
            }
            (uint256 _interestEarned,,,,,) = IFraxlendPair(_vault).addInterest(false);
            if (_interestEarned > 0) {
                _updateAssetMetadataFromVault(_vault);
            }
        }
    }

    /// @notice The ```whitelistUpdate``` function updates metadata for all vaults
    /// @param _onlyCaller If true, only update the caller's vault metadata
    function whitelistUpdate(bool _onlyCaller) external override onlyWhitelist {
        if (_onlyCaller) {
            _updateAssetMetadataFromVault(_msgSender());
        } else {
            _updateInterestAndMdInAllVaults(_msgSender());
        }
    }

    /// @notice The ```whitelistWithdraw``` function is called by any whitelisted vault to withdraw assets.
    /// @param _assetAmt the amount of underlying assets to withdraw
    function whitelistWithdraw(uint256 _assetAmt) external override onlyWhitelist {
        address _vault = _msgSender();
        _updateAssetMetadataFromVault(_vault);

        // validate max after doing vault accounting above
        require(totalAvailableAssetsForVault(_vault) >= _assetAmt, "MAX");
        vaultDeposits[_vault] += _assetAmt;
        vaultUtilization[_vault] += _assetAmt;
        _totalAssetsUtilized += _assetAmt;
        IERC20(_asset).safeTransfer(_vault, _assetAmt);
        emit WhitelistWithdraw(_vault, _assetAmt);
    }

    /// @notice The ```whitelistDeposit``` function is called by any whitelisted target vault to deposit assets back into this vault.
    /// @notice need this instead of direct depositing in order to handle accounting for used assets and validation
    /// @param _assetAmt the amount of underlying assets to deposit
    function whitelistDeposit(uint256 _assetAmt) external override onlyWhitelist {
        address _vault = _msgSender();
        _updateAssetMetadataFromVault(_vault);
        vaultDeposits[_vault] -= _assetAmt > vaultDeposits[_vault] ? vaultDeposits[_vault] : _assetAmt;
        vaultUtilization[_vault] -= _assetAmt;
        _totalAssetsUtilized -= _assetAmt;
        IERC20(_asset).safeTransferFrom(_vault, address(this), _assetAmt);
        emit WhitelistDeposit(_vault, _assetAmt);
    }

    function _previewAddInterestAndMdInAllVaults() internal view returns (uint256 _previewTotalAssets) {
        _previewTotalAssets = _totalAssets;
        uint256 _l = _vaultWhitelistAry.length;
        for (uint256 _i; _i < _l; _i++) {
            address _vault = _vaultWhitelistAry[_i];
            uint256 _prevVaultCbr = _vaultWhitelistCbr[_vault];
            if (_prevVaultCbr == 0) {
                continue;
            }

            // the following effectively simulates addInterest + convertToAssets
            (,,,, VaultAccount memory _totalAsset,) = IFraxlendPair(_vault).previewAddInterest();
            uint256 _newVaultCbr = _totalAsset.toAmount(PRECISION, false);

            uint256 _vaultAssetRatioChange = _prevVaultCbr > _newVaultCbr
                ? PRECISION - ((PRECISION * _newVaultCbr) / _prevVaultCbr)
                : ((PRECISION * _newVaultCbr) / _prevVaultCbr) - PRECISION;
            uint256 _currentAssetsUtilized = vaultUtilization[_vault];
            uint256 _changeUtilizedState = (_currentAssetsUtilized * _vaultAssetRatioChange) / PRECISION;
            uint256 _newAssetsUtilized = _prevVaultCbr > _newVaultCbr
                ? _currentAssetsUtilized < _changeUtilizedState ? 0 : _currentAssetsUtilized - _changeUtilizedState
                : _currentAssetsUtilized + _changeUtilizedState;
            _previewTotalAssets = _previewTotalAssets - _currentAssetsUtilized + _newAssetsUtilized;
        }
    }

    /// @notice The ```_updateAssetMetadataFromVault``` function updates _totalAssets based on  the current ratio
    /// @notice of assets in the target vault to previously recorded ratio
    /// @notice to correctly calculate the change in total assets here based on how the vault share
    /// @notice has changed over time
    /// @param _vault the vault we're adjusting _totalAssets from based on it's CBR updates from last check
    function _updateAssetMetadataFromVault(address _vault) internal {
        uint256 _prevVaultCbr = _vaultWhitelistCbr[_vault];
        _vaultWhitelistCbr[_vault] = IERC4626(_vault).convertToAssets(PRECISION);
        if (_prevVaultCbr == 0) {
            return;
        }
        uint256 _vaultAssetRatioChange = _prevVaultCbr > _vaultWhitelistCbr[_vault]
            ? PRECISION - ((PRECISION * _vaultWhitelistCbr[_vault]) / _prevVaultCbr)
            : ((PRECISION * _vaultWhitelistCbr[_vault]) / _prevVaultCbr) - PRECISION;

        uint256 _currentAssetsUtilized = vaultUtilization[_vault];
        uint256 _changeUtilizedState = (_currentAssetsUtilized * _vaultAssetRatioChange) / PRECISION;
        vaultUtilization[_vault] = _prevVaultCbr > _vaultWhitelistCbr[_vault]
            ? _currentAssetsUtilized < _changeUtilizedState ? 0 : _currentAssetsUtilized - _changeUtilizedState
            : _currentAssetsUtilized + _changeUtilizedState;
        _totalAssetsUtilized = _totalAssetsUtilized - _currentAssetsUtilized + vaultUtilization[_vault];
        _totalAssets = _totalAssets - _currentAssetsUtilized + vaultUtilization[_vault];
        emit UpdateAssetMetadataFromVault(_vault, _totalAssets, _totalAssetsUtilized);
    }

    /// @notice The ```depositToVault``` function deposits assets to a specific vault
    /// @param _vault The vault to deposit assets to
    /// @param _amountAssets The amount of assets to deposit
    function depositToVault(address _vault, uint256 _amountAssets) external onlyOwner {
        require(_amountAssets > 0);
        _updateAssetMetadataFromVault(_vault);
        IERC20(_asset).safeIncreaseAllowance(_vault, _amountAssets);
        uint256 _amountShares = IERC4626(_vault).deposit(_amountAssets, address(this));
        require(totalAvailableAssetsForVault(_vault) >= _amountAssets, "MAX");
        vaultDeposits[_vault] += _amountAssets;
        vaultUtilization[_vault] += _amountAssets;
        _totalAssetsUtilized += _amountAssets;
        emit DepositToVault(_vault, _amountAssets, _amountShares);
    }

    /// @notice The ```redeemFromVault``` function redeems shares from a specific vault
    /// @param _vault The vault to redeem shares from
    /// @param _amountShares The amount of shares to redeem (0 for all)
    function redeemFromVault(address _vault, uint256 _amountShares) external onlyOwner {
        _updateAssetMetadataFromVault(_vault);
        _amountShares = _amountShares == 0 ? IERC20(_vault).balanceOf(address(this)) : _amountShares;
        uint256 _amountAssets = IERC4626(_vault).redeem(_amountShares, address(this), address(this));
        uint256 _redeemAmt = vaultUtilization[_vault] < _amountAssets ? vaultUtilization[_vault] : _amountAssets;
        vaultDeposits[_vault] -= _redeemAmt > vaultDeposits[_vault] ? vaultDeposits[_vault] : _redeemAmt;
        vaultUtilization[_vault] -= _redeemAmt;
        _totalAssetsUtilized -= _redeemAmt;
        emit RedeemFromVault(_vault, _amountShares, _redeemAmt);
    }

    /// @notice Set the maximum number of vaults allowed
    /// @param _newMax The new maximum number of vaults
    function setMaxVaults(uint8 _newMax) external onlyOwner {
        uint8 _oldMax = maxVaults;
        maxVaults = _newMax;
        emit SetMaxVaults(_oldMax, _newMax);
    }

    /// @notice Add or remove a vault from the whitelist
    /// @param _vault The vault to update
    /// @param _allowed True to add to whitelist, false to remove
    function setVaultWhitelist(address _vault, bool _allowed) external onlyOwner {
        require(vaultWhitelist[_vault] != _allowed, "T");
        vaultWhitelist[_vault] = _allowed;
        if (_allowed) {
            require(_vaultWhitelistAry.length < maxVaults, "M");
            _vaultWhitelistAryIdx[_vault] = _vaultWhitelistAry.length;
            _vaultWhitelistAry.push(_vault);
        } else {
            uint256 _idx = _vaultWhitelistAryIdx[_vault];
            address _movingVault = _vaultWhitelistAry[_vaultWhitelistAry.length - 1];
            _vaultWhitelistAry[_idx] = _movingVault;
            _vaultWhitelistAryIdx[_movingVault] = _idx;

            // clean up state
            _vaultWhitelistAry.pop();
            delete _vaultWhitelistAryIdx[_vault];
            delete vaultMaxAllocation[_vault];
        }
        emit SetVaultWhitelist(_vault, _allowed);
    }

    /// @notice The ```setVaultMaxAllocation``` function sets the maximum amount of vault assets allowed to be allocated to a whitelisted vault
    /// @param _vaults the vaults we're allocating to
    /// @param _allocation the allocation of assets available to these vaults
    function setVaultMaxAllocation(address[] memory _vaults, uint256[] memory _allocation) external onlyOwner {
        require(_vaults.length == _allocation.length, "SL");
        _updateInterestAndMdInAllVaults(address(0));
        for (uint256 _i; _i < _vaults.length; _i++) {
            address _vault = _vaults[_i];
            uint256 _allo = _allocation[_i];
            vaultMaxAllocation[_vault] = _allo;
            emit SetVaultMaxAllocation(_vault, _allo);
        }
    }
}
