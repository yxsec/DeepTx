// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title            Decompiled Contract
/// @author           Jonathan Becker <jonathan@jbecker.dev>
/// @custom:version   heimdall-rs v0.9.0
///
/// @notice           This contract was decompiled using the heimdall-rs decompiler.
///                     It was generated directly by tracing the EVM opcodes from this contract.
///                     As a result, it may not compile or even be valid solidity code.
///                     Despite this, it should be obvious what each function does. Overall
///                     logic should have been preserved throughout decompiling.
///
/// @custom:github    You can find the open-source decompiler here:
///                       https://heimdall.rs

contract DecompiledContract {
    uint256 public constant DEPLOYER_ADDRESS = 1004653508942922348147269796343867106697228823751;
    bytes public constant version = 000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
    uint256 public constant EXCHANGE_PRECISION = 1000000000000000000;
    uint256 public constant FEE_PRECISION = 100000;
    bytes public constant getConstants = 00000000000000000000000000000000000000000000000000000000000186a000000000000000000000000000000000000000000000000000000000000186a000000000000000000000000000000000000000000000000000000000000186a000000000000000000000000000000000000000000000000000000000000186a00000000000000000000000000000000000000000000000000de0b6b3a764000000000000000000000000000000000000000000000000000000000000000186a00000000000000000000000000000000000000000000000000de0b6b3a7640000000000000000000000000000000000000000000000000000000000000000c350;
    uint256 public constant DEVIATION_PRECISION = 100000;
    uint256 public constant MAX_PROTOCOL_FEE = 50000;
    uint256 public constant asset = 917551056842671309452305380979543736893630245704;
    uint256 public constant UTIL_PREC = 100000;
    uint256 public constant RATE_PRECISION = 1000000000000000000;
    uint256 public constant LTV_PRECISION = 100000;
    uint256 public constant decimals = 6;
    uint256 public constant LIQ_PRECISION = 100000;
    uint256 public constant collateralContract = 832453195341744657178941682103471079338578755659;
    
    bytes32 store_u;
    uint256 public maxLTV;
    mapping(bytes32 => bytes32) storage_map_al;
    bytes32 store_m;
    address public pendingTimelockAddress;
    bytes32 store_n;
    mapping(bytes32 => bytes32) storage_map_ak;
    mapping(bytes32 => bytes32) storage_map_j;
    address public timelockAddress;
    address public unresolved_8da5cb5b;
    bytes32 unresolved_8da5cb5bg;
    uint256 public unresolved_1956473f;
    bytes public currentRateInfo;
    address public pendingOwner;
    address public totalSupply;
    bytes public totalBorrow;
    uint256 store_h;
    bytes32 store_l;
    bool public isInterestAccessControlRevoked;
    uint256 store_i;
    mapping(bytes32 => bytes32) storage_map_x;
    uint256 public unresolved_37500763;
    uint256 public dirtyLiquidationFee;
    address public rateContract;
    bytes32 store_d;
    uint256 public protocolLiquidationFee;
    mapping(bytes32 => bytes32) storage_map_v;
    mapping(bytes32 => bytes32) storage_map_ah;
    bytes public exchangeRateInfo;
    uint256 public borrowLimit;
    bool public isBorrowAccessControlRevoked;
    uint256 public totalCollateral;
    mapping(bytes32 => bytes32) storage_map_ad;
    mapping(bytes32 => bytes32) storage_map_t;
    bool public isOracleSetterRevoked;
    uint256 public cleanLiquidationFee;
    address public circuitBreakerAddress;
    uint256 public depositLimit;
    address public unresolved_7bcad14c;
    
    event SetMaxLTV(uint256, uint256);
    event ChangeFee(uint32);
    event RevokeOracleInfoSetter();
    event RevokeLiquidationFeeSetter();
    error BadProtocolFee();
    event SetLiquidationFees(uint256, uint256, uint256, uint256, uint256, uint256);
    event AddInterest(uint256, uint256, uint256, uint256);
    event TimelockTransferred(address, address);
    event Event_b0a2e5eb();
    event Approval(address, address, uint256);
    event RevokeMaxLTVSetter();
    event UpdateRate(uint256, uint256, uint256, uint256);
    event SetSwapper(address, bool);
    event SetCircuitBreaker(address, address);
    event Transfer(address, address, uint256);
    event SetOracleInfo(address, uint32, address, uint32);
    event RevokeRateContractSetter();
    event Event_479ca0b7();
    event Event_555b230d();
    event PauseInterest(bool);
    event OwnershipTransferStarted(address, address);
    event SetRateContract(address, address);
    event TimelockTransferStarted(address, address);
    event OwnershipTransferred(address, address);
    
    /// @custom:selector    0xbc410c64
    /// @custom:signature   Unresolved_bc410c64(uint256 arg0) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function Unresolved_bc410c64(uint256 arg0) public payable {
        require(msg.sender == (address(unresolved_8da5cb5b)), CustomError_6f545269());
        require(!(!msg.sender == (address(timelockAddress))), CustomError_6f545269());
        var_a = 0x6f54526900000000000000000000000000000000000000000000000000000000;
        require(!(arg0 > 0x0186a0), CustomError_17d28ed0());
        var_a = 0x17d28ed000000000000000000000000000000000000000000000000000000000;
        unresolved_1956473f = arg0;
        uint256 var_a = arg0;
        emit Event_b0a2e5eb(arg0);
    }
    
    /// @custom:selector    0xd41ddc96
    /// @custom:signature   removeCollateral(uint256 arg0, address arg1) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function removeCollateral(uint256 arg0, address arg1) public payable {
        require(arg1 == (address(arg1)));
        require(store_d - 0x02, "ReentrancyGuard: reentrant call");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x1f;
        var_d = 0x5265656e7472616e637947756172643a207265656e7472616e742063616c6c00;
        store_d = 0x02;
        require(address(arg1));
        uint256 var_e = var_e + 0xa0;
        uint256 var_a = 0;
        uint256 var_f = 0;
        uint256 var_g = 0;
        uint256 var_h = 0;
        uint256 var_i = 0;
        var_e = var_e + 0xa0;
        uint32 var_j = uint32(currentRateInfo);
        uint32 var_k = uint32(currentRateInfo / 0x0100000000);
        uint64 var_l = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_m = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_o = address(totalSupply);
        address var_p = address(totalSupply / 0x0100000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_q = address(totalBorrow);
        address var_r = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(!0x01);
        require(!(address(var_e.length) - (address(var_e.length))) > 0xffffffffffffffffffffffffffffffff);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!address(var_e.length - (var_e.length)));
        require(address(totalBorrow) == ((address(totalBorrow) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(var_e.length - (var_e.length)));
        store_h = (address(totalBorrow) * 0x0186a0) / (address(var_e.length - (var_e.length)));
        var_e = 0x0100 + var_e;
        uint256 var_u = 0;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = 0;
        uint256 var_y = 0;
        uint256 var_z = 0;
        var_e = 0x40 + var_e;
        uint256 var_aa = 0;
        uint256 var_ab = 0;
        uint256 var_ac = var_e;
        var_e = 0x40 + var_e;
        uint256 var_ad = 0;
        uint256 var_ae = 0;
        uint256 var_af = var_e;
        require(uint64(var_ag) == block.timestamp);
        require(uint64(var_ag) == block.timestamp);
        require(!var_e.length);
        uint256 var_ah = uint64(var_ai);
        uint256 var_aj = uint64(var_ak);
        uint256 var_al = uint64(var_am);
        uint256 var_an = uint64(var_ag);
        emit UpdateRate(uint64(var_ai), uint64(var_ak), uint64(var_am), uint64(var_ag));
        var_ah = var_ai;
        var_aj = uint64(var_am);
        var_al = var_ak;
        var_an = var_ao;
        emit AddInterest(var_ai, uint64(var_am), var_ak, var_ao);
        var_m = uint64(var_am);
        var_n = uint64(var_ap);
        var_l = uint64(block.timestamp);
        var_j = uint32(block.number);
        currentRateInfo = (uint64(var_ap) * 0x01000000000000000000000000000000000000000000000000) | (uint192((0x0100000000000000000000000000000000 * (uint64(var_am))) | ((uint64(block.timestamp) * 0x010000000000000000) | (address((uint32(var_am) * 0x0100000000) | (uint32(block.number) | (currentRateInfo)))))));
        totalSupply = (0x0100000000000000000000000000000000 * (address(var_aq))) | (address(var_ar));
        totalBorrow = (0x0100000000000000000000000000000000 * (address(var_as))) | (address(var_at));
        require(!var_ao);
        require(address(this));
        require(!store_i > (var_ao + store_i));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        store_i = (var_ao) + store_i;
        address var_s = address(this);
        uint256 var_au = 0x0a;
        storage_map_j[var_s] = (var_ao) + storage_map_j[var_s];
        var_ah = var_ao;
        emit Transfer(0, address(this), var_ao);
        var_s = msg.sender;
        var_au = 0x23;
        require(!storage_map_j[var_s]);
        var_e = var_e + 0xa0;
        var_ah = address(exchangeRateInfo);
        var_aj = uint32(exchangeRateInfo / 0x010000000000000000000000000000000000000000);
        var_al = uint184(store_l);
        var_an = store_m;
        uint256 var_av = store_n;
        require(block.timestamp == (uint184(store_l)));
        require(!(var_aw - (var_ax)) > (var_aw));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        uint256 var_ay = 0xbd9a548b00000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(var_az).getPrices(var_ba); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        if (!((var_e + ret0.length) - var_e) < 0x60) {
            require(!((var_e + ret0.length) - var_e) < 0x60);
            require(var_e.length == var_e.length);
        }
        var_ah = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_bb = 0x20;
        var_bc = 0x1f;
        var_bd = 0x45524332303a206d696e7420746f20746865207a65726f206164647265737300;
        var_u = 0x01;
        var_e = 0x40 + var_e;
        var_ah = address(totalSupply);
        var_aj = address(totalSupply / 0x0100000000000000000000000000000000);
        var_ac = var_e;
        var_e = 0x40 + var_e;
        var_al = address(totalBorrow);
        var_an = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_af = var_e;
        require(!(block.timestamp - (uint64(var_ap))) > block.timestamp);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(unresolved_7bcad14c));
        var_av = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        address var_be = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_be, var_ba); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x20);
        require(!(address(var_ar)) > (var_e.length + (address(var_ar))));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!var_e.length + (address(var_bf)));
        var_ay = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_ba = block.timestamp - (uint64(var_ap));
        uint256 var_bg = 0;
        uint256 var_bh = uint64(var_aw);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ba); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x40);
        require(var_e.length == (uint64(var_e.length)));
        require(address(var_at) == ((address(var_at) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(var_e.length + (address(var_bf)));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_ay = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ba = block.timestamp - (uint64(var_ap));
        var_bg = (address(var_at) * 0x0186a0) / (var_e.length + (address(var_bf)));
        var_bh = uint64(var_aw);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ba); // staticcall
        require(!address(var_ar));
        var_av = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_be = block.timestamp - (uint64(var_ap));
        var_ba = 0;
        var_bg = uint64(var_aw);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_be, var_ba); // staticcall
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_a = 0x1e4ec46b00000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x08a0c375
    /// @custom:signature   setMaxLTV(uint256 arg0) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function setMaxLTV(uint256 arg0) public payable {
        require(msg.sender == (address(timelockAddress)), CustomError_1c0be90a());
        var_a = 0x1c0be90a00000000000000000000000000000000000000000000000000000000;
        require(!(bytes1(isOracleSetterRevoked / 0x0100)), CustomError_8c34a9b8());
        var_a = 0x8c34a9b800000000000000000000000000000000000000000000000000000000;
        var_a = maxLTV;
        uint256 var_b = arg0;
        emit SetMaxLTV(maxLTV, arg0);
        maxLTV = arg0;
    }
    
    /// @custom:selector    0xd905777e
    /// @custom:signature   maxRedeem(address arg0) public payable returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function maxRedeem(address arg0) public payable returns (uint256) {
        require(arg0 == (address(arg0)));
        if (!isInterestAccessControlRevoked / 0x01000000) {
            uint256 var_a = 0;
            return 0;
            uint256 var_b = var_b + 0xa0;
            var_a = 0;
            uint256 var_c = 0;
            uint256 var_d = 0;
            uint256 var_e = 0;
            uint256 var_f = 0;
            var_b = 0x40 + var_b;
            uint256 var_g = 0;
            uint256 var_h = 0;
            var_b = 0x40 + var_b;
            uint256 var_i = 0;
            uint256 var_j = 0;
            var_b = var_b + 0xa0;
            uint32 var_k = uint32(currentRateInfo);
            uint32 var_l = uint32(currentRateInfo / 0x0100000000);
            uint64 var_m = uint64(currentRateInfo / 0x010000000000000000);
            uint64 var_n = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
            uint64 var_o = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
            var_b = 0x0100 + var_b;
            uint256 var_p = 0;
            uint256 var_q = 0;
            uint256 var_r = 0;
            uint256 var_s = 0;
            uint256 var_t = 0;
            uint256 var_u = 0;
            var_b = 0x40 + var_b;
            uint256 var_v = 0;
            uint256 var_w = 0;
            uint256 var_x = var_b;
            var_b = 0x40 + var_b;
            uint256 var_y = 0;
            uint256 var_z = 0;
            uint256 var_aa = var_b;
            if (uint64(var_ab) == block.timestamp) {
                if (uint64(var_ab) == block.timestamp) {
                    require(!bytes1(isInterestAccessControlRevoked / 0x01000000));
                    var_n = uint64(var_ac);
                    var_o = uint64(var_ad);
                    require(uint64(var_ab) == block.timestamp);
                    require(uint64(var_ab) == block.timestamp);
                    uint256 var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                    uint256 var_af = 0x11;
                    require(!var_b.length);
                    require(!0x01);
                    var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                    var_af = 0x11;
                    require(!(address(var_ag) - (address(var_ah))) > 0xffffffffffffffffffffffffffffffff);
                    require(0 - (address(var_ag)));
                    require(address(var_ai) == (address(var_ai) * (address(var_ag - (var_ah))) / (address(var_ag - (var_ah)))) | (!address(var_ag - (var_ah))));
                    var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                    var_af = 0x11;
                    require(address(var_ag));
                    require(!0);
                    require(address(var_aj) == (address(var_aj) * (address(var_ai) * (address(var_ag - (var_ah))) / (address(var_ag))) / (address(var_ai) * (address(var_ag - (var_ah))) / (address(var_ag)))) | (!(address(var_ai) * (address(var_ag - (var_ah)))) / (address(var_ag))));
                    var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                    var_af = 0x11;
                    require(address(var_ak));
                    var_ae = address(arg0);
                    uint256 var_al = 0x0a;
                    require(!(address(var_aj) * (address(var_ai) * (address(var_ag - (var_ah))) / (address(var_ag))) / (address(var_ak))) < (address(var_ag - (var_ah))));
                    uint256 var_am = (address(var_ai) * (address(var_ag - (var_ah))) / (address(var_ag))) + 0x01;
                    return (address(var_ai) * (address(var_ag - (var_ah))) / (address(var_ag))) + 0x01;
                    var_am = storage_map_t[var_ae];
                    return storage_map_t[var_ae];
                    require(!0x01 > (address(var_ai) * (address(var_ag - (var_ah))) / (address(var_ag)) + 0x01));
                }
            }
            var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_af = 0x12;
            var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_af = 0x12;
            require((address(var_ai) * (address(var_ag - (var_ah))) / (address(var_ag)) + 0x01) < storage_map_t[var_ae]);
        }
        require(address(unresolved_7bcad14c));
        var_am = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_an = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_an); // staticcall
        var_b = var_b + (uint248(ret0.length + 0x1f));
        require(!((var_b + ret0.length) - var_b) < 0x20);
        require(!(address(var_ag)) > (var_b.length + (address(var_ag))));
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_af = 0x11;
        require(!((var_b.length + (address(var_ao))) - (address(var_ap))) > (var_b.length + (address(var_ao))));
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_af = 0x11;
        var_p = 0x01;
        var_b = 0x40 + var_b;
        var_am = address(totalSupply);
        uint256 var_aq = address(totalSupply / 0x0100000000000000000000000000000000);
        var_x = var_b;
        var_b = 0x40 + var_b;
        uint256 var_ar = address(totalBorrow);
        uint256 var_as = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_aa = var_b;
        require(!(block.timestamp - (uint64(var_ad))) > block.timestamp);
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_af = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_at = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_au = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_au); // staticcall
        var_b = var_b + (uint248(ret0.length + 0x1f));
        require(!((var_b + ret0.length) - var_b) < 0x20);
        require(!(address(var_ag)) > (var_b.length + (address(var_ag))));
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_af = 0x11;
        require(!var_b.length + (address(var_ao)));
        uint256 var_av = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_aw = block.timestamp - (uint64(var_ad));
        uint256 var_ax = 0;
        uint256 var_ay = uint64(var_az);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_aw); // staticcall
        var_b = var_b + (uint248(ret0.length + 0x1f));
        require(!((var_b + ret0.length) - var_b) < 0x40);
        require(var_b.length == (uint64(var_b.length)));
        require(address(var_ah) == ((address(var_ah) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_af = 0x11;
        require(var_b.length + (address(var_ao)));
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_af = 0x12;
        var_av = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_aw = block.timestamp - (uint64(var_ad));
        var_ax = (address(var_ah) * 0x0186a0) / (var_b.length + (address(var_ao)));
        var_ay = uint64(var_az);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_aw); // staticcall
        require(!address(var_ag));
        var_at = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_au = block.timestamp - (uint64(var_ad));
        var_aw = 0;
        var_ax = uint64(var_az);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_au, var_aw); // staticcall
    }
    
    /// @custom:selector    0x3d417d2d
    /// @custom:signature   repayAsset(uint256 arg0, address arg1) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function repayAsset(uint256 arg0, address arg1) public payable {
        require(arg1 == (address(arg1)));
        require(store_d - 0x02, "ReentrancyGuard: reentrant call");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x1f;
        var_d = 0x5265656e7472616e637947756172643a207265656e7472616e742063616c6c00;
        store_d = 0x02;
        require(address(arg1), CustomError_3cc383d2());
        require(!(bytes1(isInterestAccessControlRevoked / 0x0100)), CustomError_3cc383d2());
        var_a = 0x3cc383d200000000000000000000000000000000000000000000000000000000;
        uint256 var_e = var_e + 0xa0;
        uint256 var_a = 0;
        uint256 var_f = 0;
        uint256 var_g = 0;
        uint256 var_h = 0;
        uint256 var_i = 0;
        var_e = var_e + 0xa0;
        uint32 var_j = uint32(currentRateInfo);
        uint32 var_k = uint32(currentRateInfo / 0x0100000000);
        uint64 var_l = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_m = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_o = address(totalSupply);
        address var_p = address(totalSupply / 0x0100000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_q = address(totalBorrow);
        address var_r = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(!0x01, "SafeCast: value doesn't fit in 128 bits");
        require(!(address(var_e.length) - (address(var_e.length)) > 0xffffffffffffffffffffffffffffffff), "SafeCast: value doesn't fit in 128 bits");
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!(address(var_e.length - (var_e.length))), "SafeCast: value doesn't fit in 128 bits");
        require(address(totalBorrow) == ((address(totalBorrow) * 0x0186a0) / 0x0186a0) | !0x0186a0, "SafeCast: value doesn't fit in 128 bits");
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(var_e.length - (var_e.length)), "SafeCast: value doesn't fit in 128 bits");
        store_h = (address(totalBorrow) * 0x0186a0) / (address(var_e.length - (var_e.length)));
        var_e = 0x0100 + var_e;
        uint256 var_u = 0;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = 0;
        uint256 var_y = 0;
        uint256 var_z = 0;
        var_e = 0x40 + var_e;
        uint256 var_aa = 0;
        uint256 var_ab = 0;
        uint256 var_ac = var_e;
        var_e = 0x40 + var_e;
        uint256 var_ad = 0;
        uint256 var_ae = 0;
        uint256 var_af = var_e;
        require(!(!(uint64(var_ag)) == block.timestamp), "SafeCast: value doesn't fit in 128 bits");
        require(!(!(uint64(var_ag)) == block.timestamp), "SafeCast: value doesn't fit in 128 bits");
        require(!var_e.length, "SafeCast: value doesn't fit in 128 bits");
        uint256 var_ah = uint64(var_ai);
        uint256 var_aj = uint64(var_ak);
        uint256 var_al = uint64(var_am);
        uint256 var_an = uint64(var_ag);
        emit UpdateRate(uint64(var_ai), uint64(var_ak), uint64(var_am), uint64(var_ag));
        var_ah = var_ai;
        var_aj = uint64(var_am);
        var_al = var_ak;
        var_an = var_ao;
        emit AddInterest(var_ai, uint64(var_am), var_ak, var_ao);
        var_m = uint64(var_am);
        var_n = uint64(var_ap);
        var_l = uint64(block.timestamp);
        var_j = uint32(block.number);
        currentRateInfo = (uint64(var_ap) * 0x01000000000000000000000000000000000000000000000000) | (uint192((0x0100000000000000000000000000000000 * (uint64(var_am))) | ((uint64(block.timestamp) * 0x010000000000000000) | (address((uint32(var_am) * 0x0100000000) | (uint32(block.number) | (currentRateInfo)))))));
        totalSupply = (0x0100000000000000000000000000000000 * (address(var_aq))) | (address(var_ar));
        totalBorrow = (0x0100000000000000000000000000000000 * (address(var_as))) | (address(var_at));
        require(!(var_ao), "SafeCast: value doesn't fit in 128 bits");
        require(address(this), "SafeCast: value doesn't fit in 128 bits");
        require(!(store_i > (var_ao + store_i)), "SafeCast: value doesn't fit in 128 bits");
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        store_i = (var_ao) + store_i;
        address var_s = address(this);
        uint256 var_au = 0x0a;
        storage_map_j[var_s] = (var_ao) + storage_map_j[var_s];
        var_ah = var_ao;
        emit Transfer(0, address(this), var_ao);
        var_e = 0x40 + var_e;
        var_ah = address(totalBorrow);
        var_aj = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(0 - (address(var_am)), "SafeCast: value doesn't fit in 128 bits");
        require(!(arg0 > 0xffffffffffffffffffffffffffffffff), "SafeCast: value doesn't fit in 128 bits");
        var_al = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_av = 0x20;
        uint256 var_aw = 0x27;
        uint256 var_ax = 0x53616665436173743a2076616c756520646f65736e27742066697420696e2031;
        uint256 var_ay = 0x3238206269747300000000000000000000000000000000000000000000000000;
        require(!(arg0 > 0xffffffffffffffffffffffffffffffff), "SafeCast: value doesn't fit in 128 bits");
        var_al = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_av = 0x20;
        var_aw = 0x27;
        var_ax = 0x53616665436173743a2076616c756520646f65736e27742066697420696e2031;
        var_ay = 0x3238206269747300000000000000000000000000000000000000000000000000;
        var_ah = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_az = 0x20;
        var_ba = 0x1f;
        var_av = 0x45524332303a206d696e7420746f20746865207a65726f206164647265737300;
        var_u = 0x01;
        var_e = 0x40 + var_e;
        var_ah = address(totalSupply);
        var_aj = address(totalSupply / 0x0100000000000000000000000000000000);
        var_ac = var_e;
        var_e = 0x40 + var_e;
        var_al = address(totalBorrow);
        var_an = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_af = var_e;
        require(!(block.timestamp - (uint64(var_ap))) > block.timestamp);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(unresolved_7bcad14c));
        var_bb = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        var_ax = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ax); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x20);
        require(!(address(var_ar)) > (var_e.length + (address(var_ar))));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!var_e.length + (address(var_bc)));
        var_bd = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ay = block.timestamp - (uint64(var_ap));
        uint256 var_be = 0;
        uint64 var_bf = uint64(var_bg);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ay); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x40);
        require(var_e.length == (uint64(var_e.length)));
        require(address(var_at) == ((address(var_at) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(var_e.length + (address(var_bc)));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_bd = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ay = block.timestamp - (uint64(var_ap));
        var_be = (address(var_at) * 0x0186a0) / (var_e.length + (address(var_bc)));
        var_bf = uint64(var_bg);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ay); // staticcall
        require(!address(var_ar));
        var_bb = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ax = block.timestamp - (uint64(var_ap));
        var_ay = 0;
        var_be = uint64(var_bg);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ax, var_ay); // staticcall
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_a = 0x1e4ec46b00000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0xb460af94
    /// @custom:signature   Unresolved_b460af94(uint256 arg0, address arg1) public pure
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_b460af94(uint256 arg0, address arg1) public pure {
        require(arg1 == (address(arg1)));
    }
    
    /// @custom:selector    0x07a2d13a
    /// @custom:signature   convertToAssets(uint256 arg0) public payable returns (address)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function convertToAssets(uint256 arg0) public payable returns (address) {
        require(!0x01);
        uint256 var_a = 0x40 + var_a;
        address var_b = address(totalSupply);
        address var_c = address(totalSupply / 0x0100000000000000000000000000000000);
        require(0 - (address(var_d)));
        require(address(var_a.length) == ((address(var_a.length) * arg0) / arg0) | !arg0);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(address(var_g));
        require(!0);
        require(address(var_d) == (address(var_d) * ((address(var_a.length) * arg0) / (address(var_h))) / ((address(var_a.length) * arg0) / (address(var_h)))) | (!(address(var_a.length) * arg0) / (address(var_h))));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(address(var_i));
        require(!(address(var_d) * ((address(var_a.length) * arg0) / (address(var_h))) / (address(var_j))) < arg0);
        require(!0x01 > ((address(var_a.length) * arg0) / (address(var_h)) + 0x01));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        uint256 var_k = ((address(var_a.length) * arg0) / (address(var_h))) + 0x01;
        return ((address(var_a.length) * arg0) / (address(var_h))) + 0x01;
        var_k = (address(var_a.length) * arg0) / (address(var_h));
        return (address(var_a.length) * arg0) / (address(var_h));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x12;
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x12;
        var_k = arg0;
        return arg0;
        var_a = var_a + 0xa0;
        var_b = 0;
        var_c = 0;
        var_k = 0;
        uint256 var_l = 0;
        uint256 var_m = 0;
        var_a = 0x40 + var_a;
        uint256 var_n = 0;
        uint256 var_o = 0;
        var_a = 0x40 + var_a;
        uint256 var_p = 0;
        uint256 var_q = 0;
        var_a = var_a + 0xa0;
        uint32 var_r = uint32(currentRateInfo);
        uint32 var_s = uint32(currentRateInfo / 0x0100000000);
        uint64 var_t = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_u = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_v = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x0100 + var_a;
        uint256 var_w = 0;
        uint256 var_x = 0;
        uint256 var_y = 0;
        uint256 var_z = 0;
        uint256 var_aa = 0;
        uint256 var_ab = 0;
        var_a = 0x40 + var_a;
        uint256 var_ac = 0;
        uint256 var_ad = 0;
        uint256 var_ae = var_a;
        var_a = 0x40 + var_a;
        uint256 var_af = 0;
        uint256 var_ag = 0;
        uint256 var_ah = var_a;
        require(uint64(var_ai) == block.timestamp);
        require(uint64(var_ai) == block.timestamp);
        require(!var_a.length);
        var_u = uint64(var_g);
        var_v = uint64(var_aj);
        require(0 - (address(var_ak)));
        uint256 var_al = arg0;
        return arg0;
        var_w = 0x01;
        var_a = 0x40 + var_a;
        var_al = address(totalSupply);
        uint256 var_am = address(totalSupply / 0x0100000000000000000000000000000000);
        var_ae = var_a;
        var_a = 0x40 + var_a;
        uint256 var_an = address(totalBorrow);
        uint256 var_ao = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_ah = var_a;
        require(!(block.timestamp - (uint64(var_aj))) > block.timestamp);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_ap = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_aq = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_aq); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_ar)) > (var_a.length + (address(var_ar))));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(!var_a.length + (address(var_as)));
        uint256 var_at = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_au = block.timestamp - (uint64(var_aj));
        uint256 var_av = 0;
        uint256 var_aw = uint64(var_ax);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_au); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x40);
        require(var_a.length == (uint64(var_a.length)));
        require(address(var_ay) == ((address(var_ay) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(var_a.length + (address(var_as)));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x12;
        var_at = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_au = block.timestamp - (uint64(var_aj));
        var_av = (address(var_ay) * 0x0186a0) / (var_a.length + (address(var_as)));
        var_aw = uint64(var_ax);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_au); // staticcall
        require(!address(var_ar));
        var_ap = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_aq = block.timestamp - (uint64(var_aj));
        var_au = 0;
        var_av = uint64(var_ax);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_aq, var_au); // staticcall
    }
    
    /// @custom:selector    0x06fdde03
    /// @custom:signature   name() public view returns (string memory)
    function name() public view returns (string memory) {
        if (store_u) {
            if (store_u - ((store_u >> 0x01) < 0x20)) {
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x22;
                uint256 var_c = var_c + (0x20 + (((0x1f + (store_u >> 0x01)) / 0x20) * 0x20));
                bytes32 var_d = store_u >> 0x01;
                if (store_u) {
                    if (store_u - ((store_u >> 0x01) < 0x20)) {
                        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                        var_b = 0x22;
                        if (!store_u >> 0x01) {
                            if (0x1f < (store_u >> 0x01)) {
                                var_a = 0x18;
                                var_e = storage_map_v[var_a];
                                if ((0x20 + var_c) + (store_u >> 0x01) > (0x20 + (0x20 + var_c))) {
                                    var_e = 0x20;
                                    uint256 var_f = var_c.length;
                                    uint256 var_g = 0;
                                    return abi.encodePacked(0x20, var_c.length);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    /// @custom:selector    0x93f46f64
    /// @custom:signature   Unresolved_93f46f64(uint256 arg0, uint256 arg1) public pure
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function Unresolved_93f46f64(uint256 arg0, uint256 arg1) public pure {
        require(arg1 == arg1);
    }
    
    /// @custom:selector    0x23b872dd
    /// @custom:signature   Unresolved_23b872dd(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_23b872dd(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x70a08231
    /// @custom:signature   balanceOf(address arg0) public view returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function balanceOf(address arg0) public view returns (uint256) {
        require(arg0 == (address(arg0)));
        address var_a = address(arg0);
        var_b = 0x0a;
        address var_c = storage_map_v[var_a];
        return storage_map_v[var_a];
    }
    
    /// @custom:selector    0x8cad7fbe
    /// @custom:signature   swappers(address arg0) public view returns (bool)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function swappers(address arg0) public view returns (bool) {
        require(arg0 == (address(arg0)));
        var_a = 0x16;
        address var_b = arg0;
        address var_c = !(!bytes1(storage_map_x[var_b]));
        return !(!bytes1(storage_map_x[var_b]));
    }
    
    /// @custom:selector    0x7ec4b571
    /// @custom:signature   Unresolved_7ec4b571(uint256 arg0, uint256 arg1) public pure
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function Unresolved_7ec4b571(uint256 arg0, uint256 arg1) public pure {
        require(arg1 == arg1);
    }
    
    /// @custom:selector    0x0880b2f0
    /// @custom:signature   revokeLiquidationFeeSetter() public payable
    function revokeLiquidationFeeSetter() public payable {
        require(msg.sender == (address(timelockAddress)), CustomError_1c0be90a());
        var_a = 0x1c0be90a00000000000000000000000000000000000000000000000000000000;
        isOracleSetterRevoked = 0x01000000 | (uint248(isOracleSetterRevoked));
        emit RevokeLiquidationFeeSetter();
    }
    
    /// @custom:selector    0x94bf804d
    /// @custom:signature   mint(uint256 arg0, address arg1) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function mint(uint256 arg0, address arg1) public payable {
        require(arg1 == (address(arg1)));
        require(store_d - 0x02, "ReentrancyGuard: reentrant call");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x1f;
        var_d = 0x5265656e7472616e637947756172643a207265656e7472616e742063616c6c00;
        store_d = 0x02;
        require(address(arg1));
        uint256 var_e = var_e + 0xa0;
        uint256 var_a = 0;
        uint256 var_f = 0;
        uint256 var_g = 0;
        uint256 var_h = 0;
        uint256 var_i = 0;
        var_e = var_e + 0xa0;
        uint32 var_j = uint32(currentRateInfo);
        uint32 var_k = uint32(currentRateInfo / 0x0100000000);
        uint64 var_l = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_m = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_o = address(totalSupply);
        address var_p = address(totalSupply / 0x0100000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_q = address(totalBorrow);
        address var_r = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(!0x01);
        require(!(address(var_e.length) - (address(var_e.length))) > 0xffffffffffffffffffffffffffffffff);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!address(var_e.length - (var_e.length)));
        require(address(totalBorrow) == ((address(totalBorrow) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(var_e.length - (var_e.length)));
        store_h = (address(totalBorrow) * 0x0186a0) / (address(var_e.length - (var_e.length)));
        var_e = 0x0100 + var_e;
        uint256 var_u = 0;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = 0;
        uint256 var_y = 0;
        uint256 var_z = 0;
        var_e = 0x40 + var_e;
        uint256 var_aa = 0;
        uint256 var_ab = 0;
        uint256 var_ac = var_e;
        var_e = 0x40 + var_e;
        uint256 var_ad = 0;
        uint256 var_ae = 0;
        uint256 var_af = var_e;
        require(uint64(var_ag) == block.timestamp);
        require(uint64(var_ag) == block.timestamp);
        require(!var_e.length);
        uint256 var_ah = uint64(var_ai);
        uint256 var_aj = uint64(var_ak);
        uint256 var_al = uint64(var_am);
        uint256 var_an = uint64(var_ag);
        emit UpdateRate(uint64(var_ai), uint64(var_ak), uint64(var_am), uint64(var_ag));
        var_ah = var_ai;
        var_aj = uint64(var_am);
        var_al = var_ak;
        var_an = var_ao;
        emit AddInterest(var_ai, uint64(var_am), var_ak, var_ao);
        var_m = uint64(var_am);
        var_n = uint64(var_ap);
        var_l = uint64(block.timestamp);
        var_j = uint32(block.number);
        currentRateInfo = (uint64(var_ap) * 0x01000000000000000000000000000000000000000000000000) | (uint192((0x0100000000000000000000000000000000 * (uint64(var_am))) | ((uint64(block.timestamp) * 0x010000000000000000) | (address((uint32(var_am) * 0x0100000000) | (uint32(block.number) | (currentRateInfo)))))));
        totalSupply = (0x0100000000000000000000000000000000 * (address(var_aq))) | (address(var_ar));
        totalBorrow = (0x0100000000000000000000000000000000 * (address(var_as))) | (address(var_at));
        require(!var_ao);
        require(address(this));
        require(!store_i > (var_ao + store_i));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        store_i = (var_ao) + store_i;
        address var_s = address(this);
        uint256 var_au = 0x0a;
        storage_map_j[var_s] = (var_ao) + storage_map_j[var_s];
        var_ah = var_ao;
        emit Transfer(0, address(this), var_ao);
        var_e = 0x40 + var_e;
        var_ah = address(totalSupply);
        var_aj = address(totalSupply / 0x0100000000000000000000000000000000);
        require(0 - (address(var_am)));
        require(0);
        var_al = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_av = address(this);
        (bool success, bytes memory ret0) = address(0).Unresolved_22bbc2d2(var_av, var_aw); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x20);
        var_ah = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_ax = 0x20;
        uint256 var_ay = 0x1f;
        var_av = 0x45524332303a206d696e7420746f20746865207a65726f206164647265737300;
        var_u = 0x01;
        var_e = 0x40 + var_e;
        var_ah = address(totalSupply);
        var_aj = address(totalSupply / 0x0100000000000000000000000000000000);
        var_ac = var_e;
        var_e = 0x40 + var_e;
        var_al = address(totalBorrow);
        var_an = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_af = var_e;
        require(!(block.timestamp - (uint64(var_ap))) > block.timestamp);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_az = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        address var_ba = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ba); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x20);
        require(!(address(var_ar)) > (var_e.length + (address(var_ar))));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!var_e.length + (address(var_bb)));
        var_bc = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_bd = block.timestamp - (uint64(var_ap));
        uint256 var_be = 0;
        uint64 var_bf = uint64(var_bg);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_bd); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x40);
        require(var_e.length == (uint64(var_e.length)));
        require(address(var_at) == ((address(var_at) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(var_e.length + (address(var_bb)));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_bc = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_bd = block.timestamp - (uint64(var_ap));
        var_be = (address(var_at) * 0x0186a0) / (var_e.length + (address(var_bb)));
        var_bf = uint64(var_bg);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_bd); // staticcall
        require(!address(var_ar));
        var_az = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ba = block.timestamp - (uint64(var_ap));
        var_bd = 0;
        var_be = uint64(var_bg);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ba, var_bd); // staticcall
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_a = 0x1e4ec46b00000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0xb3d7f6b9
    /// @custom:signature   previewMint(uint256 arg0) public payable returns (address)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function previewMint(uint256 arg0) public payable returns (address) {
        uint256 var_a = var_a + 0xa0;
        uint256 var_b = 0;
        uint256 var_c = 0;
        uint256 var_d = 0;
        uint256 var_e = 0;
        uint256 var_f = 0;
        var_a = 0x40 + var_a;
        uint256 var_g = 0;
        uint256 var_h = 0;
        var_a = 0x40 + var_a;
        uint256 var_i = 0;
        uint256 var_j = 0;
        var_a = var_a + 0xa0;
        uint32 var_k = uint32(currentRateInfo);
        uint32 var_l = uint32(currentRateInfo / 0x0100000000);
        uint64 var_m = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_o = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x0100 + var_a;
        uint256 var_p = 0;
        uint256 var_q = 0;
        uint256 var_r = 0;
        uint256 var_s = 0;
        uint256 var_t = 0;
        uint256 var_u = 0;
        var_a = 0x40 + var_a;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = var_a;
        var_a = 0x40 + var_a;
        uint256 var_y = 0;
        uint256 var_z = 0;
        uint256 var_aa = var_a;
        require(uint64(var_ab) == block.timestamp);
        require(uint64(var_ab) == block.timestamp);
        require(!var_a.length);
        var_n = uint64(var_ac);
        var_o = uint64(var_ad);
        require(0 - (address(var_ae)));
        require(address(var_af) == ((address(var_af) * arg0) / arg0) | !arg0);
        uint256 var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        uint256 var_ah = 0x11;
        require(address(var_ai));
        require(!0x01);
        require(!0x01);
        uint256 var_aj = (address(var_af) * arg0) / (address(var_ai));
        return (address(var_af) * arg0) / (address(var_ai));
        require(!0x01 > ((address(var_af) * arg0) / (address(var_ai)) + 0x01));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        var_aj = ((address(var_af) * arg0) / (address(var_ai))) + 0x01;
        return ((address(var_af) * arg0) / (address(var_ai))) + 0x01;
        require(address(var_ae) == (address(var_ae) * ((address(var_af) * arg0) / (address(var_ai))) / ((address(var_af) * arg0) / (address(var_ai)))) | (!(address(var_af) * arg0) / (address(var_ai))));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(address(var_ak));
        require(!(address(var_ae) * ((address(var_af) * arg0) / (address(var_ai))) / (address(var_ak))) < arg0);
        var_aj = (address(var_af) * arg0) / (address(var_ai));
        return (address(var_af) * arg0) / (address(var_ai));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x12;
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x12;
        var_aj = arg0;
        return arg0;
        var_p = 0x01;
        var_a = 0x40 + var_a;
        var_aj = address(totalSupply);
        uint256 var_al = address(totalSupply / 0x0100000000000000000000000000000000);
        var_x = var_a;
        var_a = 0x40 + var_a;
        uint256 var_am = address(totalBorrow);
        uint256 var_an = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_aa = var_a;
        require(!(block.timestamp - (uint64(var_ad))) > block.timestamp);
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_ao = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_ap = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ap); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_af)) > (var_a.length + (address(var_af))));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(!var_a.length + (address(var_aq)));
        uint256 var_ar = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_as = block.timestamp - (uint64(var_ad));
        uint256 var_at = 0;
        uint256 var_au = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_as); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x40);
        require(var_a.length == (uint64(var_a.length)));
        require(address(var_aw) == ((address(var_aw) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(var_a.length + (address(var_aq)));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x12;
        var_ar = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_as = block.timestamp - (uint64(var_ad));
        var_at = (address(var_aw) * 0x0186a0) / (var_a.length + (address(var_aq)));
        var_au = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_as); // staticcall
        require(!address(var_af));
        var_ao = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ap = block.timestamp - (uint64(var_ad));
        var_as = 0;
        var_at = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ap, var_as); // staticcall
    }
    
    /// @custom:selector    0xa9059cbb
    /// @custom:signature   transfer(address arg0, uint256 arg1) public payable returns (bool)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function transfer(address arg0, uint256 arg1) public payable returns (bool) {
        require(arg0 == (address(arg0)));
        require(address(msg.sender), "ERC20: transfer amount exceeds balance");
        require(address(arg0), "ERC20: transfer amount exceeds balance");
        address var_a = address(msg.sender);
        var_b = 0x0a;
        require(!(storage_map_v[var_a] < arg1), "ERC20: transfer amount exceeds balance");
        var_c = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_d = 0x20;
        var_e = 0x26;
        var_f = 0x45524332303a207472616e7366657220616d6f756e7420657863656564732062;
        var_g = 0x616c616e63650000000000000000000000000000000000000000000000000000;
        var_a = address(msg.sender);
        var_b = 0x0a;
        storage_map_v[var_a] = storage_map_v[var_a] - arg1;
        var_a = address(arg0);
        storage_map_v[var_a] = arg1 + storage_map_v[var_a];
        uint256 var_c = arg1;
        emit Transfer(address(msg.sender), address(arg0), arg1);
        var_c = 0x01;
        return 0x01;
        var_c = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_d = 0x20;
        var_e = 0x23;
        var_f = 0x45524332303a207472616e7366657220746f20746865207a65726f2061646472;
        var_g = 0x6573730000000000000000000000000000000000000000000000000000000000;
        var_c = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_d = 0x20;
        var_e = 0x25;
        var_f = 0x45524332303a207472616e736665722066726f6d20746865207a65726f206164;
        var_g = 0x6472657373000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0xc6e6f592
    /// @custom:signature   convertToShares(uint256 arg0) public payable returns (address)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function convertToShares(uint256 arg0) public payable returns (address) {
        require(!0x01);
        uint256 var_a = 0x40 + var_a;
        address var_b = address(totalSupply);
        address var_c = address(totalSupply / 0x0100000000000000000000000000000000);
        require(0 - (address(var_a.length)));
        require(address(var_d) == ((address(var_d) * arg0) / arg0) | !arg0);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(address(var_a.length));
        require(!0);
        require(address(var_g) == (address(var_g) * ((address(var_d) * arg0) / (address(var_a.length))) / ((address(var_d) * arg0) / (address(var_a.length)))) | (!(address(var_d) * arg0) / (address(var_a.length))));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(address(var_h));
        require(!(address(var_g) * ((address(var_d) * arg0) / (address(var_a.length))) / (address(var_i))) < arg0);
        require(!0x01 > ((address(var_d) * arg0) / (address(var_a.length)) + 0x01));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        uint256 var_j = ((address(var_d) * arg0) / (address(var_a.length))) + 0x01;
        return ((address(var_d) * arg0) / (address(var_a.length))) + 0x01;
        var_j = (address(var_d) * arg0) / (address(var_a.length));
        return (address(var_d) * arg0) / (address(var_a.length));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x12;
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x12;
        var_j = arg0;
        return arg0;
        var_a = var_a + 0xa0;
        var_b = 0;
        var_c = 0;
        var_j = 0;
        uint256 var_k = 0;
        uint256 var_l = 0;
        var_a = 0x40 + var_a;
        uint256 var_m = 0;
        uint256 var_n = 0;
        var_a = 0x40 + var_a;
        uint256 var_o = 0;
        uint256 var_p = 0;
        var_a = var_a + 0xa0;
        uint32 var_q = uint32(currentRateInfo);
        uint32 var_r = uint32(currentRateInfo / 0x0100000000);
        uint64 var_s = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_t = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_u = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x0100 + var_a;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = 0;
        uint256 var_y = 0;
        uint256 var_z = 0;
        uint256 var_aa = 0;
        var_a = 0x40 + var_a;
        uint256 var_ab = 0;
        uint256 var_ac = 0;
        uint256 var_ad = var_a;
        var_a = 0x40 + var_a;
        uint256 var_ae = 0;
        uint256 var_af = 0;
        uint256 var_ag = var_a;
        require(uint64(var_ah) == block.timestamp);
        require(uint64(var_ah) == block.timestamp);
        require(!var_a.length);
        var_t = uint64(var_d);
        var_u = uint64(var_ai);
        require(0 - (address(var_aj)));
        uint256 var_ak = arg0;
        return arg0;
        var_v = 0x01;
        var_a = 0x40 + var_a;
        var_ak = address(totalSupply);
        uint256 var_al = address(totalSupply / 0x0100000000000000000000000000000000);
        var_ad = var_a;
        var_a = 0x40 + var_a;
        uint256 var_am = address(totalBorrow);
        uint256 var_an = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_ag = var_a;
        require(!(block.timestamp - (uint64(var_ai))) > block.timestamp);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_ao = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_ap = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ap); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_aj)) > (var_a.length + (address(var_aj))));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(!var_a.length + (address(var_aq)));
        uint256 var_ar = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_as = block.timestamp - (uint64(var_ai));
        uint256 var_at = 0;
        uint256 var_au = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_as); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x40);
        require(var_a.length == (uint64(var_a.length)));
        require(address(var_aw) == ((address(var_aw) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(var_a.length + (address(var_aq)));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x12;
        var_ar = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_as = block.timestamp - (uint64(var_ai));
        var_at = (address(var_aw) * 0x0186a0) / (var_a.length + (address(var_aq)));
        var_au = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_as); // staticcall
        require(!address(var_aj));
        var_ao = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ap = block.timestamp - (uint64(var_ai));
        var_as = 0;
        var_at = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ap, var_as); // staticcall
    }
    
    /// @custom:selector    0x721b0a47
    /// @custom:signature   liquidate(uint128 arg0, uint256 arg1, address arg2) public payable
    /// @param              arg0 ["address", "uint128", "bytes16", "int128"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["address", "uint160", "bytes20", "int160"]
    function liquidate(uint128 arg0, uint256 arg1, address arg2) public payable {
        require(arg0 == (address(arg0)));
        require(arg2 == (address(arg2)));
        require(store_d - 0x02, "ReentrancyGuard: reentrant call");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x1f;
        var_d = 0x5265656e7472616e637947756172643a207265656e7472616e742063616c6c00;
        store_d = 0x02;
        require(address(arg2), CustomError_6d2c35dc());
        require(!(bytes1(isInterestAccessControlRevoked / 0x010000000000)), CustomError_6d2c35dc());
        var_a = 0x6d2c35dc00000000000000000000000000000000000000000000000000000000;
        require(!block.timestamp > arg1);
        uint256 var_e = var_e + 0xa0;
        uint256 var_a = 0;
        uint256 var_f = 0;
        uint256 var_g = 0;
        uint256 var_h = 0;
        uint256 var_i = 0;
        var_e = var_e + 0xa0;
        uint32 var_j = uint32(currentRateInfo);
        uint32 var_k = uint32(currentRateInfo / 0x0100000000);
        uint64 var_l = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_m = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_o = address(totalSupply);
        address var_p = address(totalSupply / 0x0100000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_q = address(totalBorrow);
        address var_r = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(!0x01);
        require(!(address(var_e.length) - (address(var_e.length))) > 0xffffffffffffffffffffffffffffffff);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!address(var_e.length - (var_e.length)));
        require(address(totalBorrow) == ((address(totalBorrow) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(var_e.length - (var_e.length)));
        store_h = (address(totalBorrow) * 0x0186a0) / (address(var_e.length - (var_e.length)));
        var_e = 0x0100 + var_e;
        uint256 var_u = 0;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = 0;
        uint256 var_y = 0;
        uint256 var_z = 0;
        var_e = 0x40 + var_e;
        uint256 var_aa = 0;
        uint256 var_ab = 0;
        uint256 var_ac = var_e;
        var_e = 0x40 + var_e;
        uint256 var_ad = 0;
        uint256 var_ae = 0;
        uint256 var_af = var_e;
        require(uint64(var_ag) == block.timestamp);
        require(uint64(var_ag) == block.timestamp);
        require(!var_e.length);
        uint256 var_ah = uint64(var_ai);
        uint256 var_aj = uint64(var_ak);
        uint256 var_al = uint64(var_am);
        uint256 var_an = uint64(var_ag);
        emit UpdateRate(uint64(var_ai), uint64(var_ak), uint64(var_am), uint64(var_ag));
        var_ah = var_ai;
        var_aj = uint64(var_am);
        var_al = var_ak;
        var_an = var_ao;
        emit AddInterest(var_ai, uint64(var_am), var_ak, var_ao);
        var_m = uint64(var_am);
        var_n = uint64(var_ap);
        var_l = uint64(block.timestamp);
        var_j = uint32(block.number);
        currentRateInfo = (uint64(var_ap) * 0x01000000000000000000000000000000000000000000000000) | (uint192((0x0100000000000000000000000000000000 * (uint64(var_am))) | ((uint64(block.timestamp) * 0x010000000000000000) | (address((uint32(var_am) * 0x0100000000) | (uint32(block.number) | (currentRateInfo)))))));
        totalSupply = (0x0100000000000000000000000000000000 * (address(var_aq))) | (address(var_ar));
        totalBorrow = (0x0100000000000000000000000000000000 * (address(var_as))) | (address(var_at));
        require(!var_ao);
        require(address(this));
        require(!store_i > (var_ao + store_i));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        store_i = (var_ao) + store_i;
        address var_s = address(this);
        uint256 var_au = 0x0a;
        storage_map_j[var_s] = (var_ao) + storage_map_j[var_s];
        var_ah = var_ao;
        emit Transfer(0, address(this), var_ao);
        var_e = var_e + 0xa0;
        var_ah = address(exchangeRateInfo);
        var_aj = uint32(exchangeRateInfo / 0x010000000000000000000000000000000000000000);
        var_al = uint184(store_l);
        var_an = store_m;
        uint256 var_av = store_n;
        require(block.timestamp == (uint184(store_l)));
        require(!(var_aw - (var_ax)) > (var_aw));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        uint256 var_ay = 0xbd9a548b00000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(var_az).getPrices(var_ba); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        if (!((var_e + ret0.length) - var_e) < 0x60) {
            require(!((var_e + ret0.length) - var_e) < 0x60);
            require(var_e.length == var_e.length);
        }
        var_ah = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_bb = 0x20;
        var_bc = 0x1f;
        var_bd = 0x45524332303a206d696e7420746f20746865207a65726f206164647265737300;
        var_u = 0x01;
        var_e = 0x40 + var_e;
        var_ah = address(totalSupply);
        var_aj = address(totalSupply / 0x0100000000000000000000000000000000);
        var_ac = var_e;
        var_e = 0x40 + var_e;
        var_al = address(totalBorrow);
        var_an = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_af = var_e;
        require(!(block.timestamp - (uint64(var_ap))) > block.timestamp);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(unresolved_7bcad14c));
        var_av = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        address var_be = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_be, var_ba); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x20);
        require(!(address(var_ar)) > (var_e.length + (address(var_ar))));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!var_e.length + (address(var_bf)));
        var_ay = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_ba = block.timestamp - (uint64(var_ap));
        uint256 var_bg = 0;
        uint256 var_bh = uint64(var_aw);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ba); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x40);
        require(var_e.length == (uint64(var_e.length)));
        require(address(var_at) == ((address(var_at) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(var_e.length + (address(var_bf)));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_ay = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ba = block.timestamp - (uint64(var_ap));
        var_bg = (address(var_at) * 0x0186a0) / (var_e.length + (address(var_bf)));
        var_bh = uint64(var_aw);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ba); // staticcall
        require(!address(var_ar));
        var_av = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_be = block.timestamp - (uint64(var_ap));
        var_ba = 0;
        var_bg = uint64(var_aw);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_be, var_ba); // staticcall
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_a = 0x5ba2a8d500000000000000000000000000000000000000000000000000000000;
        uint256 var_b = block.timestamp;
        uint256 var_c = arg1;
        var_a = 0x1e4ec46b00000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0xe4b00070
    /// @custom:signature   revokeRateContractSetter() public payable
    function revokeRateContractSetter() public payable {
        require(msg.sender == (address(timelockAddress)), CustomError_1c0be90a());
        var_a = 0x1c0be90a00000000000000000000000000000000000000000000000000000000;
        isOracleSetterRevoked = 0x010000 | (uint248(isOracleSetterRevoked));
        emit RevokeRateContractSetter();
    }
    
    /// @custom:selector    0x6e553f65
    /// @custom:signature   Unresolved_6e553f65(uint256 arg0, address arg1) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_6e553f65(uint256 arg0, address arg1) public payable {
        require(arg1 == (address(arg1)));
        require(store_d - 0x02, "ReentrancyGuard: reentrant call");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x1f;
        var_d = 0x5265656e7472616e637947756172643a207265656e7472616e742063616c6c00;
        store_d = 0x02;
        require(address(arg1));
        uint256 var_e = var_e + 0xa0;
        uint256 var_a = 0;
        uint256 var_f = 0;
        uint256 var_g = 0;
        uint256 var_h = 0;
        uint256 var_i = 0;
        var_e = var_e + 0xa0;
        uint32 var_j = uint32(currentRateInfo);
        uint32 var_k = uint32(currentRateInfo / 0x0100000000);
        uint64 var_l = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_m = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_o = address(totalSupply);
        address var_p = address(totalSupply / 0x0100000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_q = address(totalBorrow);
        address var_r = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(!0x01);
        require(!(address(var_e.length) - (address(var_e.length))) > 0xffffffffffffffffffffffffffffffff);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!address(var_e.length - (var_e.length)));
        require(address(totalBorrow) == ((address(totalBorrow) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(var_e.length - (var_e.length)));
        store_h = (address(totalBorrow) * 0x0186a0) / (address(var_e.length - (var_e.length)));
        var_e = 0x0100 + var_e;
        uint256 var_u = 0;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = 0;
        uint256 var_y = 0;
        uint256 var_z = 0;
        var_e = 0x40 + var_e;
        uint256 var_aa = 0;
        uint256 var_ab = 0;
        uint256 var_ac = var_e;
        var_e = 0x40 + var_e;
        uint256 var_ad = 0;
        uint256 var_ae = 0;
        uint256 var_af = var_e;
        require(uint64(var_ag) == block.timestamp);
        require(uint64(var_ag) == block.timestamp);
        require(!var_e.length);
        uint256 var_ah = uint64(var_ai);
        uint256 var_aj = uint64(var_ak);
        uint256 var_al = uint64(var_am);
        uint256 var_an = uint64(var_ag);
        emit UpdateRate(uint64(var_ai), uint64(var_ak), uint64(var_am), uint64(var_ag));
        var_ah = var_ai;
        var_aj = uint64(var_am);
        var_al = var_ak;
        var_an = var_ao;
        emit AddInterest(var_ai, uint64(var_am), var_ak, var_ao);
        var_m = uint64(var_am);
        var_n = uint64(var_ap);
        var_l = uint64(block.timestamp);
        var_j = uint32(block.number);
        currentRateInfo = (uint64(var_ap) * 0x01000000000000000000000000000000000000000000000000) | (uint192((0x0100000000000000000000000000000000 * (uint64(var_am))) | ((uint64(block.timestamp) * 0x010000000000000000) | (address((uint32(var_am) * 0x0100000000) | (uint32(block.number) | (currentRateInfo)))))));
        totalSupply = (0x0100000000000000000000000000000000 * (address(var_aq))) | (address(var_ar));
        totalBorrow = (0x0100000000000000000000000000000000 * (address(var_as))) | (address(var_at));
        require(!var_ao);
        require(address(this));
        require(!store_i > (var_ao + store_i));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        store_i = (var_ao) + store_i;
        address var_s = address(this);
        uint256 var_au = 0x0a;
        storage_map_j[var_s] = (var_ao) + storage_map_j[var_s];
        var_ah = var_ao;
        emit Transfer(0, address(this), var_ao);
        var_e = 0x40 + var_e;
        var_ah = address(totalSupply);
        var_aj = address(totalSupply / 0x0100000000000000000000000000000000);
        require(0);
        var_al = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_av = address(this);
        (bool success, bytes memory ret0) = address(0).Unresolved_22bbc2d2(var_av, var_aw); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x20);
        var_ah = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_ax = 0x20;
        uint256 var_ay = 0x1f;
        var_av = 0x45524332303a206d696e7420746f20746865207a65726f206164647265737300;
        var_u = 0x01;
        var_e = 0x40 + var_e;
        var_ah = address(totalSupply);
        var_aj = address(totalSupply / 0x0100000000000000000000000000000000);
        var_ac = var_e;
        var_e = 0x40 + var_e;
        var_al = address(totalBorrow);
        var_an = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_af = var_e;
        require(!(block.timestamp - (uint64(var_ap))) > block.timestamp);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_az = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        address var_ba = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ba); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x20);
        require(!(address(var_ar)) > (var_e.length + (address(var_ar))));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!var_e.length + (address(var_bb)));
        var_bc = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_bd = block.timestamp - (uint64(var_ap));
        uint256 var_be = 0;
        uint64 var_bf = uint64(var_bg);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_bd); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x40);
        require(var_e.length == (uint64(var_e.length)));
        require(address(var_at) == ((address(var_at) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(var_e.length + (address(var_bb)));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_bc = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_bd = block.timestamp - (uint64(var_ap));
        var_be = (address(var_at) * 0x0186a0) / (var_e.length + (address(var_bb)));
        var_bf = uint64(var_bg);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_bd); // staticcall
        require(!address(var_ar));
        var_az = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ba = block.timestamp - (uint64(var_ap));
        var_bd = 0;
        var_be = uint64(var_bg);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ba, var_bd); // staticcall
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_a = 0x1e4ec46b00000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0xb5af3062
    /// @custom:signature   userCollateralBalance(address arg0) public view returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function userCollateralBalance(address arg0) public view returns (uint256) {
        require(arg0 == (address(arg0)));
        var_a = 0x22;
        address var_b = arg0;
        address var_c = storage_map_x[var_b];
        return storage_map_x[var_b];
    }
    
    /// @custom:selector    0x82beee89
    /// @custom:signature   setCircuitBreaker(address arg0) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function setCircuitBreaker(address arg0) public payable {
        require(arg0 == (address(arg0)));
        require(msg.sender == (address(timelockAddress)), CustomError_1c0be90a());
        var_a = 0x1c0be90a00000000000000000000000000000000000000000000000000000000;
        circuitBreakerAddress = (address(arg0)) | (uint96(circuitBreakerAddress));
        address var_a = address(circuitBreakerAddress);
        address var_b = address(arg0);
        emit SetCircuitBreaker(address(circuitBreakerAddress), address(arg0));
    }
    
    /// @custom:selector    0x4cdad506
    /// @custom:signature   previewRedeem(uint256 arg0) public payable returns (address)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function previewRedeem(uint256 arg0) public payable returns (address) {
        uint256 var_a = var_a + 0xa0;
        uint256 var_b = 0;
        uint256 var_c = 0;
        uint256 var_d = 0;
        uint256 var_e = 0;
        uint256 var_f = 0;
        var_a = 0x40 + var_a;
        uint256 var_g = 0;
        uint256 var_h = 0;
        var_a = 0x40 + var_a;
        uint256 var_i = 0;
        uint256 var_j = 0;
        var_a = var_a + 0xa0;
        uint32 var_k = uint32(currentRateInfo);
        uint32 var_l = uint32(currentRateInfo / 0x0100000000);
        uint64 var_m = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_o = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x0100 + var_a;
        uint256 var_p = 0;
        uint256 var_q = 0;
        uint256 var_r = 0;
        uint256 var_s = 0;
        uint256 var_t = 0;
        uint256 var_u = 0;
        var_a = 0x40 + var_a;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = var_a;
        var_a = 0x40 + var_a;
        uint256 var_y = 0;
        uint256 var_z = 0;
        uint256 var_aa = var_a;
        require(uint64(var_ab) == block.timestamp);
        require(uint64(var_ab) == block.timestamp);
        require(!var_a.length);
        var_n = uint64(var_ac);
        var_o = uint64(var_ad);
        require(0 - (address(var_ae)));
        require(address(var_af) == ((address(var_af) * arg0) / arg0) | !arg0);
        uint256 var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        uint256 var_ah = 0x11;
        require(address(var_ai));
        require(!0);
        require(address(var_ae) == (address(var_ae) * ((address(var_af) * arg0) / (address(var_ai))) / ((address(var_af) * arg0) / (address(var_ai)))) | (!(address(var_af) * arg0) / (address(var_ai))));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(address(var_aj));
        require(!(address(var_ae) * ((address(var_af) * arg0) / (address(var_ai))) / (address(var_aj))) < arg0);
        require(!0x01 > ((address(var_af) * arg0) / (address(var_ai)) + 0x01));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        uint256 var_ak = ((address(var_af) * arg0) / (address(var_ai))) + 0x01;
        return ((address(var_af) * arg0) / (address(var_ai))) + 0x01;
        var_ak = (address(var_af) * arg0) / (address(var_ai));
        return (address(var_af) * arg0) / (address(var_ai));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x12;
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x12;
        var_ak = arg0;
        return arg0;
        var_p = 0x01;
        var_a = 0x40 + var_a;
        var_ak = address(totalSupply);
        uint256 var_al = address(totalSupply / 0x0100000000000000000000000000000000);
        var_x = var_a;
        var_a = 0x40 + var_a;
        uint256 var_am = address(totalBorrow);
        uint256 var_an = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_aa = var_a;
        require(!(block.timestamp - (uint64(var_ad))) > block.timestamp);
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_ao = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_ap = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ap); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_af)) > (var_a.length + (address(var_af))));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(!var_a.length + (address(var_aq)));
        uint256 var_ar = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_as = block.timestamp - (uint64(var_ad));
        uint256 var_at = 0;
        uint256 var_au = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_as); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x40);
        require(var_a.length == (uint64(var_a.length)));
        require(address(var_aw) == ((address(var_aw) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(var_a.length + (address(var_aq)));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x12;
        var_ar = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_as = block.timestamp - (uint64(var_ad));
        var_at = (address(var_aw) * 0x0186a0) / (var_a.length + (address(var_aq)));
        var_au = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_as); // staticcall
        require(!address(var_af));
        var_ao = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ap = block.timestamp - (uint64(var_ad));
        var_as = 0;
        var_at = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ap, var_as); // staticcall
    }
    
    /// @custom:selector    0xf6ccaad4
    /// @custom:signature   acceptTransferTimelock() public payable
    function acceptTransferTimelock() public payable {
        require(msg.sender == (address(pendingTimelockAddress)), CustomError_f5c49e64());
        var_a = 0xf5c49e6400000000000000000000000000000000000000000000000000000000;
        pendingTimelockAddress = uint96(pendingTimelockAddress);
        emit TimelockTransferred(address(timelockAddress), address(msg.sender));
        timelockAddress = (address(msg.sender)) | (uint96(timelockAddress));
    }
    
    /// @custom:selector    0xe5f13b16
    /// @custom:signature   borrowAsset(uint256 arg0, uint256 arg1, address arg2) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["address", "uint160", "bytes20", "int160"]
    function borrowAsset(uint256 arg0, uint256 arg1, address arg2) public payable {
        require(arg2 == (address(arg2)));
        require(store_d - 0x02, "ReentrancyGuard: reentrant call");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x1f;
        var_d = 0x5265656e7472616e637947756172643a207265656e7472616e742063616c6c00;
        store_d = 0x02;
        require(address(arg2), "ERC20: mint to the zero address");
        uint256 var_e = var_e + 0xa0;
        uint256 var_a = 0;
        uint256 var_f = 0;
        uint256 var_g = 0;
        uint256 var_h = 0;
        uint256 var_i = 0;
        var_e = var_e + 0xa0;
        uint32 var_j = uint32(currentRateInfo);
        uint32 var_k = uint32(currentRateInfo / 0x0100000000);
        uint64 var_l = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_m = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_o = address(totalSupply);
        address var_p = address(totalSupply / 0x0100000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_q = address(totalBorrow);
        address var_r = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(!0x01, "ERC20: mint to the zero address");
        require(!(address(var_e.length) - (address(var_e.length)) > 0xffffffffffffffffffffffffffffffff), "ERC20: mint to the zero address");
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!(address(var_e.length - (var_e.length))), "ERC20: mint to the zero address");
        require(address(totalBorrow) == ((address(totalBorrow) * 0x0186a0) / 0x0186a0) | !0x0186a0, "ERC20: mint to the zero address");
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(var_e.length - (var_e.length)), "ERC20: mint to the zero address");
        store_h = (address(totalBorrow) * 0x0186a0) / (address(var_e.length - (var_e.length)));
        var_e = 0x0100 + var_e;
        uint256 var_u = 0;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = 0;
        uint256 var_y = 0;
        uint256 var_z = 0;
        var_e = 0x40 + var_e;
        uint256 var_aa = 0;
        uint256 var_ab = 0;
        uint256 var_ac = var_e;
        var_e = 0x40 + var_e;
        uint256 var_ad = 0;
        uint256 var_ae = 0;
        uint256 var_af = var_e;
        require(!(!(uint64(var_ag)) == block.timestamp), "ERC20: mint to the zero address");
        require(!(!(uint64(var_ag)) == block.timestamp), "ERC20: mint to the zero address");
        require(!var_e.length, "ERC20: mint to the zero address");
        uint256 var_ah = uint64(var_ai);
        uint256 var_aj = uint64(var_ak);
        uint256 var_al = uint64(var_am);
        uint256 var_an = uint64(var_ag);
        emit UpdateRate(uint64(var_ai), uint64(var_ak), uint64(var_am), uint64(var_ag));
        var_ah = var_ai;
        var_aj = uint64(var_am);
        var_al = var_ak;
        var_an = var_ao;
        emit AddInterest(var_ai, uint64(var_am), var_ak, var_ao);
        var_m = uint64(var_am);
        var_n = uint64(var_ap);
        var_l = uint64(block.timestamp);
        var_j = uint32(block.number);
        currentRateInfo = (uint64(var_ap) * 0x01000000000000000000000000000000000000000000000000) | (uint192((0x0100000000000000000000000000000000 * (uint64(var_am))) | ((uint64(block.timestamp) * 0x010000000000000000) | (address((uint32(var_am) * 0x0100000000) | (uint32(block.number) | (currentRateInfo)))))));
        totalSupply = (0x0100000000000000000000000000000000 * (address(var_aq))) | (address(var_ar));
        totalBorrow = (0x0100000000000000000000000000000000 * (address(var_as))) | (address(var_at));
        require(!(var_ao), "ERC20: mint to the zero address");
        require(address(this), "ERC20: mint to the zero address");
        require(!(store_i > (var_ao + store_i)), "ERC20: mint to the zero address");
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        var_ah = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_au = 0x20;
        uint256 var_av = 0x1f;
        uint256 var_aw = 0x45524332303a206d696e7420746f20746865207a65726f206164647265737300;
        var_u = 0x01;
        var_e = 0x40 + var_e;
        var_ah = address(totalSupply);
        var_aj = address(totalSupply / 0x0100000000000000000000000000000000);
        var_ac = var_e;
        var_e = 0x40 + var_e;
        var_al = address(totalBorrow);
        var_an = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_af = var_e;
        require(!(block.timestamp - (uint64(var_ap))) > block.timestamp);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_ax = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_ay = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ay); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x20);
        require(!(address(var_ar)) > (var_e.length + (address(var_ar))));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!var_e.length + (address(var_az)));
        var_ba = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_bb = block.timestamp - (uint64(var_ap));
        uint256 var_bc = 0;
        uint64 var_bd = uint64(var_be);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_bb); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x40);
        require(var_e.length == (uint64(var_e.length)));
        require(address(var_at) == ((address(var_at) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(var_e.length + (address(var_az)));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_ba = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_bb = block.timestamp - (uint64(var_ap));
        var_bc = (address(var_at) * 0x0186a0) / (var_e.length + (address(var_az)));
        var_bd = uint64(var_be);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_bb); // staticcall
        require(!address(var_ar));
        var_ax = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ay = block.timestamp - (uint64(var_ap));
        var_bb = 0;
        var_bc = uint64(var_be);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ay, var_bb); // staticcall
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_a = 0x1e4ec46b00000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0xc158e88d
    /// @custom:signature   Unresolved_c158e88d(address arg0) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_c158e88d(address arg0) public payable {
        require(arg0 == (address(arg0)));
        require(msg.sender == (address(timelockAddress)), CustomError_1c0be90a());
        var_a = 0x1c0be90a00000000000000000000000000000000000000000000000000000000;
        unresolved_7bcad14c = (address(arg0)) | (uint96(unresolved_7bcad14c));
        address var_a = address(unresolved_7bcad14c);
        address var_b = address(arg0);
        emit Event_555b230d(address(unresolved_7bcad14c), address(arg0));
    }
    
    /// @custom:selector    0xcadac479
    /// @custom:signature   addCollateral(uint256 arg0, address arg1) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function addCollateral(uint256 arg0, address arg1) public payable {
        require(arg1 == (address(arg1)));
        require(store_d - 0x02, "ReentrancyGuard: reentrant call");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x1f;
        var_d = 0x5265656e7472616e637947756172643a207265656e7472616e742063616c6c00;
        store_d = 0x02;
        require(address(arg1), "ERC20: mint to the zero address");
        uint256 var_e = var_e + 0xa0;
        uint256 var_a = 0;
        uint256 var_f = 0;
        uint256 var_g = 0;
        uint256 var_h = 0;
        uint256 var_i = 0;
        var_e = var_e + 0xa0;
        uint32 var_j = uint32(currentRateInfo);
        uint32 var_k = uint32(currentRateInfo / 0x0100000000);
        uint64 var_l = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_m = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_o = address(totalSupply);
        address var_p = address(totalSupply / 0x0100000000000000000000000000000000);
        var_e = 0x40 + var_e;
        address var_q = address(totalBorrow);
        address var_r = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(!0x01, "ERC20: mint to the zero address");
        require(!(address(var_e.length) - (address(var_e.length)) > 0xffffffffffffffffffffffffffffffff), "ERC20: mint to the zero address");
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!(address(var_e.length - (var_e.length))), "ERC20: mint to the zero address");
        require(address(totalBorrow) == ((address(totalBorrow) * 0x0186a0) / 0x0186a0) | !0x0186a0, "ERC20: mint to the zero address");
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(var_e.length - (var_e.length)), "ERC20: mint to the zero address");
        store_h = (address(totalBorrow) * 0x0186a0) / (address(var_e.length - (var_e.length)));
        var_e = 0x0100 + var_e;
        uint256 var_u = 0;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = 0;
        uint256 var_y = 0;
        uint256 var_z = 0;
        var_e = 0x40 + var_e;
        uint256 var_aa = 0;
        uint256 var_ab = 0;
        uint256 var_ac = var_e;
        var_e = 0x40 + var_e;
        uint256 var_ad = 0;
        uint256 var_ae = 0;
        uint256 var_af = var_e;
        require(!(!(uint64(var_ag)) == block.timestamp), "ERC20: mint to the zero address");
        require(!(!(uint64(var_ag)) == block.timestamp), "ERC20: mint to the zero address");
        require(!var_e.length, "ERC20: mint to the zero address");
        uint256 var_ah = uint64(var_ai);
        uint256 var_aj = uint64(var_ak);
        uint256 var_al = uint64(var_am);
        uint256 var_an = uint64(var_ag);
        emit UpdateRate(uint64(var_ai), uint64(var_ak), uint64(var_am), uint64(var_ag));
        var_ah = var_ai;
        var_aj = uint64(var_am);
        var_al = var_ak;
        var_an = var_ao;
        emit AddInterest(var_ai, uint64(var_am), var_ak, var_ao);
        var_m = uint64(var_am);
        var_n = uint64(var_ap);
        var_l = uint64(block.timestamp);
        var_j = uint32(block.number);
        currentRateInfo = (uint64(var_ap) * 0x01000000000000000000000000000000000000000000000000) | (uint192((0x0100000000000000000000000000000000 * (uint64(var_am))) | ((uint64(block.timestamp) * 0x010000000000000000) | (address((uint32(var_am) * 0x0100000000) | (uint32(block.number) | (currentRateInfo)))))));
        totalSupply = (0x0100000000000000000000000000000000 * (address(var_aq))) | (address(var_ar));
        totalBorrow = (0x0100000000000000000000000000000000 * (address(var_as))) | (address(var_at));
        require(!(var_ao), "ERC20: mint to the zero address");
        require(address(this), "ERC20: mint to the zero address");
        require(!(store_i > (var_ao + store_i)), "ERC20: mint to the zero address");
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        var_ah = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_au = 0x20;
        uint256 var_av = 0x1f;
        uint256 var_aw = 0x45524332303a206d696e7420746f20746865207a65726f206164647265737300;
        var_u = 0x01;
        var_e = 0x40 + var_e;
        var_ah = address(totalSupply);
        var_aj = address(totalSupply / 0x0100000000000000000000000000000000);
        var_ac = var_e;
        var_e = 0x40 + var_e;
        var_al = address(totalBorrow);
        var_an = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_af = var_e;
        require(!(block.timestamp - (uint64(var_ap))) > block.timestamp);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_ax = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_ay = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ay); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x20);
        require(!(address(var_ar)) > (var_e.length + (address(var_ar))));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(!var_e.length + (address(var_az)));
        var_ba = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_bb = block.timestamp - (uint64(var_ap));
        uint256 var_bc = 0;
        uint64 var_bd = uint64(var_be);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_bb); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x40);
        require(var_e.length == (uint64(var_e.length)));
        require(address(var_at) == ((address(var_at) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x11;
        require(var_e.length + (address(var_az)));
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_ba = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_bb = block.timestamp - (uint64(var_ap));
        var_bc = (address(var_at) * 0x0186a0) / (var_e.length + (address(var_az)));
        var_bd = uint64(var_be);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_bb); // staticcall
        require(!address(var_ar));
        var_ax = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ay = block.timestamp - (uint64(var_ap));
        var_bb = 0;
        var_bc = uint64(var_be);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ay, var_bb); // staticcall
        var_s = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_t = 0x12;
        var_a = 0x1e4ec46b00000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0xce96cb77
    /// @custom:signature   maxWithdraw(address arg0) public payable returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function maxWithdraw(address arg0) public payable returns (uint256) {
        require(arg0 == (address(arg0)));
        require(!bytes1(isInterestAccessControlRevoked / 0x01000000));
        uint256 var_a = 0;
        return 0;
        uint256 var_b = var_b + 0xa0;
        var_a = 0;
        uint256 var_c = 0;
        uint256 var_d = 0;
        uint256 var_e = 0;
        uint256 var_f = 0;
        var_b = 0x40 + var_b;
        uint256 var_g = 0;
        uint256 var_h = 0;
        var_b = 0x40 + var_b;
        uint256 var_i = 0;
        uint256 var_j = 0;
        var_b = var_b + 0xa0;
        uint32 var_k = uint32(currentRateInfo);
        uint32 var_l = uint32(currentRateInfo / 0x0100000000);
        uint64 var_m = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_o = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_b = 0x0100 + var_b;
        uint256 var_p = 0;
        uint256 var_q = 0;
        uint256 var_r = 0;
        uint256 var_s = 0;
        uint256 var_t = 0;
        uint256 var_u = 0;
        var_b = 0x40 + var_b;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = var_b;
        var_b = 0x40 + var_b;
        uint256 var_y = 0;
        uint256 var_z = 0;
        uint256 var_aa = var_b;
        require(uint64(var_ab) == block.timestamp);
        require(uint64(var_ab) == block.timestamp);
        require(!var_b.length);
        var_n = uint64(var_ac);
        var_o = uint64(var_ad);
        require(address(arg0) == (address(this)));
        uint256 var_ae = address(arg0);
        uint256 var_af = 0x0a;
        require(!0x01);
        require(!(address(var_ag) - (address(var_ah))) > 0xffffffffffffffffffffffffffffffff);
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        uint256 var_ai = 0x11;
        require(0 - (address(var_aj)));
        require(address(var_ag) == (address(var_ag) * storage_map_t[var_ae] / storage_map_t[var_ae]) | !storage_map_t[var_ae]);
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(address(var_ak));
        require(!0);
        require(address(var_aj) == (address(var_aj) * (address(var_ag) * storage_map_t[var_ae] / (address(var_ak))) / (address(var_ag) * storage_map_t[var_ae] / (address(var_ak)))) | (!(address(var_ag) * storage_map_t[var_ae]) / (address(var_ak))));
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(address(var_al));
        require(!(address(var_aj) * (address(var_ag) * storage_map_t[var_ae] / (address(var_ak))) / (address(var_al))) < storage_map_t[var_ae]);
        require(!0x01 > (address(var_ag) * storage_map_t[var_ae] / (address(var_ak)) + 0x01));
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(address(var_ag - (var_ah)) < (address(var_ag) * storage_map_t[var_ae] / (address(var_ak)) + 0x01));
        uint256 var_am = (address(var_ag) * storage_map_t[var_ae] / (address(var_ak))) + 0x01;
        return (address(var_ag) * storage_map_t[var_ae] / (address(var_ak))) + 0x01;
        var_am = address(var_ag - (var_ah));
        return address(var_ag - (var_ah));
        require(address(var_ag - (var_ah)) < (address(var_ag) * storage_map_t[var_ae] / (address(var_ak))));
        var_am = address(var_ag - (var_ah));
        return address(var_ag - (var_ah));
        var_am = (address(var_ag) * storage_map_t[var_ae]) / (address(var_ak));
        return (address(var_ag) * storage_map_t[var_ae]) / (address(var_ak));
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x12;
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x12;
        require(address(unresolved_7bcad14c));
        var_am = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_an = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_an); // staticcall
        var_b = var_b + (uint248(ret0.length + 0x1f));
        require(!((var_b + ret0.length) - var_b) < 0x20);
        require(!(address(var_ag)) > (var_b.length + (address(var_ag))));
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(!((var_b.length + (address(var_ao))) - (address(var_ap))) > (var_b.length + (address(var_ao))));
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        var_p = 0x01;
        var_b = 0x40 + var_b;
        var_am = address(totalSupply);
        uint256 var_aq = address(totalSupply / 0x0100000000000000000000000000000000);
        var_x = var_b;
        var_b = 0x40 + var_b;
        uint256 var_ar = address(totalBorrow);
        uint256 var_as = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_aa = var_b;
        require(!(block.timestamp - (uint64(var_ad))) > block.timestamp);
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_at = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_au = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_au); // staticcall
        var_b = var_b + (uint248(ret0.length + 0x1f));
        require(!((var_b + ret0.length) - var_b) < 0x20);
        require(!(address(var_ag)) > (var_b.length + (address(var_ag))));
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(!var_b.length + (address(var_ao)));
        uint256 var_av = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_aw = block.timestamp - (uint64(var_ad));
        uint256 var_ax = 0;
        uint256 var_ay = uint64(var_az);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_aw); // staticcall
        var_b = var_b + (uint248(ret0.length + 0x1f));
        require(!((var_b + ret0.length) - var_b) < 0x40);
        require(var_b.length == (uint64(var_b.length)));
        require(address(var_ah) == ((address(var_ah) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(var_b.length + (address(var_ao)));
        var_ae = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x12;
        var_av = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_aw = block.timestamp - (uint64(var_ad));
        var_ax = (address(var_ah) * 0x0186a0) / (var_b.length + (address(var_ao)));
        var_ay = uint64(var_az);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_aw); // staticcall
        require(!address(var_ag));
        var_at = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_au = block.timestamp - (uint64(var_ad));
        var_aw = 0;
        var_ax = uint64(var_az);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_au, var_aw); // staticcall
    }
    
    /// @custom:selector    0x8f791f8b
    /// @custom:signature   setOracle(address arg0, uint32 arg1) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint32", "bytes4", "int32"]
    function setOracle(address arg0, uint32 arg1) public payable {
        require(arg0 == (address(arg0)));
        require(arg1 == (uint32(arg1)));
        require(msg.sender == (address(timelockAddress)), CustomError_1c0be90a());
        var_a = 0x1c0be90a00000000000000000000000000000000000000000000000000000000;
        require(!(bytes1(isOracleSetterRevoked)), CustomError_8c34a9b8());
        var_a = 0x8c34a9b800000000000000000000000000000000000000000000000000000000;
        uint256 var_b = var_b + 0xa0;
        address var_a = address(exchangeRateInfo);
        uint32 var_c = uint32(exchangeRateInfo / 0x010000000000000000000000000000000000000000);
        uint184 var_d = uint184(store_l);
        var_e = store_m;
        var_f = store_n;
        address var_g = address(exchangeRateInfo);
        uint32 var_h = uint32(exchangeRateInfo / 0x010000000000000000000000000000000000000000);
        address var_i = address(arg0);
        uint32 var_j = uint32(arg1);
        emit SetOracleInfo(address(exchangeRateInfo), uint32(exchangeRateInfo / 0x010000000000000000000000000000000000000000), address(arg0), uint32(arg1));
        var_a = address(arg0);
        var_c = uint32(arg1);
        exchangeRateInfo = (uint32(arg1) * 0x010000000000000000000000000000000000000000) | (address(arg0) | (uint64(exchangeRateInfo)));
        store_l = (uint184(var_k)) | (uint72(store_l));
        store_m = var_l;
        store_n = var_m;
    }
    
    /// @custom:selector    0x3f2617cb
    /// @custom:signature   Unresolved_3f2617cb(address arg0, uint256 arg1) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function Unresolved_3f2617cb(address arg0, uint256 arg1) public payable {
        require(arg0 == (address(arg0)));
        require(arg1 == arg1);
        require(msg.sender == (address(unresolved_8da5cb5b)), "Ownable: caller is not the owner");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x20;
        var_d = 0x4f776e61626c653a2063616c6c6572206973206e6f7420746865206f776e6572;
        address var_e = address(arg0);
        var_f = 0x16;
        storage_map_ad[var_e] = arg1 | (uint248(storage_map_ad[var_e]));
        address var_a = address(arg0);
        uint256 var_g = arg1;
        emit SetSwapper(address(arg0), arg1);
    }
    
    /// @custom:selector    0x095ea7b3
    /// @custom:signature   approve(address arg0, uint256 arg1) public payable returns (bool)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function approve(address arg0, uint256 arg1) public payable returns (bool) {
        require(arg0 == (address(arg0)));
        require(address(msg.sender), "ERC20: approve to the zero address");
        require(address(arg0), "ERC20: approve to the zero address");
        address var_a = address(msg.sender);
        var_b = 0x0b;
        var_a = address(arg0);
        address var_b = keccak256(var_a);
        storage_map_v[var_a] = arg1;
        uint256 var_c = arg1;
        emit Approval(address(msg.sender), address(arg0), arg1);
        var_c = 0x01;
        return 0x01;
        var_c = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_d = 0x20;
        var_e = 0x22;
        var_f = 0x45524332303a20617070726f766520746f20746865207a65726f206164647265;
        var_g = 0x7373000000000000000000000000000000000000000000000000000000000000;
        var_c = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_d = 0x20;
        var_e = 0x24;
        var_f = 0x45524332303a20617070726f76652066726f6d20746865207a65726f20616464;
        var_g = 0x7265737300000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x0a28a477
    /// @custom:signature   previewWithdraw(uint256 arg0) public payable returns (address)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function previewWithdraw(uint256 arg0) public payable returns (address) {
        uint256 var_a = var_a + 0xa0;
        uint256 var_b = 0;
        uint256 var_c = 0;
        uint256 var_d = 0;
        uint256 var_e = 0;
        uint256 var_f = 0;
        var_a = 0x40 + var_a;
        uint256 var_g = 0;
        uint256 var_h = 0;
        var_a = 0x40 + var_a;
        uint256 var_i = 0;
        uint256 var_j = 0;
        var_a = var_a + 0xa0;
        uint32 var_k = uint32(currentRateInfo);
        uint32 var_l = uint32(currentRateInfo / 0x0100000000);
        uint64 var_m = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_o = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x0100 + var_a;
        uint256 var_p = 0;
        uint256 var_q = 0;
        uint256 var_r = 0;
        uint256 var_s = 0;
        uint256 var_t = 0;
        uint256 var_u = 0;
        var_a = 0x40 + var_a;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = var_a;
        var_a = 0x40 + var_a;
        uint256 var_y = 0;
        uint256 var_z = 0;
        uint256 var_aa = var_a;
        require(uint64(var_ab) == block.timestamp);
        require(uint64(var_ab) == block.timestamp);
        require(!var_a.length);
        var_n = uint64(var_ac);
        var_o = uint64(var_ad);
        require(0 - (address(var_ae)));
        require(address(var_af) == ((address(var_af) * arg0) / arg0) | !arg0);
        uint256 var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        uint256 var_ah = 0x11;
        require(address(var_ae));
        require(!0x01);
        require(!0x01);
        uint256 var_ai = (address(var_af) * arg0) / (address(var_ae));
        return (address(var_af) * arg0) / (address(var_ae));
        require(!0x01 > ((address(var_af) * arg0) / (address(var_ae)) + 0x01));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        var_ai = ((address(var_af) * arg0) / (address(var_ae))) + 0x01;
        return ((address(var_af) * arg0) / (address(var_ae))) + 0x01;
        require(address(var_aj) == (address(var_aj) * ((address(var_af) * arg0) / (address(var_ae))) / ((address(var_af) * arg0) / (address(var_ae)))) | (!(address(var_af) * arg0) / (address(var_ae))));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(address(var_ak));
        require(!(address(var_aj) * ((address(var_af) * arg0) / (address(var_ae))) / (address(var_ak))) < arg0);
        var_ai = (address(var_af) * arg0) / (address(var_ae));
        return (address(var_af) * arg0) / (address(var_ae));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x12;
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x12;
        var_ai = arg0;
        return arg0;
        var_p = 0x01;
        var_a = 0x40 + var_a;
        var_ai = address(totalSupply);
        uint256 var_al = address(totalSupply / 0x0100000000000000000000000000000000);
        var_x = var_a;
        var_a = 0x40 + var_a;
        uint256 var_am = address(totalBorrow);
        uint256 var_an = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_aa = var_a;
        require(!(block.timestamp - (uint64(var_ad))) > block.timestamp);
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_ao = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_ap = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ap); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_ae)) > (var_a.length + (address(var_ae))));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(!var_a.length + (address(var_aq)));
        uint256 var_ar = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_as = block.timestamp - (uint64(var_ad));
        uint256 var_at = 0;
        uint256 var_au = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_as); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x40);
        require(var_a.length == (uint64(var_a.length)));
        require(address(var_aw) == ((address(var_aw) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(var_a.length + (address(var_aq)));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x12;
        var_ar = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_as = block.timestamp - (uint64(var_ad));
        var_at = (address(var_aw) * 0x0186a0) / (var_a.length + (address(var_aq)));
        var_au = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_as); // staticcall
        require(!address(var_ae));
        var_ao = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ap = block.timestamp - (uint64(var_ad));
        var_as = 0;
        var_at = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ap, var_as); // staticcall
    }
    
    /// @custom:selector    0x7d37bdd7
    /// @custom:signature   Unresolved_7d37bdd7(uint256 arg0, uint256 arg1) public pure
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function Unresolved_7d37bdd7(uint256 arg0, uint256 arg1) public pure {
        require(arg1 == arg1);
    }
    
    /// @custom:selector    0x39030864
    /// @custom:signature   revokeMaxLTVSetter() public payable
    function revokeMaxLTVSetter() public payable {
        require(msg.sender == (address(timelockAddress)), CustomError_1c0be90a());
        var_a = 0x1c0be90a00000000000000000000000000000000000000000000000000000000;
        isOracleSetterRevoked = 0x0100 | (uint248(isOracleSetterRevoked));
        emit RevokeMaxLTVSetter();
    }
    
    /// @custom:selector    0xb68d0a09
    /// @custom:signature   getUserSnapshot(address arg0) public view returns (bytes memory)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function getUserSnapshot(address arg0) public view returns (bytes memory) {
        require(arg0 == (address(arg0)));
        address var_a = address(arg0);
        var_b = 0x0a;
        var_a = address(arg0);
        var_b = 0x23;
        var_b = 0x22;
        address var_c = storage_map_v[var_a];
        address var_d = storage_map_v[var_a];
        address var_e = storage_map_v[var_a];
        return abi.encodePacked(storage_map_v[var_a], storage_map_v[var_a], storage_map_v[var_a]);
    }
    
    /// @custom:selector    0xdd62ed3e
    /// @custom:signature   Unresolved_dd62ed3e(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_dd62ed3e(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x39509351
    /// @custom:signature   increaseAllowance(address arg0, uint256 arg1) public payable returns (bool)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function increaseAllowance(address arg0, uint256 arg1) public payable returns (bool) {
        require(arg0 == (address(arg0)));
        address var_a = address(msg.sender);
        var_b = 0x0b;
        var_a = address(arg0);
        address var_b = keccak256(var_a);
        require(!(storage_map_v[var_a] > (arg1 + storage_map_v[var_a])), "ERC20: approve to the zero address");
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_c = 0x11;
        require(address(msg.sender), "ERC20: approve to the zero address");
        require(address(arg0), "ERC20: approve to the zero address");
        var_a = address(msg.sender);
        var_b = 0x0b;
        var_a = address(arg0);
        var_b = keccak256(var_a);
        storage_map_v[var_a] = arg1 + storage_map_v[var_a];
        address var_d = arg1 + storage_map_v[var_a];
        emit Approval(address(msg.sender), address(arg0), arg1 + storage_map_v[var_a]);
        var_d = 0x01;
        return 0x01;
        var_d = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_e = 0x20;
        var_f = 0x22;
        var_g = 0x45524332303a20617070726f766520746f20746865207a65726f206164647265;
        var_h = 0x7373000000000000000000000000000000000000000000000000000000000000;
        var_d = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_e = 0x20;
        var_f = 0x24;
        var_g = 0x45524332303a20617070726f76652066726f6d20746865207a65726f20616464;
        var_h = 0x7265737300000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x95d89b41
    /// @custom:signature   symbol() public view returns (string memory)
    function symbol() public view returns (string memory) {
        if (unresolved_8da5cb5bg) {
            if (unresolved_8da5cb5bg - ((unresolved_8da5cb5bg >> 0x01) < 0x20)) {
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x22;
                uint256 var_c = var_c + (0x20 + (((0x1f + (unresolved_8da5cb5bg >> 0x01)) / 0x20) * 0x20));
                bytes32 var_d = unresolved_8da5cb5bg >> 0x01;
                if (unresolved_8da5cb5bg) {
                    if (unresolved_8da5cb5bg - ((unresolved_8da5cb5bg >> 0x01) < 0x20)) {
                        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                        var_b = 0x22;
                        if (!unresolved_8da5cb5bg >> 0x01) {
                            if (0x1f < (unresolved_8da5cb5bg >> 0x01)) {
                                var_a = 0x19;
                                var_e = storage_map_v[var_a];
                                if ((0x20 + var_c) + (unresolved_8da5cb5bg >> 0x01) > (0x20 + (0x20 + var_c))) {
                                    var_e = 0x20;
                                    uint256 var_f = var_c.length;
                                    uint256 var_g = 0;
                                    return abi.encodePacked(0x20, var_c.length);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    /// @custom:selector    0x402d267d
    /// @custom:signature   maxDeposit(address arg0) public payable returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function maxDeposit(address arg0) public payable returns (uint256) {
        require(arg0 == (address(arg0)));
        uint256 var_a = var_a + 0xa0;
        uint256 var_b = 0;
        uint256 var_c = 0;
        uint256 var_d = 0;
        uint256 var_e = 0;
        uint256 var_f = 0;
        var_a = 0x40 + var_a;
        uint256 var_g = 0;
        uint256 var_h = 0;
        var_a = 0x40 + var_a;
        uint256 var_i = 0;
        uint256 var_j = 0;
        var_a = var_a + 0xa0;
        uint32 var_k = uint32(currentRateInfo);
        uint32 var_l = uint32(currentRateInfo / 0x0100000000);
        uint64 var_m = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_o = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x0100 + var_a;
        uint256 var_p = 0;
        uint256 var_q = 0;
        uint256 var_r = 0;
        uint256 var_s = 0;
        uint256 var_t = 0;
        uint256 var_u = 0;
        var_a = 0x40 + var_a;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = var_a;
        var_a = 0x40 + var_a;
        uint256 var_y = 0;
        uint256 var_z = 0;
        uint256 var_aa = var_a;
        require(uint64(var_ab) == block.timestamp);
        require(uint64(var_ab) == block.timestamp);
        require(!var_a.length);
        var_n = uint64(var_ac);
        var_o = uint64(var_ad);
        require(0);
        uint256 var_ae = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_af = address(this);
        (bool success, bytes memory ret0) = address(0).Unresolved_22bbc2d2(var_af); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_ag)) > (var_a.length + (address(var_ag))));
        uint256 var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        uint256 var_ai = 0x11;
        require(!(var_a.length + (address(var_aj))) < depositLimit);
        uint256 var_ak = 0;
        return 0;
        var_a = 0x40 + var_a;
        var_ae = address(totalSupply);
        var_ak = address(totalSupply / 0x0100000000000000000000000000000000);
        var_a = 0x40 + var_a;
        uint256 var_al = address(totalBorrow);
        uint256 var_am = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(0);
        uint256 var_an = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_ao = address(this);
        (bool success, bytes memory ret0) = address(0).Unresolved_22bbc2d2(var_ao); // staticcall
        var_p = 0x01;
        var_a = 0x40 + var_a;
        var_ae = address(totalSupply);
        var_ak = address(totalSupply / 0x0100000000000000000000000000000000);
        var_x = var_a;
        var_a = 0x40 + var_a;
        var_al = address(totalBorrow);
        var_am = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_aa = var_a;
        require(!(block.timestamp - (uint64(var_ad))) > block.timestamp);
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(address(unresolved_7bcad14c));
        var_an = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        var_ao = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ao); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_ag)) > (var_a.length + (address(var_ag))));
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(!var_a.length + (address(var_aj)));
        uint256 var_ap = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_aq = block.timestamp - (uint64(var_ad));
        uint256 var_ar = 0;
        uint256 var_as = uint64(var_at);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_aq); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x40);
        require(var_a.length == (uint64(var_a.length)));
        require(address(var_au) == ((address(var_au) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(var_a.length + (address(var_aj)));
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x12;
        var_ap = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_aq = block.timestamp - (uint64(var_ad));
        var_ar = (address(var_au) * 0x0186a0) / (var_a.length + (address(var_aj)));
        var_as = uint64(var_at);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_aq); // staticcall
        require(!address(var_ag));
        var_an = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ao = block.timestamp - (uint64(var_ad));
        var_aq = 0;
        var_ar = uint64(var_at);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ao, var_aq); // staticcall
    }
    
    /// @custom:selector    0xef8b30f7
    /// @custom:signature   previewDeposit(uint256 arg0) public payable returns (address)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function previewDeposit(uint256 arg0) public payable returns (address) {
        uint256 var_a = var_a + 0xa0;
        uint256 var_b = 0;
        uint256 var_c = 0;
        uint256 var_d = 0;
        uint256 var_e = 0;
        uint256 var_f = 0;
        var_a = 0x40 + var_a;
        uint256 var_g = 0;
        uint256 var_h = 0;
        var_a = 0x40 + var_a;
        uint256 var_i = 0;
        uint256 var_j = 0;
        var_a = var_a + 0xa0;
        uint32 var_k = uint32(currentRateInfo);
        uint32 var_l = uint32(currentRateInfo / 0x0100000000);
        uint64 var_m = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_o = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x0100 + var_a;
        uint256 var_p = 0;
        uint256 var_q = 0;
        uint256 var_r = 0;
        uint256 var_s = 0;
        uint256 var_t = 0;
        uint256 var_u = 0;
        var_a = 0x40 + var_a;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = var_a;
        var_a = 0x40 + var_a;
        uint256 var_y = 0;
        uint256 var_z = 0;
        uint256 var_aa = var_a;
        require(uint64(var_ab) == block.timestamp);
        require(uint64(var_ab) == block.timestamp);
        require(!var_a.length);
        var_n = uint64(var_ac);
        var_o = uint64(var_ad);
        require(0 - (address(var_ae)));
        require(address(var_af) == ((address(var_af) * arg0) / arg0) | !arg0);
        uint256 var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        uint256 var_ah = 0x11;
        require(address(var_ae));
        require(!0);
        require(address(var_ai) == (address(var_ai) * ((address(var_af) * arg0) / (address(var_ae))) / ((address(var_af) * arg0) / (address(var_ae)))) | (!(address(var_af) * arg0) / (address(var_ae))));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(address(var_aj));
        require(!(address(var_ai) * ((address(var_af) * arg0) / (address(var_ae))) / (address(var_aj))) < arg0);
        require(!0x01 > ((address(var_af) * arg0) / (address(var_ae)) + 0x01));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        uint256 var_ak = ((address(var_af) * arg0) / (address(var_ae))) + 0x01;
        return ((address(var_af) * arg0) / (address(var_ae))) + 0x01;
        var_ak = (address(var_af) * arg0) / (address(var_ae));
        return (address(var_af) * arg0) / (address(var_ae));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x12;
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x12;
        var_ak = arg0;
        return arg0;
        var_p = 0x01;
        var_a = 0x40 + var_a;
        var_ak = address(totalSupply);
        uint256 var_al = address(totalSupply / 0x0100000000000000000000000000000000);
        var_x = var_a;
        var_a = 0x40 + var_a;
        uint256 var_am = address(totalBorrow);
        uint256 var_an = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_aa = var_a;
        require(!(block.timestamp - (uint64(var_ad))) > block.timestamp);
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_ao = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_ap = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ap); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_ae)) > (var_a.length + (address(var_ae))));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(!var_a.length + (address(var_aq)));
        uint256 var_ar = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_as = block.timestamp - (uint64(var_ad));
        uint256 var_at = 0;
        uint256 var_au = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_as); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x40);
        require(var_a.length == (uint64(var_a.length)));
        require(address(var_aw) == ((address(var_aw) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x11;
        require(var_a.length + (address(var_aq)));
        var_ag = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ah = 0x12;
        var_ar = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_as = block.timestamp - (uint64(var_ad));
        var_at = (address(var_aw) * 0x0186a0) / (var_a.length + (address(var_aq)));
        var_au = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_as); // staticcall
        require(!address(var_ae));
        var_ao = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ap = block.timestamp - (uint64(var_ad));
        var_as = 0;
        var_at = uint64(var_av);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ap, var_as); // staticcall
    }
    
    /// @custom:selector    0x79ba5097
    /// @custom:signature   acceptOwnership() public payable
    function acceptOwnership() public payable {
        require(msg.sender == (address(pendingOwner)), "Ownable2Step: caller is not the new owner");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x29;
        var_d = 0x4f776e61626c6532537465703a2063616c6c6572206973206e6f742074686520;
        var_e = 0x6e6577206f776e65720000000000000000000000000000000000000000000000;
        pendingOwner = uint96(pendingOwner);
        unresolved_8da5cb5b = (address(msg.sender)) | (uint96(unresolved_8da5cb5b));
        emit OwnershipTransferred(address(unresolved_8da5cb5b), address(msg.sender));
    }
    
    /// @custom:selector    0xdaf33f2a
    /// @custom:signature   withdrawFees(uint128 arg0, address arg1) public payable
    /// @param              arg0 ["address", "uint128", "bytes16", "int128"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function withdrawFees(uint128 arg0, address arg1) public payable {
        require(arg0 == (address(arg0)));
        require(arg1 == (address(arg1)));
        require(msg.sender == (address(unresolved_8da5cb5b)), "Ownable: caller is not the owner");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x20;
        var_d = 0x4f776e61626c653a2063616c6c6572206973206e6f7420746865206f776e6572;
        require(address(arg1), "SafeCast: value doesn't fit in 128 bits");
        uint256 var_e = 0x40 + var_e;
        address var_a = address(totalSupply);
        address var_f = address(totalSupply / 0x0100000000000000000000000000000000);
        require(0 - (address(arg0)), "SafeCast: value doesn't fit in 128 bits");
        require(0 - (address(var_g)), "SafeCast: value doesn't fit in 128 bits");
        require(address(var_e.length) == (address(var_e.length) * (address(arg0)) / (address(arg0))) | (!address(arg0)), "SafeCast: value doesn't fit in 128 bits");
        var_h = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_i = 0x11;
        require(address(var_j), "SafeCast: value doesn't fit in 128 bits");
        require(!0x01, "SafeCast: value doesn't fit in 128 bits");
        require(!0x01, "SafeCast: value doesn't fit in 128 bits");
        require(address(this), "SafeCast: value doesn't fit in 128 bits");
        require(address(msg.sender), "SafeCast: value doesn't fit in 128 bits");
        address var_h = address(this);
        var_k = 0x0b;
        var_h = address(msg.sender);
        address var_k = keccak256(var_h);
        storage_map_ah[var_h] = address(arg0);
        address var_l = address(arg0);
        emit Approval(address(this), address(msg.sender), address(arg0));
        require(!(address(var_e.length) * (address(arg0)) / (address(var_m)) > 0xffffffffffffffffffffffffffffffff), "SafeCast: value doesn't fit in 128 bits");
        var_l = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_d = 0x20;
        var_n = 0x27;
        var_o = 0x53616665436173743a2076616c756520646f65736e27742066697420696e2031;
        var_p = 0x3238206269747300000000000000000000000000000000000000000000000000;
        require(address(this) == msg.sender, CustomError_c5bb6dae());
        require(0, CustomError_c5bb6dae());
        var_e = 0x40 + var_e;
        var_l = address(totalBorrow);
        address var_q = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(!0x01, CustomError_c5bb6dae());
        require(!(address(var_e.length) - (address(var_e.length)) > 0xffffffffffffffffffffffffffffffff), CustomError_c5bb6dae());
        var_h = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_i = 0x11;
        require(!(address(var_e.length - (var_e.length)) < (address(var_e.length * (arg0) / (var_m)))), CustomError_c5bb6dae());
        var_r = 0xc5bb6dae00000000000000000000000000000000000000000000000000000000;
        uint256 var_o = address(var_e.length - (var_e.length));
        uint256 var_p = address(var_e.length * (arg0) / (var_m));
        require(address(unresolved_7bcad14c) == (address(this)));
        var_e = 0x40 + var_e;
        address var_r = address(totalBorrow);
        address var_s = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(!0);
        require(address(unresolved_7bcad14c));
        var_t = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        address var_u = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_u); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        if (!((var_e + ret0.length) - var_e) < 0x20) {
            require(!((var_e + ret0.length) - var_e) < 0x20);
            var_h = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_i = 0x11;
            require(!(address(var_e.length)) > (var_e.length + (address(var_e.length))));
            var_h = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_i = 0x11;
            require(!((var_e.length + (address(var_e.length))) - (address(var_e.length))) > (var_e.length + (address(var_e.length))));
        }
        if (!(address(var_e.length) - (address(var_e.length))) > 0xffffffffffffffffffffffffffffffff) {
            var_h = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_i = 0x11;
            var_h = address(this);
            var_k = 0x0b;
            var_h = address(msg.sender);
            var_k = keccak256(var_h);
            if (storage_map_ah[var_h] == 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) {
            }
            require(!(address(var_e.length) - (address(var_e.length)) > 0xffffffffffffffffffffffffffffffff), "ERC20: approve to the zero address");
        }
        var_l = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_d = 0x20;
        var_n = 0x22;
        var_o = 0x45524332303a20617070726f766520746f20746865207a65726f206164647265;
        var_p = 0x7373000000000000000000000000000000000000000000000000000000000000;
        var_l = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_d = 0x20;
        var_n = 0x24;
        var_o = 0x45524332303a20617070726f76652066726f6d20746865207a65726f20616464;
        var_p = 0x7265737300000000000000000000000000000000000000000000000000000000;
        if (address(var_g) == (address(var_g) * (address(var_e.length) * (address(arg0)) / (address(var_m))) / (address(var_e.length) * (address(arg0)) / (address(var_m)))) | (!(address(var_e.length) * (address(arg0))) / (address(var_m)))) {
            var_h = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_i = 0x11;
            require(address(var_g) == (address(var_g) * (address(var_e.length) * (address(arg0)) / (address(var_m))) / (address(var_e.length) * (address(arg0)) / (address(var_m)))) | (!(address(var_e.length) * (address(arg0))) / (address(var_m))), "ERC20: approve to the zero address");
            require(address(var_v), "ERC20: approve to the zero address");
        }
        var_h = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_i = 0x12;
        var_h = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_i = 0x12;
        require(address(this), "ERC20: approve to the zero address");
        require(address(msg.sender), "ERC20: approve to the zero address");
        var_l = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_d = 0x20;
        var_n = 0x22;
        var_o = 0x45524332303a20617070726f766520746f20746865207a65726f206164647265;
        var_p = 0x7373000000000000000000000000000000000000000000000000000000000000;
        var_l = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_d = 0x20;
        var_n = 0x24;
        var_o = 0x45524332303a20617070726f76652066726f6d20746865207a65726f20616464;
        var_p = 0x7265737300000000000000000000000000000000000000000000000000000000;
        var_a = 0x1e4ec46b00000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0xba087652
    /// @custom:signature   Unresolved_ba087652(uint256 arg0, address arg1) public pure
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_ba087652(uint256 arg0, address arg1) public pure {
        require(arg1 == (address(arg1)));
    }
    
    /// @custom:selector    0xe1e92775
    /// @custom:signature   revokeOracleInfoSetter() public payable
    function revokeOracleInfoSetter() public payable {
        require(msg.sender == (address(timelockAddress)), CustomError_1c0be90a());
        var_a = 0x1c0be90a00000000000000000000000000000000000000000000000000000000;
        isOracleSetterRevoked = 0x01 | (uint248(isOracleSetterRevoked));
        emit RevokeOracleInfoSetter();
    }
    
    /// @custom:selector    0x715018a6
    /// @custom:signature   renounceOwnership() public payable
    function renounceOwnership() public payable {
        require(msg.sender == (address(unresolved_8da5cb5b)), "Ownable: caller is not the owner");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x20;
        var_d = 0x4f776e61626c653a2063616c6c6572206973206e6f7420746865206f776e6572;
        pendingOwner = uint96(pendingOwner);
        unresolved_8da5cb5b = 0 | (uint96(unresolved_8da5cb5b));
        emit OwnershipTransferred(address(unresolved_8da5cb5b), 0);
    }
    
    /// @custom:selector    0x4f8b4ae7
    /// @custom:signature   renounceTimelock() public payable
    function renounceTimelock() public payable {
        require(msg.sender == (address(timelockAddress)), CustomError_1c0be90a());
        var_a = 0x1c0be90a00000000000000000000000000000000000000000000000000000000;
        require(msg.sender == (address(pendingTimelockAddress)), CustomError_f5c49e64());
        var_a = 0xf5c49e6400000000000000000000000000000000000000000000000000000000;
        pendingTimelockAddress = 0 | (uint96(pendingTimelockAddress));
        emit TimelockTransferStarted(address(timelockAddress), 0);
        emit TimelockTransferred(address(timelockAddress), 0);
        timelockAddress = 0 | (uint96(timelockAddress));
    }
    
    /// @custom:selector    0x1c2591d3
    /// @custom:signature   Unresolved_1c2591d3(uint256 arg0, uint256 arg1) public pure
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function Unresolved_1c2591d3(uint256 arg0, uint256 arg1) public pure {
        require(arg1 == arg1);
    }
    
    /// @custom:selector    0x01e1d114
    /// @custom:signature   totalAssets() public payable returns (address)
    function totalAssets() public payable returns (address) {
        uint256 var_a = var_a + 0xa0;
        uint256 var_b = 0;
        uint256 var_c = 0;
        uint256 var_d = 0;
        uint256 var_e = 0;
        uint256 var_f = 0;
        var_a = 0x40 + var_a;
        uint256 var_g = 0;
        uint256 var_h = 0;
        var_a = 0x40 + var_a;
        uint256 var_i = 0;
        uint256 var_j = 0;
        var_a = var_a + 0xa0;
        uint32 var_k = uint32(currentRateInfo);
        uint32 var_l = uint32(currentRateInfo / 0x0100000000);
        uint64 var_m = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_o = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x0100 + var_a;
        uint256 var_p = 0;
        uint256 var_q = 0;
        uint256 var_r = 0;
        uint256 var_s = 0;
        uint256 var_t = 0;
        uint256 var_u = 0;
        var_a = 0x40 + var_a;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = var_a;
        var_a = 0x40 + var_a;
        uint256 var_y = 0;
        uint256 var_z = 0;
        uint256 var_aa = var_a;
        require(uint64(var_ab) == block.timestamp);
        require(uint64(var_ab) == block.timestamp);
        require(!var_a.length);
        var_n = uint64(var_ac);
        var_o = uint64(var_ad);
        require(address(unresolved_7bcad14c));
        uint256 var_ae = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_af = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_af); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_ag)) > (var_a.length + (address(var_ag))));
        uint256 var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        uint256 var_ai = 0x11;
        uint256 var_aj = var_a.length + (address(var_ak));
        return var_a.length + (address(var_ak));
        var_ae = address(var_ag);
        return address(var_ag);
        var_a = 0x40 + var_a;
        var_ae = address(totalSupply);
        var_aj = address(totalSupply / 0x0100000000000000000000000000000000);
        var_a = 0x40 + var_a;
        uint256 var_al = address(totalBorrow);
        uint256 var_am = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(address(unresolved_7bcad14c));
        uint256 var_an = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_ao = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ao); // staticcall
        var_an = address(var_a.length);
        return address(var_a.length);
        var_p = 0x01;
        var_a = 0x40 + var_a;
        var_ae = address(totalSupply);
        var_aj = address(totalSupply / 0x0100000000000000000000000000000000);
        var_x = var_a;
        var_a = 0x40 + var_a;
        var_al = address(totalBorrow);
        var_am = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_aa = var_a;
        require(!(block.timestamp - (uint64(var_ad))) > block.timestamp);
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(address(unresolved_7bcad14c));
        var_an = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        var_ao = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ao); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_ag)) > (var_a.length + (address(var_ag))));
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(!var_a.length + (address(var_ak)));
        uint256 var_ap = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_aq = block.timestamp - (uint64(var_ad));
        uint256 var_ar = 0;
        uint256 var_as = uint64(var_at);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_aq); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x40);
        require(var_a.length == (uint64(var_a.length)));
        require(address(var_au) == ((address(var_au) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(var_a.length + (address(var_ak)));
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x12;
        var_ap = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_aq = block.timestamp - (uint64(var_ad));
        var_ar = (address(var_au) * 0x0186a0) / (var_a.length + (address(var_ak)));
        var_as = uint64(var_at);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_aq); // staticcall
        require(!address(var_ag));
        var_an = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ao = block.timestamp - (uint64(var_ad));
        var_aq = 0;
        var_ar = uint64(var_at);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ao, var_aq); // staticcall
    }
    
    /// @custom:selector    0x6b96668f
    /// @custom:signature   setRateContract(address arg0) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function setRateContract(address arg0) public payable {
        require(arg0 == (address(arg0)));
        require(msg.sender == (address(timelockAddress)), CustomError_1c0be90a());
        var_a = 0x1c0be90a00000000000000000000000000000000000000000000000000000000;
        require(!(bytes1(isOracleSetterRevoked / 0x010000)), CustomError_8c34a9b8());
        address var_a = address(rateContract);
        address var_b = address(arg0);
        emit SetRateContract(address(rateContract), address(arg0));
        rateContract = (address(arg0)) | (uint96(rateContract));
        var_a = 0x8c34a9b800000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x8142dd53
    /// @custom:signature   changeFee(uint32 arg0) public payable
    /// @param              arg0 ["uint32", "bytes4", "int32"]
    function changeFee(uint32 arg0) public payable {
        require(arg0 == (uint32(arg0)));
        require(msg.sender == (address(timelockAddress)), CustomError_1c0be90a());
        var_a = 0x1c0be90a00000000000000000000000000000000000000000000000000000000;
        require(!(bytes1(isInterestAccessControlRevoked / 0x0100000000000000)), CustomError_a02a2bcd());
        var_a = 0xa02a2bcd00000000000000000000000000000000000000000000000000000000;
        require(!(uint32(arg0) > 0xc350), CustomError_da0afa57());
        var_a = 0xda0afa5700000000000000000000000000000000000000000000000000000000;
        uint256 var_b = var_b + 0xa0;
        uint256 var_a = 0;
        uint256 var_c = 0;
        uint256 var_d = 0;
        uint256 var_e = 0;
        uint256 var_f = 0;
        var_b = var_b + 0xa0;
        uint32 var_g = uint32(currentRateInfo);
        uint32 var_h = uint32(currentRateInfo / 0x0100000000);
        uint64 var_i = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_j = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_k = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_b = 0x40 + var_b;
        address var_l = address(totalSupply);
        address var_m = address(totalSupply / 0x0100000000000000000000000000000000);
        var_b = 0x40 + var_b;
        address var_n = address(totalBorrow);
        address var_o = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(!0x01, "ERC20: mint to the zero address");
        require(!(address(var_b.length) - (address(var_b.length)) > 0xffffffffffffffffffffffffffffffff), "ERC20: mint to the zero address");
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(!(address(var_b.length - (var_b.length))), "ERC20: mint to the zero address");
        require(address(totalBorrow) == ((address(totalBorrow) * 0x0186a0) / 0x0186a0) | !0x0186a0, "ERC20: mint to the zero address");
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(address(var_b.length - (var_b.length)), "ERC20: mint to the zero address");
        store_h = (address(totalBorrow) * 0x0186a0) / (address(var_b.length - (var_b.length)));
        var_b = 0x0100 + var_b;
        uint256 var_r = 0;
        uint256 var_s = 0;
        uint256 var_t = 0;
        uint256 var_u = 0;
        uint256 var_v = 0;
        uint256 var_w = 0;
        var_b = 0x40 + var_b;
        uint256 var_x = 0;
        uint256 var_y = 0;
        uint256 var_z = var_b;
        var_b = 0x40 + var_b;
        uint256 var_aa = 0;
        uint256 var_ab = 0;
        uint256 var_ac = var_b;
        require(!(!(uint64(var_ad)) == block.timestamp), "ERC20: mint to the zero address");
        require(!(!(uint64(var_ad)) == block.timestamp), "ERC20: mint to the zero address");
        require(!var_b.length, "ERC20: mint to the zero address");
        uint256 var_ae = uint64(var_af);
        uint256 var_ag = uint64(var_ah);
        uint256 var_ai = uint64(var_aj);
        uint256 var_ak = uint64(var_ad);
        emit UpdateRate(uint64(var_af), uint64(var_ah), uint64(var_aj), uint64(var_ad));
        var_ae = var_af;
        var_ag = uint64(var_aj);
        var_ai = var_ah;
        var_ak = var_al;
        emit AddInterest(var_af, uint64(var_aj), var_ah, var_al);
        var_j = uint64(var_aj);
        var_k = uint64(var_am);
        var_i = uint64(block.timestamp);
        var_g = uint32(block.number);
        currentRateInfo = (uint64(var_am) * 0x01000000000000000000000000000000000000000000000000) | (uint192((0x0100000000000000000000000000000000 * (uint64(var_aj))) | ((uint64(block.timestamp) * 0x010000000000000000) | (address((uint32(var_aj) * 0x0100000000) | (uint32(block.number) | (currentRateInfo)))))));
        totalSupply = (0x0100000000000000000000000000000000 * (address(var_an))) | (address(var_ao));
        totalBorrow = (0x0100000000000000000000000000000000 * (address(var_ap))) | (address(var_aq));
        require(!(var_al), "ERC20: mint to the zero address");
        require(address(this), "ERC20: mint to the zero address");
        require(!(store_i > (var_al + store_i)), "ERC20: mint to the zero address");
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        store_i = (var_al) + store_i;
        address var_p = address(this);
        uint256 var_ar = 0x0a;
        storage_map_ak[var_p] = (var_al) + storage_map_ak[var_p];
        var_ae = var_al;
        emit Transfer(0, address(this), var_al);
        currentRateInfo = (uint32(arg0) * 0x0100000000) | (uint224(currentRateInfo));
        var_ae = uint32(arg0);
        emit ChangeFee(uint32(arg0));
        var_ae = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_as = 0x20;
        uint256 var_at = 0x1f;
        uint256 var_au = 0x45524332303a206d696e7420746f20746865207a65726f206164647265737300;
        currentRateInfo = (uint32(arg0) * 0x0100000000) | (uint224(currentRateInfo));
        var_ae = uint32(arg0);
        emit ChangeFee(uint32(arg0));
        currentRateInfo = (uint32(arg0) * 0x0100000000) | (uint224(currentRateInfo));
        var_ae = uint32(arg0);
        emit ChangeFee(uint32(arg0));
        var_r = 0x01;
        var_b = 0x40 + var_b;
        var_ae = address(totalSupply);
        var_ag = address(totalSupply / 0x0100000000000000000000000000000000);
        var_z = var_b;
        var_b = 0x40 + var_b;
        var_ai = address(totalBorrow);
        var_ak = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_ac = var_b;
        require(!(block.timestamp - (uint64(var_am))) > block.timestamp);
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_av = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_aw = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_aw); // staticcall
        var_b = var_b + (uint248(ret0.length + 0x1f));
        require(!((var_b + ret0.length) - var_b) < 0x20);
        require(!(address(var_ao)) > (var_b.length + (address(var_ao))));
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(!var_b.length + (address(var_ax)));
        uint256 var_ay = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_az = block.timestamp - (uint64(var_am));
        uint256 var_ba = 0;
        uint256 var_bb = uint64(var_bc);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_az); // staticcall
        var_b = var_b + (uint248(ret0.length + 0x1f));
        require(!((var_b + ret0.length) - var_b) < 0x40);
        require(var_b.length == (uint64(var_b.length)));
        require(address(var_aq) == ((address(var_aq) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(var_b.length + (address(var_ax)));
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x12;
        var_ay = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_az = block.timestamp - (uint64(var_am));
        var_ba = (address(var_aq) * 0x0186a0) / (var_b.length + (address(var_ax)));
        var_bb = uint64(var_bc);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_az); // staticcall
        require(!address(var_ao));
        var_av = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_aw = block.timestamp - (uint64(var_am));
        var_az = 0;
        var_ba = uint64(var_bc);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_aw, var_az); // staticcall
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x12;
    }
    
    /// @custom:selector    0x3f4ba83a
    /// @custom:signature   unpause() public payable
    function unpause() public payable {
        require(msg.sender == (address(unresolved_8da5cb5b)), CustomError_6f545269());
        require(!(!msg.sender == (address(timelockAddress))), CustomError_6f545269());
        var_a = 0x6f54526900000000000000000000000000000000000000000000000000000000;
        require(bytes1(isBorrowAccessControlRevoked), "ERC20: mint to the zero address");
        require(bytes1(isInterestAccessControlRevoked), "ERC20: mint to the zero address");
        require(bytes1(isInterestAccessControlRevoked / 0x010000), "ERC20: mint to the zero address");
        require(bytes1(isInterestAccessControlRevoked / 0x0100000000), "ERC20: mint to the zero address");
        require(bytes1(isInterestAccessControlRevoked / 0x01000000000000), "ERC20: mint to the zero address");
        require(bytes1(isInterestAccessControlRevoked / 0x010000000000000000), "ERC20: mint to the zero address");
        uint256 var_b = var_b + 0xa0;
        uint256 var_a = 0;
        uint256 var_c = 0;
        uint256 var_d = 0;
        uint256 var_e = 0;
        uint256 var_f = 0;
        var_b = var_b + 0xa0;
        uint32 var_g = uint32(currentRateInfo);
        uint32 var_h = uint32(currentRateInfo / 0x0100000000);
        uint64 var_i = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_j = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_k = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_b = 0x40 + var_b;
        address var_l = address(totalSupply);
        address var_m = address(totalSupply / 0x0100000000000000000000000000000000);
        var_b = 0x40 + var_b;
        address var_n = address(totalBorrow);
        address var_o = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(!0x01, "ERC20: mint to the zero address");
        require(!(address(var_b.length) - (address(var_b.length)) > 0xffffffffffffffffffffffffffffffff), "ERC20: mint to the zero address");
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(!(address(var_b.length - (var_b.length))), "ERC20: mint to the zero address");
        require(address(totalBorrow) == ((address(totalBorrow) * 0x0186a0) / 0x0186a0) | !0x0186a0, "ERC20: mint to the zero address");
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(address(var_b.length - (var_b.length)), "ERC20: mint to the zero address");
        store_h = (address(totalBorrow) * 0x0186a0) / (address(var_b.length - (var_b.length)));
        var_b = 0x0100 + var_b;
        uint256 var_r = 0;
        uint256 var_s = 0;
        uint256 var_t = 0;
        uint256 var_u = 0;
        uint256 var_v = 0;
        uint256 var_w = 0;
        var_b = 0x40 + var_b;
        uint256 var_x = 0;
        uint256 var_y = 0;
        uint256 var_z = var_b;
        var_b = 0x40 + var_b;
        uint256 var_aa = 0;
        uint256 var_ab = 0;
        uint256 var_ac = var_b;
        require(!(!(uint64(var_ad)) == block.timestamp), "ERC20: mint to the zero address");
        require(!(!(uint64(var_ad)) == block.timestamp), "ERC20: mint to the zero address");
        require(!var_b.length, "ERC20: mint to the zero address");
        uint256 var_ae = uint64(var_af);
        uint256 var_ag = uint64(var_ah);
        uint256 var_ai = uint64(var_aj);
        uint256 var_ak = uint64(var_ad);
        emit UpdateRate(uint64(var_af), uint64(var_ah), uint64(var_aj), uint64(var_ad));
        var_ae = var_af;
        var_ag = uint64(var_aj);
        var_ai = var_ah;
        var_ak = var_al;
        emit AddInterest(var_af, uint64(var_aj), var_ah, var_al);
        var_j = uint64(var_aj);
        var_k = uint64(var_am);
        var_i = uint64(block.timestamp);
        var_g = uint32(block.number);
        currentRateInfo = (uint64(var_am) * 0x01000000000000000000000000000000000000000000000000) | (uint192((0x0100000000000000000000000000000000 * (uint64(var_aj))) | ((uint64(block.timestamp) * 0x010000000000000000) | (address((uint32(var_aj) * 0x0100000000) | (uint32(block.number) | (currentRateInfo)))))));
        totalSupply = (0x0100000000000000000000000000000000 * (address(var_an))) | (address(var_ao));
        totalBorrow = (0x0100000000000000000000000000000000 * (address(var_ap))) | (address(var_aq));
        require(!(var_al), "ERC20: mint to the zero address");
        require(address(this), "ERC20: mint to the zero address");
        require(!(store_i > (var_al + store_i)), "ERC20: mint to the zero address");
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        store_i = (var_al) + store_i;
        address var_p = address(this);
        uint256 var_ar = 0x0a;
        storage_map_ak[var_p] = (var_al) + storage_map_ak[var_p];
        var_ae = var_al;
        emit Transfer(0, address(this), var_al);
        isInterestAccessControlRevoked = (uint248(isInterestAccessControlRevoked)) | (0x0100000000000000 * 0);
        var_ae = 0;
        emit PauseInterest(0);
        currentRateInfo = (uint64(block.timestamp) * 0x010000000000000000) | (uint192(currentRateInfo));
        var_ae = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_as = 0x20;
        uint256 var_at = 0x1f;
        uint256 var_au = 0x45524332303a206d696e7420746f20746865207a65726f206164647265737300;
        isInterestAccessControlRevoked = (uint248(isInterestAccessControlRevoked)) | (0x0100000000000000 * 0);
        var_ae = 0;
        emit PauseInterest(0);
        currentRateInfo = (uint64(block.timestamp) * 0x010000000000000000) | (uint192(currentRateInfo));
        isInterestAccessControlRevoked = (uint248(isInterestAccessControlRevoked)) | (0x0100000000000000 * 0);
        var_ae = 0;
        emit PauseInterest(0);
        currentRateInfo = (uint64(block.timestamp) * 0x010000000000000000) | (uint192(currentRateInfo));
        var_r = 0x01;
        var_b = 0x40 + var_b;
        var_ae = address(totalSupply);
        var_ag = address(totalSupply / 0x0100000000000000000000000000000000);
        var_z = var_b;
        var_b = 0x40 + var_b;
        var_ai = address(totalBorrow);
        var_ak = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_ac = var_b;
        require(!(block.timestamp - (uint64(var_am))) > block.timestamp);
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_av = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_aw = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_aw); // staticcall
        var_b = var_b + (uint248(ret0.length + 0x1f));
        require(!((var_b + ret0.length) - var_b) < 0x20);
        require(!(address(var_ao)) > (var_b.length + (address(var_ao))));
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(!var_b.length + (address(var_ax)));
        uint256 var_ay = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_az = block.timestamp - (uint64(var_am));
        uint256 var_ba = 0;
        uint256 var_bb = uint64(var_bc);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_az); // staticcall
        var_b = var_b + (uint248(ret0.length + 0x1f));
        require(!((var_b + ret0.length) - var_b) < 0x40);
        require(var_b.length == (uint64(var_b.length)));
        require(address(var_aq) == ((address(var_aq) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(var_b.length + (address(var_ax)));
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x12;
        var_ay = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_az = block.timestamp - (uint64(var_am));
        var_ba = (address(var_aq) * 0x0186a0) / (var_b.length + (address(var_ax)));
        var_bb = uint64(var_bc);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_az); // staticcall
        require(!address(var_ao));
        var_av = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_aw = block.timestamp - (uint64(var_am));
        var_az = 0;
        var_ba = uint64(var_bc);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_aw, var_az); // staticcall
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x12;
    }
    
    /// @custom:selector    0xa457c2d7
    /// @custom:signature   decreaseAllowance(address arg0, uint256 arg1) public payable returns (bool)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function decreaseAllowance(address arg0, uint256 arg1) public payable returns (bool) {
        require(arg0 == (address(arg0)));
        address var_a = address(msg.sender);
        var_b = 0x0b;
        var_a = address(arg0);
        address var_b = keccak256(var_a);
        require(!(storage_map_v[var_a] < arg1), "ERC20: decreased allowance below zero");
        var_c = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_d = 0x20;
        var_e = 0x25;
        var_f = 0x45524332303a2064656372656173656420616c6c6f77616e63652062656c6f77;
        var_g = 0x207a65726f000000000000000000000000000000000000000000000000000000;
        require(address(msg.sender), "ERC20: approve to the zero address");
        require(address(arg0), "ERC20: approve to the zero address");
        var_a = address(msg.sender);
        var_b = 0x0b;
        var_a = address(arg0);
        var_b = keccak256(var_a);
        storage_map_v[var_a] = storage_map_v[var_a] - arg1;
        address var_c = storage_map_v[var_a] - arg1;
        emit Approval(address(msg.sender), address(arg0), storage_map_v[var_a] - arg1);
        var_c = 0x01;
        return 0x01;
        var_c = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_d = 0x20;
        var_e = 0x22;
        var_f = 0x45524332303a20617070726f766520746f20746865207a65726f206164647265;
        var_g = 0x7373000000000000000000000000000000000000000000000000000000000000;
        var_c = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_d = 0x20;
        var_e = 0x24;
        var_f = 0x45524332303a20617070726f76652066726f6d20746865207a65726f20616464;
        var_g = 0x7265737300000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x45014095
    /// @custom:signature   transferTimelock(address arg0) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function transferTimelock(address arg0) public payable {
        require(arg0 == (address(arg0)));
        require(msg.sender == (address(timelockAddress)), CustomError_1c0be90a());
        var_a = 0x1c0be90a00000000000000000000000000000000000000000000000000000000;
        pendingTimelockAddress = (address(arg0)) | (uint96(pendingTimelockAddress));
        emit TimelockTransferStarted(address(timelockAddress), address(arg0));
    }
    
    /// @custom:selector    0x1c6c9597
    /// @custom:signature   Unresolved_1c6c9597(uint256 arg0) public payable returns (bytes memory)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function Unresolved_1c6c9597(uint256 arg0) public payable returns (bytes memory) {
        require(arg0 == arg0);
        uint256 var_a = var_a + 0xa0;
        uint256 var_b = 0;
        uint256 var_c = 0;
        uint256 var_d = 0;
        uint256 var_e = 0;
        uint256 var_f = 0;
        var_a = 0x40 + var_a;
        uint256 var_g = 0;
        uint256 var_h = 0;
        var_a = 0x40 + var_a;
        uint256 var_i = 0;
        uint256 var_j = 0;
        require(store_d - 0x02, "ReentrancyGuard: reentrant call");
        var_k = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_l = 0x20;
        var_m = 0x1f;
        var_n = 0x5265656e7472616e637947756172643a207265656e7472616e742063616c6c00;
        store_d = 0x02;
        var_a = var_a + 0xa0;
        uint32 var_k = uint32(currentRateInfo);
        uint32 var_o = uint32(currentRateInfo / 0x0100000000);
        uint64 var_p = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_q = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_r = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x40 + var_a;
        address var_s = address(totalSupply);
        address var_t = address(totalSupply / 0x0100000000000000000000000000000000);
        require(address(unresolved_7bcad14c));
        var_u = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        address var_v = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_v); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!(((var_a + ret0.length) - var_a) < 0x20), "ERC20: mint to the zero address");
        require(!(address(var_a.length) > (var_a.length + (address(var_a.length)))), "ERC20: mint to the zero address");
        var_w = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_x = 0x11;
        require(!(var_a.length + (address(var_a.length))), "ERC20: mint to the zero address");
        require(0 > store_h, "ERC20: mint to the zero address");
        require(!((0 - store_h) > 0), "ERC20: mint to the zero address");
        var_w = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_x = 0x11;
        require(!store_h, "ERC20: mint to the zero address");
        require((unresolved_1956473f == ((unresolved_1956473f * store_h) / store_h)) | !store_h, "ERC20: mint to the zero address");
        var_w = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_x = 0x11;
        require(0x0186a0, "ERC20: mint to the zero address");
        var_w = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_x = 0x12;
        require(!((0 - store_h) < ((unresolved_1956473f * store_h) / 0x0186a0)), "ERC20: mint to the zero address");
        uint256 var_y = var_f - store_h;
        emit Event_479ca0b7(0 - store_h);
        require(!arg0, "ERC20: mint to the zero address");
        var_a = 0x40 + var_a;
        var_y = address(totalSupply);
        address var_z = address(totalSupply / 0x0100000000000000000000000000000000);
        var_a = 0x40 + var_a;
        uint256 var_aa = address(totalBorrow);
        uint256 var_ab = address(totalBorrow / 0x0100000000000000000000000000000000);
        store_d = 0x01;
        uint256 var_ac = 0;
        uint256 var_ad = 0;
        uint256 var_ae = 0;
        uint256 var_af = uint32(var_a.length);
        uint256 var_ag = uint32(var_ah);
        uint256 var_ai = uint64(var_aj);
        uint256 var_ak = uint64(var_al);
        uint256 var_am = uint64(var_an);
        uint256 var_ao = address(var_a.length);
        uint256 var_ap = address(var_aq);
        uint256 var_ar = address(var_a.length);
        uint256 var_as = address(var_ah);
        return abi.encodePacked(0, 0, 0, uint32(var_a.length), uint32(var_at), uint64(var_au), uint64(var_av), uint64(var_aw), address(var_a.length), address(var_ax), address(var_a.length), address(var_at));
        store_d = 0x01;
        var_y = 0;
        var_z = 0;
        var_aa = 0;
        var_ab = uint32(var_a.length);
        var_ac = uint32(var_ah);
        var_ad = uint64(var_aj);
        var_ae = uint64(var_al);
        var_af = uint64(var_an);
        var_ag = address(var_a.length);
        var_ai = address(var_aq);
        var_ak = address(var_a.length);
        var_am = address(var_ah);
        return abi.encodePacked(0, 0, 0, uint32(var_a.length), uint32(var_at), uint64(var_au), uint64(var_av), uint64(var_aw), address(var_a.length), address(var_ax), address(var_a.length), address(var_at));
        var_a = var_a + 0xa0;
        var_y = 0;
        var_z = 0;
        var_aa = 0;
        var_ab = 0;
        var_ac = 0;
        var_a = var_a + 0xa0;
        var_ad = uint32(currentRateInfo);
        var_ae = uint32(currentRateInfo / 0x0100000000);
        var_af = uint64(currentRateInfo / 0x010000000000000000);
        var_ag = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        var_ai = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x40 + var_a;
        var_ak = address(totalSupply);
        var_am = address(totalSupply / 0x0100000000000000000000000000000000);
        var_a = 0x40 + var_a;
        var_ao = address(totalBorrow);
        var_ap = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(!0x01, "ERC20: mint to the zero address");
        require(!(address(var_a.length) - (address(var_a.length)) > 0xffffffffffffffffffffffffffffffff), "ERC20: mint to the zero address");
        var_w = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_x = 0x11;
        require(!(address(var_a.length - (var_a.length))), "ERC20: mint to the zero address");
        require(address(totalBorrow) == ((address(totalBorrow) * 0x0186a0) / 0x0186a0) | !0x0186a0, "ERC20: mint to the zero address");
        var_w = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_x = 0x11;
        require(address(var_a.length - (var_a.length)), "ERC20: mint to the zero address");
        store_h = (address(totalBorrow) * 0x0186a0) / (address(var_a.length - (var_a.length)));
        var_a = 0x0100 + var_a;
        var_ar = 0;
        var_as = 0;
        uint256 var_ay = 0;
        uint256 var_az = 0;
        uint256 var_ba = 0;
        uint256 var_bb = 0;
        var_a = 0x40 + var_a;
        uint256 var_bc = 0;
        uint256 var_bd = 0;
        uint256 var_be = var_a;
        var_a = 0x40 + var_a;
        uint256 var_bf = 0;
        uint256 var_bg = 0;
        uint256 var_bh = var_a;
        require(!(!(uint64(var_bi)) == block.timestamp), "ERC20: mint to the zero address");
        require(!(!(uint64(var_bi)) == block.timestamp), "ERC20: mint to the zero address");
        require(!var_a.length, "ERC20: mint to the zero address");
        uint256 var_bj = uint64(var_bk);
        uint256 var_bl = uint64(var_bm);
        uint256 var_bn = uint64(var_aq);
        uint256 var_bo = uint64(var_bi);
        emit UpdateRate(uint64(var_bk), uint64(var_bm), uint64(var_aq), uint64(var_bi));
        var_bj = var_bk;
        var_bl = uint64(var_aq);
        var_bn = var_bm;
        var_bo = var_bp;
        emit AddInterest(var_bk, uint64(var_aq), var_bm, var_bp);
        var_ag = uint64(var_aq);
        var_ai = uint64(var_aj);
        var_af = uint64(block.timestamp);
        var_ad = uint32(block.number);
        currentRateInfo = (uint64(var_aj) * 0x01000000000000000000000000000000000000000000000000) | (uint192((0x0100000000000000000000000000000000 * (uint64(var_aq))) | ((uint64(block.timestamp) * 0x010000000000000000) | (address((uint32(var_aq) * 0x0100000000) | (uint32(block.number) | (currentRateInfo)))))));
        totalSupply = (0x0100000000000000000000000000000000 * (address(var_bq))) | (address(var_br));
        totalBorrow = (0x0100000000000000000000000000000000 * (address(var_bs))) | (address(var_bt));
        require(!(var_bp), "ERC20: mint to the zero address");
        require(address(this), "ERC20: mint to the zero address");
        require(!(store_i > (var_bp + store_i)), "ERC20: mint to the zero address");
        var_w = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_x = 0x11;
        store_i = (var_bp) + store_i;
        address var_w = address(this);
        uint256 var_bu = 0x0a;
        storage_map_al[var_w] = (var_bp) + storage_map_al[var_w];
        var_bj = var_bp;
        emit Transfer(0, address(this), var_bp);
        require(!arg0, "ERC20: mint to the zero address");
        var_a = 0x40 + var_a;
        var_bj = address(totalSupply);
        var_bl = address(totalSupply / 0x0100000000000000000000000000000000);
        var_a = 0x40 + var_a;
        var_bn = address(totalBorrow);
        var_bo = address(totalBorrow / 0x0100000000000000000000000000000000);
        store_d = 0x01;
        uint256 var_bv = var_bk;
        uint256 var_bw = var_bm;
        uint256 var_bx = var_bp;
        uint256 var_by = uint32(var_a.length);
        uint256 var_bz = uint32(var_ah);
        uint256 var_ca = uint64(var_aj);
        uint256 var_cb = uint64(var_al);
        uint256 var_cc = uint64(var_an);
        uint256 var_cd = address(var_a.length);
        uint256 var_ce = address(var_aq);
        uint256 var_cf = address(var_a.length);
        uint256 var_cg = address(var_ah);
        return abi.encodePacked(var_bk, var_bm, var_bp, uint32(var_a.length), uint32(var_at), uint64(var_au), uint64(var_av), uint64(var_aw), address(var_a.length), address(var_ax), address(var_a.length), address(var_at));
        store_d = 0x01;
        var_bj = var_bk;
        var_bl = var_bm;
        var_bn = var_bp;
        var_bo = uint32(var_a.length);
        var_bv = uint32(var_ah);
        var_bw = uint64(var_aj);
        var_bx = uint64(var_al);
        var_by = uint64(var_an);
        var_bz = address(var_a.length);
        var_ca = address(var_aq);
        var_cb = address(var_a.length);
        var_cc = address(var_ah);
        return abi.encodePacked(var_bk, var_bm, var_bp, uint32(var_a.length), uint32(var_at), uint64(var_au), uint64(var_av), uint64(var_aw), address(var_a.length), address(var_ax), address(var_a.length), address(var_at));
        var_bj = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_ch = 0x20;
        uint256 var_ci = 0x1f;
        uint256 var_cj = 0x45524332303a206d696e7420746f20746865207a65726f206164647265737300;
        var_ar = 0x01;
        var_a = 0x40 + var_a;
        var_bj = address(totalSupply);
        var_bl = address(totalSupply / 0x0100000000000000000000000000000000);
        var_be = var_a;
        var_a = 0x40 + var_a;
        var_bn = address(totalBorrow);
        var_bo = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_bh = var_a;
        require(!(block.timestamp - (uint64(var_aj))) > block.timestamp);
        var_w = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_x = 0x11;
        require(address(unresolved_7bcad14c));
        var_bv = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_ck = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ck, var_cl); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_br)) > (var_a.length + (address(var_br))));
        var_w = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_x = 0x11;
        require(!var_a.length + (address(var_cm)));
        var_bw = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_cl = block.timestamp - (uint64(var_aj));
        uint256 var_cn = 0;
        uint256 var_co = uint64(var_an);
        (bool success, bytes memory ret0) = address(rateContract).getNewRate(var_cl, var_cn, var_co); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x40);
        require(var_a.length == (uint64(var_a.length)));
        require(address(var_bt) == ((address(var_bt) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_w = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_x = 0x11;
        require(var_a.length + (address(var_cm)));
        var_w = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_x = 0x12;
        var_bw = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_cl = block.timestamp - (uint64(var_aj));
        var_cn = (address(var_bt) * 0x0186a0) / (var_a.length + (address(var_cm)));
        var_co = uint64(var_an);
        (bool success, bytes memory ret0) = address(rateContract).getNewRate(var_cl, var_cn, var_co); // staticcall
        require(!address(var_br));
        var_bv = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ck = block.timestamp - (uint64(var_aj));
        var_cl = 0;
        var_cn = uint64(var_an);
        (bool success, bytes memory ret0) = address(rateContract).getNewRate(var_ck, var_cl, var_cn); // staticcall
        var_w = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_x = 0x12;
        if (!address(var_a.length)) {
            require(!address(var_a.length));
        }
    }
    
    /// @custom:selector    0x02ce728f
    /// @custom:signature   updateExchangeRate() public payable returns (bool)
    function updateExchangeRate() public payable returns (bool) {
        require(store_d - 0x02, "ReentrancyGuard: reentrant call");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x1f;
        var_d = 0x5265656e7472616e637947756172643a207265656e7472616e742063616c6c00;
        store_d = 0x02;
        uint256 var_e = var_e + 0xa0;
        address var_a = address(exchangeRateInfo);
        uint32 var_f = uint32(exchangeRateInfo / 0x010000000000000000000000000000000000000000);
        uint184 var_g = uint184(store_l);
        var_h = store_m;
        var_i = store_n;
        require(block.timestamp == (uint184(store_l)));
        require(!(var_j - (var_k)) > (var_j));
        var_l = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_m = 0x11;
        require(var_j - (var_k) == ((var_j - (var_k) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_l = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_m = 0x11;
        require(var_j);
        require((var_j - (var_k) * 0x0186a0) / (var_j) > (uint32(var_n)));
        store_d = 0x01;
        uint256 var_o = 0;
        var_p = var_q;
        var_r = var_s;
        return abi.encodePacked(0, var_q, var_s);
        store_d = 0x01;
        var_o = 0x01;
        var_p = var_q;
        var_r = var_s;
        return abi.encodePacked(0x01, var_q, var_s);
        var_l = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_m = 0x12;
        var_o = 0xbd9a548b00000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(var_t).getPrices(var_u); // staticcall
        var_e = var_e + (uint248(ret0.length + 0x1f));
        if (!((var_e + ret0.length) - var_e) < 0x60) {
            require(!((var_e + ret0.length) - var_e) < 0x60);
            require(var_e.length == var_e.length);
        }
    }
    
    /// @custom:selector    0xc63d75b6
    /// @custom:signature   maxMint(address arg0) public payable returns (address)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function maxMint(address arg0) public payable returns (address) {
        require(arg0 == (address(arg0)));
        uint256 var_a = var_a + 0xa0;
        uint256 var_b = 0;
        uint256 var_c = 0;
        uint256 var_d = 0;
        uint256 var_e = 0;
        uint256 var_f = 0;
        var_a = 0x40 + var_a;
        uint256 var_g = 0;
        uint256 var_h = 0;
        var_a = 0x40 + var_a;
        uint256 var_i = 0;
        uint256 var_j = 0;
        var_a = var_a + 0xa0;
        uint32 var_k = uint32(currentRateInfo);
        uint32 var_l = uint32(currentRateInfo / 0x0100000000);
        uint64 var_m = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_o = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x0100 + var_a;
        uint256 var_p = 0;
        uint256 var_q = 0;
        uint256 var_r = 0;
        uint256 var_s = 0;
        uint256 var_t = 0;
        uint256 var_u = 0;
        var_a = 0x40 + var_a;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = var_a;
        var_a = 0x40 + var_a;
        uint256 var_y = 0;
        uint256 var_z = 0;
        uint256 var_aa = var_a;
        require(uint64(var_ab) == block.timestamp);
        require(uint64(var_ab) == block.timestamp);
        require(!var_a.length);
        var_n = uint64(var_ac);
        var_o = uint64(var_ad);
        require(0);
        uint256 var_ae = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_af = address(this);
        (bool success, bytes memory ret0) = address(0).Unresolved_22bbc2d2(var_af); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_ag)) > (var_a.length + (address(var_ag))));
        uint256 var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        uint256 var_ai = 0x11;
        require(!(var_a.length + (address(var_aj))) < depositLimit);
        require(0 - (address(var_ag)));
        require(address(var_ak) == ((address(var_ak) * 0) / 0) | !0);
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(address(var_ag));
        require(!0);
        require(address(var_al) == (address(var_al) * ((address(var_ak) * 0) / (address(var_ag))) / ((address(var_ak) * 0) / (address(var_ag)))) | (!(address(var_ak) * 0) / (address(var_ag))));
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(address(var_am));
        require(!(address(var_al) * ((address(var_ak) * 0) / (address(var_ag))) / (address(var_am))) < 0);
        uint256 var_an = (address(var_ak) * 0) / (address(var_ag));
        return (address(var_ak) * 0) / (address(var_ag));
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x12;
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x12;
        var_an = 0;
        return 0;
        var_a = 0x40 + var_a;
        var_ae = address(totalSupply);
        var_an = address(totalSupply / 0x0100000000000000000000000000000000);
        var_a = 0x40 + var_a;
        uint256 var_ao = address(totalBorrow);
        uint256 var_ap = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(0);
        uint256 var_aq = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_ar = address(this);
        (bool success, bytes memory ret0) = address(0).Unresolved_22bbc2d2(var_ar); // staticcall
        var_p = 0x01;
        var_a = 0x40 + var_a;
        var_ae = address(totalSupply);
        var_an = address(totalSupply / 0x0100000000000000000000000000000000);
        var_x = var_a;
        var_a = 0x40 + var_a;
        var_ao = address(totalBorrow);
        var_ap = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_aa = var_a;
        require(!(block.timestamp - (uint64(var_ad))) > block.timestamp);
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(address(unresolved_7bcad14c));
        var_aq = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        var_ar = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_ar); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_ag)) > (var_a.length + (address(var_ag))));
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(!var_a.length + (address(var_aj)));
        uint256 var_as = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_at = block.timestamp - (uint64(var_ad));
        uint256 var_au = 0;
        uint256 var_av = uint64(var_aw);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_at); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x40);
        require(var_a.length == (uint64(var_a.length)));
        require(address(var_ax) == ((address(var_ax) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x11;
        require(var_a.length + (address(var_aj)));
        var_ah = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_ai = 0x12;
        var_as = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_at = block.timestamp - (uint64(var_ad));
        var_au = (address(var_ax) * 0x0186a0) / (var_a.length + (address(var_aj)));
        var_av = uint64(var_aw);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_at); // staticcall
        require(!address(var_ag));
        var_aq = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_ar = block.timestamp - (uint64(var_ad));
        var_at = 0;
        var_au = uint64(var_aw);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_ar, var_at); // staticcall
    }
    
    /// @custom:selector    0xf2fde38b
    /// @custom:signature   transferOwnership(address arg0) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function transferOwnership(address arg0) public payable {
        require(arg0 == (address(arg0)));
        require(msg.sender == (address(unresolved_8da5cb5b)), "Ownable: caller is not the owner");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x20;
        var_d = 0x4f776e61626c653a2063616c6c6572206973206e6f7420746865206f776e6572;
        pendingOwner = (address(arg0)) | (uint96(pendingOwner));
        emit OwnershipTransferStarted(address(unresolved_8da5cb5b), address(arg0));
    }
    
    /// @custom:selector    0x4fd422df
    /// @custom:signature   userBorrowShares(address arg0) public view returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function userBorrowShares(address arg0) public view returns (uint256) {
        require(arg0 == (address(arg0)));
        var_a = 0x23;
        address var_b = arg0;
        address var_c = storage_map_x[var_b];
        return storage_map_x[var_b];
    }
    
    /// @custom:selector    0x99530b06
    /// @custom:signature   pricePerShare() public payable returns (address)
    function pricePerShare() public payable returns (address) {
        require(!0x01);
        uint256 var_a = 0x40 + var_a;
        address var_b = address(totalSupply);
        address var_c = address(totalSupply / 0x0100000000000000000000000000000000);
        require(0 - (address(var_d)));
        require(address(var_a.length) == ((address(var_a.length) * 0x0de0b6b3a7640000) / 0x0de0b6b3a7640000) | !0x0de0b6b3a7640000);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(address(var_g));
        require(!0);
        require(address(var_d) == (address(var_d) * ((address(var_a.length) * 0x0de0b6b3a7640000) / (address(var_h))) / ((address(var_a.length) * 0x0de0b6b3a7640000) / (address(var_h)))) | (!(address(var_a.length) * 0x0de0b6b3a7640000) / (address(var_h))));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(address(var_i));
        require(!(address(var_d) * ((address(var_a.length) * 0x0de0b6b3a7640000) / (address(var_h))) / (address(var_j))) < 0x0de0b6b3a7640000);
        uint256 var_k = (address(var_a.length) * 0x0de0b6b3a7640000) / (address(var_h));
        return (address(var_a.length) * 0x0de0b6b3a7640000) / (address(var_h));
        require(!0x01 > ((address(var_a.length) * 0x0de0b6b3a7640000) / (address(var_h)) + 0x01));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        var_k = ((address(var_a.length) * 0x0de0b6b3a7640000) / (address(var_h))) + 0x01;
        return ((address(var_a.length) * 0x0de0b6b3a7640000) / (address(var_h))) + 0x01;
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x12;
        require(!0);
        var_k = (address(var_a.length) * 0x0de0b6b3a7640000) / (address(var_h));
        return (address(var_a.length) * 0x0de0b6b3a7640000) / (address(var_h));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x12;
        var_k = 0x0de0b6b3a7640000;
        return 0x0de0b6b3a7640000;
        var_a = var_a + 0xa0;
        var_b = 0;
        var_c = 0;
        var_k = 0;
        uint256 var_l = 0;
        uint256 var_m = 0;
        var_a = 0x40 + var_a;
        uint256 var_n = 0;
        uint256 var_o = 0;
        var_a = 0x40 + var_a;
        uint256 var_p = 0;
        uint256 var_q = 0;
        var_a = var_a + 0xa0;
        uint32 var_r = uint32(currentRateInfo);
        uint32 var_s = uint32(currentRateInfo / 0x0100000000);
        uint64 var_t = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_u = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_v = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x0100 + var_a;
        uint256 var_w = 0;
        uint256 var_x = 0;
        uint256 var_y = 0;
        uint256 var_z = 0;
        uint256 var_aa = 0;
        uint256 var_ab = 0;
        var_a = 0x40 + var_a;
        uint256 var_ac = 0;
        uint256 var_ad = 0;
        uint256 var_ae = var_a;
        var_a = 0x40 + var_a;
        uint256 var_af = 0;
        uint256 var_ag = 0;
        uint256 var_ah = var_a;
        require(uint64(var_ai) == block.timestamp);
        require(uint64(var_ai) == block.timestamp);
        require(!var_a.length);
        var_u = uint64(var_g);
        var_v = uint64(var_aj);
        require(0 - (address(var_ak)));
        uint256 var_al = 0x0de0b6b3a7640000;
        return 0x0de0b6b3a7640000;
        var_w = 0x01;
        var_a = 0x40 + var_a;
        var_al = address(totalSupply);
        uint256 var_am = address(totalSupply / 0x0100000000000000000000000000000000);
        var_ae = var_a;
        var_a = 0x40 + var_a;
        uint256 var_an = address(totalBorrow);
        uint256 var_ao = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_ah = var_a;
        require(!(block.timestamp - (uint64(var_aj))) > block.timestamp);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_ap = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_aq = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_aq); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_ar)) > (var_a.length + (address(var_ar))));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(!var_a.length + (address(var_as)));
        uint256 var_at = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_au = block.timestamp - (uint64(var_aj));
        uint256 var_av = 0;
        uint256 var_aw = uint64(var_ax);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_au); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x40);
        require(var_a.length == (uint64(var_a.length)));
        require(address(var_ay) == ((address(var_ay) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(var_a.length + (address(var_as)));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x12;
        var_at = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_au = block.timestamp - (uint64(var_aj));
        var_av = (address(var_ay) * 0x0186a0) / (var_a.length + (address(var_as)));
        var_aw = uint64(var_ax);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_au); // staticcall
        require(!address(var_ar));
        var_ap = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_aq = block.timestamp - (uint64(var_aj));
        var_au = 0;
        var_av = uint64(var_ax);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_aq, var_au); // staticcall
    }
    
    /// @custom:selector    0xcacf3b58
    /// @custom:signature   previewAddInterest() public payable returns (bytes memory)
    function previewAddInterest() public payable returns (bytes memory) {
        uint256 var_a = var_a + 0xa0;
        uint256 var_b = 0;
        uint256 var_c = 0;
        uint256 var_d = 0;
        uint256 var_e = 0;
        uint256 var_f = 0;
        var_a = 0x40 + var_a;
        uint256 var_g = 0;
        uint256 var_h = 0;
        var_a = 0x40 + var_a;
        uint256 var_i = 0;
        uint256 var_j = 0;
        var_a = var_a + 0xa0;
        uint32 var_k = uint32(currentRateInfo);
        uint32 var_l = uint32(currentRateInfo / 0x0100000000);
        uint64 var_m = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_n = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_o = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x0100 + var_a;
        uint256 var_p = 0;
        uint256 var_q = 0;
        uint256 var_r = 0;
        uint256 var_s = 0;
        uint256 var_t = 0;
        uint256 var_u = 0;
        var_a = 0x40 + var_a;
        uint256 var_v = 0;
        uint256 var_w = 0;
        uint256 var_x = var_a;
        var_a = 0x40 + var_a;
        uint256 var_y = 0;
        uint256 var_z = 0;
        uint256 var_aa = var_a;
        require(uint64(var_ab) == block.timestamp);
        require(uint64(var_ab) == block.timestamp);
        require(!var_a.length);
        var_n = uint64(var_ac);
        var_o = uint64(var_ad);
        uint256 var_ae = var_af;
        uint256 var_ag = var_ah;
        uint256 var_ai = var_aj;
        uint256 var_ak = uint32(var_a.length);
        uint256 var_al = uint32(var_ac);
        uint256 var_am = uint64(var_ad);
        uint256 var_an = uint64(var_af);
        uint256 var_ao = uint64(var_ah);
        uint256 var_ap = address(var_aq);
        uint256 var_ar = address(var_as);
        uint256 var_at = address(var_au);
        uint256 var_av = address(var_aw);
        return abi.encodePacked(var_af, var_ah, var_aj, uint32(var_a.length), uint32(var_ax), uint64(var_ay), uint64(var_af), uint64(var_ah), address(var_az), address(var_ba), address(var_bb), address(var_bc));
        var_a = 0x40 + var_a;
        var_ae = address(totalSupply);
        var_ag = address(totalSupply / 0x0100000000000000000000000000000000);
        var_a = 0x40 + var_a;
        var_ai = address(totalBorrow);
        var_ak = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_al = 0;
        var_am = 0;
        var_an = 0;
        var_ao = uint32(var_a.length);
        var_ap = uint32(var_ac);
        var_ar = uint64(var_ad);
        var_at = uint64(var_af);
        var_av = uint64(var_ah);
        uint256 var_bd = address(var_a.length);
        uint256 var_be = address(var_bf);
        uint256 var_bg = address(var_a.length);
        uint256 var_bh = address(var_ac);
        return abi.encodePacked(0, 0, 0, uint32(var_a.length), uint32(var_ax), uint64(var_ay), uint64(var_bi), uint64(var_bj), address(var_a.length), address(var_bk), address(var_a.length), address(var_ax));
        var_p = 0x01;
        var_a = 0x40 + var_a;
        var_ae = address(totalSupply);
        var_ag = address(totalSupply / 0x0100000000000000000000000000000000);
        var_x = var_a;
        var_a = 0x40 + var_a;
        var_ai = address(totalBorrow);
        var_ak = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_aa = var_a;
        require(!(block.timestamp - (uint64(var_ad))) > block.timestamp);
        uint256 var_bl = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        uint256 var_bm = 0x11;
        require(address(unresolved_7bcad14c));
        var_al = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_bn = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_bn, var_bo); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_aq)) > (var_a.length + (address(var_aq))));
        var_bl = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_bm = 0x11;
        require(!var_a.length + (address(var_az)));
        var_am = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_bo = block.timestamp - (uint64(var_ad));
        uint256 var_bp = 0;
        uint256 var_bq = uint64(var_ah);
        (bool success, bytes memory ret0) = address(rateContract).getNewRate(var_bo, var_bp, var_bq); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x40);
        require(var_a.length == (uint64(var_a.length)));
        require(address(var_au) == ((address(var_au) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_bl = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_bm = 0x11;
        require(var_a.length + (address(var_az)));
        var_bl = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_bm = 0x12;
        var_am = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_bo = block.timestamp - (uint64(var_ad));
        var_bp = (address(var_au) * 0x0186a0) / (var_a.length + (address(var_az)));
        var_bq = uint64(var_ah);
        (bool success, bytes memory ret0) = address(rateContract).getNewRate(var_bo, var_bp, var_bq); // staticcall
        require(!address(var_aq));
        var_al = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_bn = block.timestamp - (uint64(var_ad));
        var_bo = 0;
        var_bp = uint64(var_ah);
        (bool success, bytes memory ret0) = address(rateContract).getNewRate(var_bn, var_bo, var_bp); // staticcall
    }
    
    /// @custom:selector    0x0e9bdced
    /// @custom:signature   Unresolved_0e9bdced(uint256 arg0, uint256 arg1, uint256 arg2, uint256 arg3) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["uint256", "bytes32", "int256"]
    function Unresolved_0e9bdced(uint256 arg0, uint256 arg1, uint256 arg2, uint256 arg3) public payable {
        require(msg.sender == (address(timelockAddress)), CustomError_1c0be90a());
        var_a = 0x1c0be90a00000000000000000000000000000000000000000000000000000000;
        require(!(bytes1(isOracleSetterRevoked / 0x01000000)), CustomError_8c34a9b8());
        var_a = cleanLiquidationFee;
        var_b = dirtyLiquidationFee;
        var_c = protocolLiquidationFee;
        uint256 var_d = arg0;
        uint256 var_e = arg1;
        uint256 var_f = arg2;
        emit SetLiquidationFees(cleanLiquidationFee, dirtyLiquidationFee, protocolLiquidationFee, arg0, arg1, arg2);
        cleanLiquidationFee = arg0;
        dirtyLiquidationFee = arg1;
        protocolLiquidationFee = arg2;
        unresolved_37500763 = arg3;
        var_a = 0x8c34a9b800000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x8456cb59
    /// @custom:signature   pause() public payable
    function pause() public payable {
        require(msg.sender == (address(circuitBreakerAddress)), "ERC20: mint to the zero address");
        require(!(!msg.sender == (address(unresolved_8da5cb5b))), "ERC20: mint to the zero address");
        require(!(!0xaffa38aebd90612ba9820a9bbb82fee6542bacc7 == msg.sender), "ERC20: mint to the zero address");
        require(!(!0xaffa38aebd90612ba9820a9bbb82fee6542bacc7 == msg.sender), "ERC20: mint to the zero address");
        require(bytes1(isBorrowAccessControlRevoked), "ERC20: mint to the zero address");
        require(bytes1(isInterestAccessControlRevoked), "ERC20: mint to the zero address");
        require(bytes1(isInterestAccessControlRevoked / 0x010000), "ERC20: mint to the zero address");
        require(bytes1(isInterestAccessControlRevoked / 0x0100000000), "ERC20: mint to the zero address");
        require(bytes1(isInterestAccessControlRevoked / 0x01000000000000), "ERC20: mint to the zero address");
        require(bytes1(isInterestAccessControlRevoked / 0x010000000000000000), "ERC20: mint to the zero address");
        uint256 var_a = var_a + 0xa0;
        uint256 var_b = 0;
        uint256 var_c = 0;
        uint256 var_d = 0;
        uint256 var_e = 0;
        uint256 var_f = 0;
        var_a = var_a + 0xa0;
        uint32 var_g = uint32(currentRateInfo);
        uint32 var_h = uint32(currentRateInfo / 0x0100000000);
        uint64 var_i = uint64(currentRateInfo / 0x010000000000000000);
        uint64 var_j = uint64(currentRateInfo / 0x0100000000000000000000000000000000);
        uint64 var_k = uint64(currentRateInfo / 0x01000000000000000000000000000000000000000000000000);
        var_a = 0x40 + var_a;
        address var_l = address(totalSupply);
        address var_m = address(totalSupply / 0x0100000000000000000000000000000000);
        var_a = 0x40 + var_a;
        address var_n = address(totalBorrow);
        address var_o = address(totalBorrow / 0x0100000000000000000000000000000000);
        require(!0x01, "ERC20: mint to the zero address");
        require(!(address(var_a.length) - (address(var_a.length)) > 0xffffffffffffffffffffffffffffffff), "ERC20: mint to the zero address");
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(!(address(var_a.length - (var_a.length))), "ERC20: mint to the zero address");
        require(address(totalBorrow) == ((address(totalBorrow) * 0x0186a0) / 0x0186a0) | !0x0186a0, "ERC20: mint to the zero address");
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(address(var_a.length - (var_a.length)), "ERC20: mint to the zero address");
        store_h = (address(totalBorrow) * 0x0186a0) / (address(var_a.length - (var_a.length)));
        var_a = 0x0100 + var_a;
        uint256 var_r = 0;
        uint256 var_s = 0;
        uint256 var_t = 0;
        uint256 var_u = 0;
        uint256 var_v = 0;
        uint256 var_w = 0;
        var_a = 0x40 + var_a;
        uint256 var_x = 0;
        uint256 var_y = 0;
        uint256 var_z = var_a;
        var_a = 0x40 + var_a;
        uint256 var_aa = 0;
        uint256 var_ab = 0;
        uint256 var_ac = var_a;
        require(!(!(uint64(var_ad)) == block.timestamp), "ERC20: mint to the zero address");
        require(!(!(uint64(var_ad)) == block.timestamp), "ERC20: mint to the zero address");
        require(!var_a.length, "ERC20: mint to the zero address");
        uint256 var_ae = uint64(var_af);
        uint256 var_ag = uint64(var_ah);
        uint256 var_ai = uint64(var_aj);
        uint256 var_ak = uint64(var_ad);
        emit UpdateRate(uint64(var_af), uint64(var_ah), uint64(var_aj), uint64(var_ad));
        var_ae = var_af;
        var_ag = uint64(var_aj);
        var_ai = var_ah;
        var_ak = var_al;
        emit AddInterest(var_af, uint64(var_aj), var_ah, var_al);
        var_j = uint64(var_aj);
        var_k = uint64(var_am);
        var_i = uint64(block.timestamp);
        var_g = uint32(block.number);
        currentRateInfo = (uint64(var_am) * 0x01000000000000000000000000000000000000000000000000) | (uint192((0x0100000000000000000000000000000000 * (uint64(var_aj))) | ((uint64(block.timestamp) * 0x010000000000000000) | (address((uint32(var_aj) * 0x0100000000) | (uint32(block.number) | (currentRateInfo)))))));
        totalSupply = (0x0100000000000000000000000000000000 * (address(var_an))) | (address(var_ao));
        totalBorrow = (0x0100000000000000000000000000000000 * (address(var_ap))) | (address(var_aq));
        require(!(var_al), "ERC20: mint to the zero address");
        require(address(this), "ERC20: mint to the zero address");
        require(!(store_i > (var_al + store_i)), "ERC20: mint to the zero address");
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        store_i = (var_al) + store_i;
        address var_p = address(this);
        uint256 var_ar = 0x0a;
        storage_map_ak[var_p] = (var_al) + storage_map_ak[var_p];
        var_ae = var_al;
        emit Transfer(0, address(this), var_al);
        isInterestAccessControlRevoked = (uint248(isInterestAccessControlRevoked)) | (0x0100000000000000 * 0x01);
        var_ae = 0x01;
        emit PauseInterest(0x01);
        var_ae = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_as = 0x20;
        uint256 var_at = 0x1f;
        uint256 var_au = 0x45524332303a206d696e7420746f20746865207a65726f206164647265737300;
        isInterestAccessControlRevoked = (uint248(isInterestAccessControlRevoked)) | (0x0100000000000000 * 0x01);
        var_ae = 0x01;
        emit PauseInterest(0x01);
        isInterestAccessControlRevoked = (uint248(isInterestAccessControlRevoked)) | (0x0100000000000000 * 0x01);
        var_ae = 0x01;
        emit PauseInterest(0x01);
        var_r = 0x01;
        var_a = 0x40 + var_a;
        var_ae = address(totalSupply);
        var_ag = address(totalSupply / 0x0100000000000000000000000000000000);
        var_z = var_a;
        var_a = 0x40 + var_a;
        var_ai = address(totalBorrow);
        var_ak = address(totalBorrow / 0x0100000000000000000000000000000000);
        var_ac = var_a;
        require(!(block.timestamp - (uint64(var_am))) > block.timestamp);
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(address(unresolved_7bcad14c));
        uint256 var_av = 0x22bbc2d200000000000000000000000000000000000000000000000000000000;
        uint256 var_aw = address(this);
        (bool success, bytes memory ret0) = address(unresolved_7bcad14c).Unresolved_22bbc2d2(var_aw); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(!(address(var_ao)) > (var_a.length + (address(var_ao))));
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(!var_a.length + (address(var_ax)));
        uint256 var_ay = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        uint256 var_az = block.timestamp - (uint64(var_am));
        uint256 var_ba = 0;
        uint256 var_bb = uint64(var_bc);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_az); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x40);
        require(var_a.length == (uint64(var_a.length)));
        require(address(var_aq) == ((address(var_aq) * 0x0186a0) / 0x0186a0) | !0x0186a0);
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x11;
        require(var_a.length + (address(var_ax)));
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x12;
        var_ay = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_az = block.timestamp - (uint64(var_am));
        var_ba = (address(var_aq) * 0x0186a0) / (var_a.length + (address(var_ax)));
        var_bb = uint64(var_bc);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_az); // staticcall
        require(!address(var_ao));
        var_av = 0xcd3181d500000000000000000000000000000000000000000000000000000000;
        var_aw = block.timestamp - (uint64(var_am));
        var_az = 0;
        var_ba = uint64(var_bc);
        (bool success, bytes memory ret0) = address(rateContract).Unresolved_cd3181d5(var_aw, var_az); // staticcall
        var_p = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_q = 0x12;
        var_b = 0x1d1e647b00000000000000000000000000000000000000000000000000000000;
        require(!(!msg.sender == (address(timelockAddress))), CustomError_1d1e647b());
        var_b = 0x1d1e647b00000000000000000000000000000000000000000000000000000000;
        if (msg.sender == (address(unresolved_8da5cb5b))) {
        }
    }
}