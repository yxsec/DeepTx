// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./IDexAdapter.sol";

interface IDecentralizedIndex is IERC20 {
    enum IndexType {
        WEIGHTED,
        UNWEIGHTED
    }

    struct Config {
        address partner;
        uint256 debondCooldown;
        bool hasTransferTax;
        bool blacklistTKNpTKNPoolV2;
    }

    // all fees: 1 == 0.01%, 10 == 0.1%, 100 == 1%
    struct Fees {
        uint16 burn;
        uint16 bond;
        uint16 debond;
        uint16 buy;
        uint16 sell;
        uint16 partner;
    }

    struct IndexAssetInfo {
        address token;
        uint256 weighting;
        uint256 basePriceUSDX96;
        address c1; // arbitrary contract/address field we can use for an index
        uint256 q1; // arbitrary quantity/number field we can use for an index
    }

    /// @notice The ```Create``` event fires when a new decentralized index has been created
    /// @param newIdx The CA of the new index contract
    /// @param wallet The creator of the new index
    event Create(address indexed newIdx, address indexed wallet);

    /// @notice The ```Initialize``` event fires when the new pod has been initialized,
    /// @notice which is at creation on some and in another txn for others (gas limits)
    /// @param wallet The wallet that initialized
    /// @param v2Pool The new UniV2 derivative pool that was created at initialization
    event Initialize(address indexed wallet, address v2Pool);

    /// @notice The ```Bond``` event fires when someone wraps into the pod which mints new pod tokens
    /// @param wallet The wallet that wrapped
    /// @param token The token that was used as a ref to wrap into, representing an underlying tkn
    /// @param amountTokensBonded Amount of underlying tkns used to wrap/bond
    /// @param amountTokensMinted Amount of new pod tokens (pTKN) minted
    event Bond(address indexed wallet, address indexed token, uint256 amountTokensBonded, uint256 amountTokensMinted);

    /// @notice The ```Debond``` event fires when someone unwraps from a pod and redeems underlying tkn(s)
    /// @param wallet The wallet that unwrapped/debond
    /// @param amountDebonded Amount of pTKNs burned/unwrapped
    event Debond(address indexed wallet, uint256 amountDebonded);

    /// @notice The ```AddLiquidity``` event fires when new liquidity (LP) for a pod is added
    /// @param wallet The wallet that added LP
    /// @param amountTokens Amount of pTKNs used for LP
    /// @param amountDAI Amount of pairedLpAsset used for LP
    event AddLiquidity(address indexed wallet, uint256 amountTokens, uint256 amountDAI);

    /// @notice The ```RemoveLiquidity``` event fires when LP is removed for a pod
    /// @param wallet The wallet that removed LP
    /// @param amountLiquidity Amount of liquidity removed
    event RemoveLiquidity(address indexed wallet, uint256 amountLiquidity);

    event SetPartner(address indexed wallet, address newPartner);

    event SetPartnerFee(address indexed wallet, uint16 newFee);

    function BOND_FEE() external view returns (uint16);

    function DEBOND_FEE() external view returns (uint16);

    function DEX_HANDLER() external view returns (IDexAdapter);

    function FLASH_FEE_AMOUNT_DAI() external view returns (uint256);

    function PAIRED_LP_TOKEN() external view returns (address);

    function config() external view returns (Config calldata);

    function fees() external view returns (Fees calldata);

    function unlocked() external view returns (uint8);

    function indexType() external view returns (IndexType);

    function created() external view returns (uint256);

    function lpStakingPool() external view returns (address);

    function lpRewardsToken() external view returns (address);

    function partner() external view returns (address);

    function isAsset(address token) external view returns (bool);

    function getAllAssets() external view returns (IndexAssetInfo[] memory);

    function getInitialAmount(address sToken, uint256 sAmount, address tToken) external view returns (uint256);

    function processPreSwapFeesAndSwap() external;

    function totalAssets() external view returns (uint256 totalManagedAssets);

    function totalAssets(address asset) external view returns (uint256 totalManagedAssets);

    function convertToShares(uint256 assets) external view returns (uint256 shares);

    function convertToAssets(uint256 shares) external view returns (uint256 assets);

    function setup() external;

    function bond(address token, uint256 amount, uint256 amountMintMin) external;

    function debond(uint256 amount, address[] memory token, uint8[] memory percentage) external;

    function addLiquidityV2(uint256 idxTokens, uint256 daiTokens, uint256 slippage, uint256 deadline)
        external
        returns (uint256);

    function removeLiquidityV2(uint256 lpTokens, uint256 minTokens, uint256 minDAI, uint256 deadline) external;

    function flash(address recipient, address token, uint256 amount, bytes calldata data) external;

    function flashMint(address recipient, uint256 amount, bytes calldata data) external;

    function setLpStakingPool(address lpStakingPool) external;
}
