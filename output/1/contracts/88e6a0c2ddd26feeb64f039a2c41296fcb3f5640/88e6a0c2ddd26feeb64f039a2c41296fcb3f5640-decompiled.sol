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
    uint256 public constant token0 = 917551056842671309452305380979543736893630245704;
    uint256 public constant fee = 500;
    uint256 public constant factory = 180374273401342273892298139690832307271870052740;
    uint256 public constant maxLiquidityPerTick = 1917569901783203986719870431555990;
    uint256 public constant tickSpacing = 10;
    uint256 public constant token1 = 1097077688018008265106216665536940668749033598146;
    
    mapping(bytes32 => bytes32) storage_map_c;
    mapping(bytes32 => bytes32) storage_map_w;
    bytes32 store_u;
    mapping(bytes32 => bytes32) storage_map_q;
    bytes32 store_m;
    mapping(bytes32 => bytes32) storage_map_s;
    bytes32 store_n;
    mapping(bytes32 => bytes32) storage_map_j;
    bool public slot0;
    uint256 public feeGrowthGlobal1X128;
    mapping(bytes32 => bytes32) storage_map_k;
    mapping(bytes32 => bytes32) storage_map_i;
    bytes32 store_e;
    address public liquidity;
    bytes32 store_g;
    uint256 public feeGrowthGlobal0X128;
    mapping(bytes32 => bytes32) storage_map_x;
    bytes32 store_d;
    mapping(bytes32 => bytes32) storage_map_z;
    mapping(bytes32 => bytes32) storage_map_v;
    mapping(bytes32 => bytes32) storage_map_ab;
    mapping(bytes32 => bytes32) storage_map_r;
    mapping(bytes32 => bytes32) storage_map_aa;
    mapping(bytes32 => bytes32) storage_map_y;
    mapping(bytes32 => bytes32) storage_map_p;
    bytes32 store_t;
    mapping(bytes32 => bytes32) storage_map_l;
    bytes public protocolFees;
    
    event CollectProtocol(address, address, uint128, uint128);
    event SetFeeProtocol(uint8, uint8, uint8, uint8);
    event Collect(address, address, int24, int24, uint128, uint128);
    event IncreaseObservationCardinalityNext(uint16, uint16);
    
    /// @custom:selector    0xa38807f2
    /// @custom:signature   Unresolved_a38807f2(uint256 arg0, uint256 arg1) public view returns (bytes memory)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function Unresolved_a38807f2(uint256 arg0, uint256 arg1) public view returns (bytes memory) {
        require(0x88e6a0c2ddd26feeb64f039a2c41296fcb3f5640 == address(this), "TLM");
        require(11 < 11, "TLM");
        require(!(11 < 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffff27618), "TLM");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x03;
        var_d = 0x544c4d0000000000000000000000000000000000000000000000000000000000;
        require(!(11 > 0x0d89e8), "TUM");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x03;
        var_d = 0x54554d0000000000000000000000000000000000000000000000000000000000;
        uint256 var_e = 11;
        var_f = 0x05;
        var_e = 11;
        if (storage_map_c[var_e] / 0x0100000000000000000000000000000000000000000000000000000000000000) {
            if (storage_map_c[var_e] / 0x0100000000000000000000000000000000000000000000000000000000000000) {
                uint256 var_g = var_g + 0xe0;
                address var_a = address(slot0);
                uint256 var_h = 11;
                uint16 var_i = uint16(slot0 / 0x010000000000000000000000000000000000000000000000);
                uint16 var_j = uint16(slot0 / 0x0100000000000000000000000000000000000000000000000000);
                uint16 var_k = uint16(slot0 / 0x01000000000000000000000000000000000000000000000000000000);
                bytes1 var_l = bytes1(slot0 / 0x010000000000000000000000000000000000000000000000000000000000);
                bytes1 var_m = !(!bytes1(slot0 / 0x01000000000000000000000000000000000000000000000000000000000000));
                require(bytes1(storage_map_c[var_e] / 0x0100000000000000000000000000000000000000000000000000000000000000));
                uint256 var_n = 11;
                uint256 var_o = address((storage_map_c[var_e] / 0x0100000000000000) - (storage_map_c[var_e] / 0x0100000000000000));
                uint256 var_p = uint32((storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000) - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000));
                return abi.encodePacked(11, address((storage_map_c[var_e] / 0x0100000000000000) - (storage_map_c[var_e] / 0x0100000000000000)), uint32((storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000) - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)));
                require(bytes1(storage_map_c[var_e] / 0x0100000000000000000000000000000000000000000000000000000000000000));
                require(!11 < 11);
                var_g = var_g + 0x80;
                var_n = 0;
                var_o = 0;
                var_p = 0;
                uint256 var_q = 0;
                var_g = var_g + 0x80;
                uint256 var_r = 0;
                uint256 var_s = 0;
                uint256 var_t = 0;
                uint256 var_u = 0;
                require(!11 < 11);
                var_g = var_g + 0x80;
                uint32 var_v = uint32(store_d);
                uint256 var_x = 11;
                address var_y = address(store_d / 0x010000000000000000000000);
                bytes1 var_z = !(!bytes1(store_d / 0x0100000000000000000000000000000000000000000000000000000000000000));
                require(0);
                require(uint16(var_w) < 0xffff);
                require(uint32(store_d) > (uint32(block.timestamp)));
                require(uint32(store_d) > (uint32(block.timestamp)));
                require(uint32(store_d) > (uint32(block.timestamp)));
                require(uint32(block.timestamp - 0) > (uint32(block.timestamp)));
                require(uint40(uint32(uint32(store_d))) > (uint40(uint32(block.timestamp - 0))));
                var_g = var_g + 0x80;
                address var_aa = uint32(store_e);
                address var_ac = 11;
                address var_ad = address(store_e / 0x010000000000000000000000);
                address var_ae = !(!bytes1(store_e / 0x0100000000000000000000000000000000000000000000000000000000000000));
                require(uint16(var_ab));
            }
            require(uint16((0x01 + (var_w)) % (var_ab)) < 0xffff);
            require(!(uint32(var_af)) == (uint32(block.timestamp - 0)));
            var_aa = 11;
            var_ac = address(var_ag - (storage_map_c[var_e] / 0x0100000000000000) - (storage_map_c[var_e] / 0x0100000000000000));
            var_ad = uint32((block.timestamp - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)) - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000));
            return abi.encodePacked(11, address(var_ag - (storage_map_c[var_e] / 0x0100000000000000) - (storage_map_c[var_e] / 0x0100000000000000)), uint32((block.timestamp - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)) - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)));
            require(!(uint32(block.timestamp - 0)) == (uint32(var_af)));
            var_aa = 11;
            var_ac = address(var_ag - (storage_map_c[var_e] / 0x0100000000000000) - (storage_map_c[var_e] / 0x0100000000000000));
            var_ad = uint32((block.timestamp - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)) - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000));
            return abi.encodePacked(11, address(var_ag - (storage_map_c[var_e] / 0x0100000000000000) - (storage_map_c[var_e] / 0x0100000000000000)), uint32((block.timestamp - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)) - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)));
            require(!(uint32(var_g.length)) == (uint32(block.timestamp - 0)));
            require(uint32(var_g.length - var_g.length));
            var_aa = 11;
            var_ac = address(var_ag + (var_ag - (var_ag) * (uint32((block.timestamp - 0) - var_g.length)) / (uint32(var_g.length - var_g.length))) - (storage_map_c[var_e] / 0x0100000000000000) - (storage_map_c[var_e] / 0x0100000000000000));
            var_ad = uint32((block.timestamp - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)) - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000));
            return abi.encodePacked(11, address(var_ag + (var_ag - (var_ag) * (uint32((block.timestamp - 0) - var_g.length)) / (uint32(var_g.length - var_g.length))) - (storage_map_c[var_e] / 0x0100000000000000) - (storage_map_c[var_e] / 0x0100000000000000)), uint32((block.timestamp - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)) - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)));
            var_g = var_g + 0x80;
            var_aa = 0;
            var_ac = 0;
            var_ad = 0;
            var_ae = 0;
            var_g = 0x80 + var_g;
            uint256 var_ah = uint32(block.timestamp - 0);
            address var_ai = 11;
            require(uint32(var_g.length - var_g.length));
            require(address(liquidity) > 0);
            require(address(liquidity));
            require(0x01);
            require(uint32(block.timestamp - 0) > (uint32(block.timestamp)));
        }
        require(uint16(var_w) < 0xffff);
        var_g = var_g + 0x80;
        var_n = uint32(store_d);
        var_o = 11;
        var_p = address(store_d / 0x010000000000000000000000);
        var_q = !(!bytes1(store_d / 0x0100000000000000000000000000000000000000000000000000000000000000));
        require(uint32(block.timestamp) == (uint32(store_d)));
        var_r = 11;
        var_s = address(var_ag - (storage_map_c[var_e] / 0x0100000000000000) - (storage_map_c[var_e] / 0x0100000000000000));
        var_t = uint32((block.timestamp - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)) - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000));
        return abi.encodePacked(11, address(var_ag - (storage_map_c[var_e] / 0x0100000000000000) - (storage_map_c[var_e] / 0x0100000000000000)), uint32((block.timestamp - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)) - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)));
        var_n = 11;
        var_o = address((storage_map_c[var_e] / 0x0100000000000000) - (storage_map_c[var_e] / 0x0100000000000000));
        var_p = uint32((storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000) - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000));
        return abi.encodePacked(11, address((storage_map_c[var_e] / 0x0100000000000000) - (storage_map_c[var_e] / 0x0100000000000000)), uint32((storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000) - (storage_map_c[var_e] / 0x01000000000000000000000000000000000000000000000000000000)));
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x03;
        var_d = 0x544c550000000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x252c09d7
    /// @custom:signature   observations(uint256 arg0) public view returns (bool)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function observations(uint256 arg0) public view returns (bool) {
        require(arg0 < 0xffff);
        uint256 var_a = uint32(store_g);
        uint256 var_b = 11;
        uint256 var_c = address(store_g / 0x010000000000000000000000);
        uint256 var_d = !(!bytes1(store_g / 0x0100000000000000000000000000000000000000000000000000000000000000));
        return abi.encodePacked(uint32(store_g), 11, address(store_g / 0x010000000000000000000000), (bytes1(store_g / 0x0100000000000000000000000000000000000000000000000000000000000000)));
    }
    
    /// @custom:selector    0xf637731d
    /// @custom:signature   initialize(uint160 arg0) public view
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function initialize(uint160 arg0) public view {
        require(!(address(slot0)), "AI");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x02;
        var_d = 0x4149000000000000000000000000000000000000000000000000000000000000;
        require(address(arg0) < 0x01000276a3, "R");
        require(address(arg0) < 0xfffd8963efd1fc6a506488495d951d5263988d26, "R");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x01;
        var_d = 0x5200000000000000000000000000000000000000000000000000000000000000;
        require(!(address(arg0) < 0x01000276a3), "R");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x01;
        var_d = 0x5200000000000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x32148f67
    /// @custom:signature   increaseObservationCardinalityNext(uint16 arg0) public payable
    /// @param              arg0 ["uint16", "bytes2", "int16"]
    function increaseObservationCardinalityNext(uint16 arg0) public payable {
        require(bytes1(slot0 / 0x01000000000000000000000000000000000000000000000000000000000000), "I");
        slot0 = uint248(slot0);
        require(0x88e6a0c2ddd26feeb64f039a2c41296fcb3f5640 == address(this), "I");
        require(uint16(slot0 / 0x01000000000000000000000000000000000000000000000000000000) > 0, "I");
        require(uint16(arg0) > (uint16(slot0 / 0x01000000000000000000000000000000000000000000000000000000)), "I");
        require(!(uint16(slot0 / 0x01000000000000000000000000000000000000000000000000000000) < (uint16(arg0))), "I");
        require(uint16(slot0 / 0x01000000000000000000000000000000000000000000000000000000) < 0xffff, "I");
        slot0 = (uint240(slot0)) | (uint16(arg0) * 0x01000000000000000000000000000000000000000000000000000000);
        require(uint16(slot0 / 0x01000000000000000000000000000000000000000000000000000000) == (uint16(arg0)), "I");
        uint16 var_a = uint16(slot0 / 0x01000000000000000000000000000000000000000000000000000000);
        uint16 var_b = uint16(arg0);
        emit IncreaseObservationCardinalityNext(uint16(slot0 / 0x01000000000000000000000000000000000000000000000000000000), uint16(arg0));
        slot0 = 0x01000000000000000000000000000000000000000000000000000000000000 | (uint248(slot0));
        slot0 = 0x01000000000000000000000000000000000000000000000000000000000000 | (uint248(slot0));
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_c = 0x20;
        var_d = 0x01;
        var_e = 0x4900000000000000000000000000000000000000000000000000000000000000;
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_c = 0x20;
        var_d = 0x03;
        var_e = 0x4c4f4b0000000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x128acb08
    /// @custom:signature   Unresolved_128acb08(address arg0, uint256 arg1, uint256 arg2, address arg3, uint256 arg4) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg4 ["uint256", "bytes32", "int256"]
    function Unresolved_128acb08(address arg0, uint256 arg1, uint256 arg2, address arg3, uint256 arg4) public payable {
        require(!arg4 > 0x0100000000);
        require(0x88e6a0c2ddd26feeb64f039a2c41296fcb3f5640 == address(this));
        require(arg2);
        uint256 var_a = var_a + 0xe0;
        address var_b = address(slot0);
        uint256 var_c = 11;
        uint16 var_d = uint16(slot0 / 0x010000000000000000000000000000000000000000000000);
        uint16 var_e = uint16(slot0 / 0x0100000000000000000000000000000000000000000000000000);
        uint16 var_f = uint16(slot0 / 0x01000000000000000000000000000000000000000000000000000000);
        bytes1 var_g = bytes1(slot0 / 0x010000000000000000000000000000000000000000000000000000000000);
        bytes1 var_h = !(!bytes1(slot0 / 0x01000000000000000000000000000000000000000000000000000000000000));
        require(bytes1(slot0 / 0x01000000000000000000000000000000000000000000000000000000000000));
        require(arg1);
        require(!(address(arg3)) < (address(var_i)));
        require(address(arg3) > 0x01000276a3);
        slot0 = uint248(slot0);
        var_a = var_a + 0xc0;
        require(arg1);
        require(0x10);
        bytes1 var_j = bytes1(var_k % 0x10);
        address var_l = address(liquidity);
        uint256 var_m = uint32(block.timestamp);
        uint256 var_n = 11;
        uint256 var_o = 0;
        uint256 var_p = 0;
        var_a = 0xe0 + var_a;
        uint256 var_q = arg2;
        uint256 var_r = 0;
        address var_s = address(var_i);
        uint256 var_t = 11;
        require(arg1);
        var_u = feeGrowthGlobal0X128;
        uint256 var_v = 0;
        address var_w = address(var_x);
        require(!var_a.length);
        require(address(var_y) == (address(arg3)));
        var_a = var_a + 0xe0;
        uint256 var_z = 0;
        uint256 var_aa = 0;
        uint256 var_ab = 0;
        uint256 var_ac = 0;
        uint256 var_ad = 0;
        uint256 var_ae = 0;
        uint256 var_af = 0;
        var_z = address(var_ag);
        require(11);
        require(!11 < 0);
        require(11);
        require(!11);
        require(!arg1);
        uint256 var_ah = 11;
        uint256 var_ai = 0x06;
        require((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + ((0x01 << (bytes1(11 % 0x0100))) + (0x01 << (bytes1(11 % 0x0100))))) & (storage_map_i[var_ah]));
        require((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + ((0x01 << (bytes1(11 % 0x0100))) + (0x01 << (bytes1(11 % 0x0100))))) & (storage_map_i[var_ah]) > 0);
        require((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + ((0x01 << (bytes1(11 % 0x0100))) + (0x01 << (bytes1(11 % 0x0100))))) & (storage_map_i[var_ah]) < 0x0100000000000000000000000000000000);
        require(((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + ((0x01 << (bytes1(11 % 0x0100))) + (0x01 << (bytes1(11 % 0x0100))))) & (storage_map_i[var_ah]) >> 0x80) < 0x010000000000000000);
        require((((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + ((0x01 << (bytes1(11 % 0x0100))) + (0x01 << (bytes1(11 % 0x0100))))) & (storage_map_i[var_ah]) >> 0x80) >> 0x40) < 0x0100000000);
        require((((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + ((0x01 << (bytes1(11 % 0x0100))) + (0x01 << (bytes1(11 % 0x0100))))) & (storage_map_i[var_ah]) >> 0x80) >> 0x40) < 0x010000);
        require((((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + ((0x01 << (bytes1(11 % 0x0100))) + (0x01 << (bytes1(11 % 0x0100))))) & (storage_map_i[var_ah]) >> 0x80) >> 0x40) < 0x0100);
        require((((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + ((0x01 << (bytes1(11 % 0x0100))) + (0x01 << (bytes1(11 % 0x0100))))) & (storage_map_i[var_ah]) >> 0x80) >> 0x40) < 0x10);
        require((((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + ((0x01 << (bytes1(11 % 0x0100))) + (0x01 << (bytes1(11 % 0x0100))))) & (storage_map_i[var_ah]) >> 0x80) >> 0x40) < 0x04);
        require((((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + ((0x01 << (bytes1(11 % 0x0100))) + (0x01 << (bytes1(11 % 0x0100))))) & (storage_map_i[var_ah]) >> 0x80) >> 0x40) < 0x02);
        var_ab = !(!(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + ((0x01 << (bytes1(11 % 0x0100))) + (0x01 << (bytes1(11 % 0x0100))))) & (storage_map_i[var_ah]));
        var_aa = 11;
        require(!11 < 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffff27618);
        var_aa = 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffff27618;
        require(11 < 0);
        require(!11 > 0x0d89e8);
        require(bytes1(11));
        require(!bytes1(11));
        require(!bytes1(11));
        require(!bytes1(11));
        require(!uint0(11));
        require(!uint0(11));
        require(!uint0(11));
        require(!uint0(11));
        require(!bytes1(11));
        require(!bytes1(11));
        require(!bytes1(11));
        require(!bytes1(11));
        require(!uint0(11));
        require(!uint0(11));
        require(!uint0(11));
        require(!uint0(11));
        require(!bytes1(11));
        require(!bytes1(11));
        require(!bytes1(11));
        require(!bytes1(11));
        require(!11 > 0);
        require(0x010005bd81331b3621);
        require(!0xa236aa44);
        var_ac = 0xfffa429fbf7baeed2496f0a9f5ccf2bb4abf52f8;
        require(arg1);
        require(address(var_aj) < (address(arg3)));
        require(var_a.length < 0);
        require(!(address(var_ag)) < (address(arg3)));
        require(!(address(var_ag)) > (address(arg3)));
        require(address(arg3));
        require(0);
        require((address(var_ak << 0x60) * (address(var_ag - (arg3))) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (address(var_ag - (arg3)) * (address(var_ak << 0x60))) - ((address(var_ak << 0x60) * (address(var_ag - (arg3))) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (address(var_ag - (arg3)) * (address(var_ak << 0x60)))));
        require(address(var_ag) > ((address(var_ak << 0x60) * (address(var_ag - (arg3))) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (address(var_ag - (arg3)) * (address(var_ak << 0x60))) - ((address(var_ak << 0x60) * (address(var_ag - (arg3))) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (address(var_ag - (arg3)) * (address(var_ak << 0x60))))));
        require(address(var_ag) > 0);
        require(address(var_ag));
        require(!(address(var_ak << 0x60) * (address(var_ag - (arg3))) % (address(var_ag))) > 0);
        require(address(var_ag - (arg3)) * (address(var_ak << 0x60)) / (address(var_ag)) < 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
        require((0 - var_a.length) < (((0x01 + (address(var_al - (arg3)) * (address(var_am << 0x60)) / (address(var_al)))) % (address(arg3))) + ((0x01 + (address(var_al - (arg3)) * (address(var_am << 0x60)) / (address(var_al)))) / (address(arg3)))));
        require(address(var_ag) > 0);
        require(address(var_ak) > 0);
        require(!(address(var_ag)) < (address(arg3)));
        require(0 - var_a.length);
        require(!0);
        require(0 - var_a.length);
        require(!(address(var_ag) * (0 - var_a.length) / (0 - var_a.length)) == (address(var_ag)));
        require(address(var_ag));
        require(!(address(var_ak << 0x60) / (address(var_ag)) + (0 - var_a.length)) < (address(var_ak << 0x60) / (address(var_ag))));
        if (address(var_ag) < (address(arg3))) {
            if (!(address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))))) == (address(arg3))) {
                if (address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length)))) == (address(arg3))) {
                    require(address(var_ag) < (address(arg3)));
                    require(!(address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))))) == (address(arg3)));
                }
                require(address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length)))) == (address(arg3)));
            }
            require(!(address(var_ag)) > (address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))))));
            require(!(address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))))) == (address(arg3)));
            require(address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length)))) == (address(arg3)));
            require(!(address(var_ag)) > (address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))))));
            require(address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length)))));
        }
        require(!var_a.length < 0);
        require(!(((0x01 + (address(var_ag - (arg3)) * (address(var_ak << 0x60)) / (address(var_ag)))) % (address(arg3))) + ((0x01 + (address(var_ag - (arg3)) * (address(var_ak << 0x60)) / (address(var_ag)))) / (address(arg3)))) > (0 - var_a.length));
        require(var_a.length < 0);
        require(var_a.length < 0);
        var_af = var_a.length - 0;
        var_ae = var_p - var_a.length;
        var_ad = 0;
        var_s = address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))));
        require(!arg2 > 0);
        require(var_an + (var_ao) < 0x8000000000000000000000000000000000000000000000000000000000000000);
        var_q = var_a.length - (var_ap + (var_aq));
        require(var_ar < 0x8000000000000000000000000000000000000000000000000000000000000000);
        require((!(var_ar) < 0) == (!(var_as - (var_ar)) > (var_as)));
        var_r = (var_as) - (var_ar);
        if (!var_a.length) {
            require(!(bytes1(var_a.length)), "LS");
            var_af = (var_ak) - (var_ao / (bytes1(var_i)));
            var_v = address(var_ao / (bytes1(var_i)) + (var_ar));
            require(bytes1(var_i), "LS");
            require(!(address(var_ak)), "LS");
            require(!(address(var_y) == (address(var_aj))), "LS");
            require(!(var_y), "LS");
            require(var_k, "LS");
            require(arg1, "LS");
            var_ah = 11;
            var_ai = 0x05;
            storage_map_j[var_ah] = (var_an) - (storage_map_j[var_ah]);
            storage_map_k[var_ah] = feeGrowthGlobal1X128 - (storage_map_k[var_ah]);
            storage_map_l[var_ah] = (uint224(uint200(uint96(storage_map_l[var_ah]) | (0x0100000000000000 * (address(var_at - (address(storage_map_l[var_ah] / 0x0100000000000000)))))) | (uint56(11)))) | (uint32(var_ag - (uint200(uint96(storage_map_l[var_ah]) | (0x0100000000000000 * (address(var_at - (address(storage_map_l[var_ah] / 0x0100000000000000)))))) | (uint56(11)) / 0x01000000000000000000000000000000000000000000000000000000)) * 0x01000000000000000000000000000000000000000000000000000000);
            require(!arg1, "LS");
            require(!(11 < 0), "LS");
            require(address(var_ao - (0 - (0 - 11))) < (address(var_ao)), "LS");
            var_w = address(var_ao - (0 - (0 - 11)));
            require(arg1, "LS");
        }
        uint256 var_au = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_av = 0x20;
        uint256 var_aw = 0x02;
        uint256 var_ax = 0x4c53000000000000000000000000000000000000000000000000000000000000;
        require(!(address(var_ao + (0 - 11)) < (address(var_ao))), "LA");
        var_au = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_av = 0x20;
        var_aw = 0x02;
        var_ax = 0x4c41000000000000000000000000000000000000000000000000000000000000;
        if (arg1) {
        }
        if (0) {
            var_a = var_a + 0x80;
            var_au = 0;
            uint256 var_ay = 0;
            uint256 var_az = 0;
            address var_ba = 0;
            var_a = var_a + 0x80;
            address var_bb = 0;
            address var_bc = 0;
            address var_bd = 0;
            address var_be = 0;
            if (uint16(var_y) < 0xffff) {
                var_a = var_a + 0x80;
                address var_bf = uint32(store_m);
                address var_bg = 11;
                address var_bh = address(store_m / 0x010000000000000000000000);
                address var_bi = !(!bytes1(store_m / 0x0100000000000000000000000000000000000000000000000000000000000000));
                require(0, "R");
                require(uint16(var_y) < 0xffff, "R");
                require(!(!(uint32(store_m)) > (uint32(var_y))), "R");
                require(!(!(uint32(store_m)) > (uint32(var_y))), "R");
                require(uint32(store_m) > (uint32(var_y)), "R");
                require(uint32(var_y - 0) > (uint32(var_y)), "R");
                require(!(!(uint40(uint32(uint32(store_m)))) > (uint40(uint32(var_y - 0)))), "R");
                var_a = var_a + 0x80;
                uint256 var_bj = uint32(store_n);
                address var_bk = 11;
                uint256 var_bl = address(store_n / 0x010000000000000000000000);
                uint256 var_bm = !(!bytes1(store_n / 0x0100000000000000000000000000000000000000000000000000000000000000));
                require(uint16(var_aj), "R");
            }
            require(uint16((0x01 + (var_y)) % (var_aj)) < 0xffff, "R");
            require(!(uint32(var_i) == (uint32(var_y - 0))), "R");
            require(!(uint32(var_y - 0) == (uint32(var_i))), "R");
            require(!(uint32(var_a.length) == (uint32(var_bn - 0))), "R");
            require(uint32(var_a.length - var_a.length), "R");
            var_a = var_a + 0x80;
            var_bj = 0;
            var_bk = 0;
            var_bl = 0;
            var_bm = 0;
            var_a = 0x80 + var_a;
            address var_bo = uint32(var_y - 0);
            address var_bp = 11;
            require(uint32(var_a.length - var_a.length), "R");
            require(address(var_x) > 0, "R");
            require(address(var_x), "R");
            require(0x01, "R");
            var_a = var_a + 0x80;
            var_au = uint32(store_m);
            var_ay = 11;
            var_az = address(store_m / 0x010000000000000000000000);
            var_ba = !(!bytes1(store_m / 0x0100000000000000000000000000000000000000000000000000000000000000));
            require(uint16(var_y) < 0xffff, "R");
        }
        require(address(var_y) == (address(var_i)), "R");
        require(address(var_y) < 0x01000276a3, "R");
        require(address(var_y) < 0xfffd8963efd1fc6a506488495d951d5263988d26, "R");
        var_au = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_av = 0x20;
        var_aw = 0x01;
        var_ax = 0x5200000000000000000000000000000000000000000000000000000000000000;
        require(!(address(var_y) < 0x01000276a3), "R");
        var_au = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_av = 0x20;
        var_aw = 0x01;
        var_ax = 0x5200000000000000000000000000000000000000000000000000000000000000;
        if (address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length)))) == (address(arg3))) {
        }
        if (var_a.length < 0) {
        }
        if (!(address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))))) == (address(arg3))) {
            if (address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length)))) == (address(arg3))) {
                require(!(address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))))) == (address(arg3)));
                require(!(address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))))) == (address(arg3)));
            }
            require(address(((var_ak << 0x60) % ((var_ak << 0x60) / (var_ag) + (0 - var_a.length))) + ((var_ak << 0x60) / ((var_ak << 0x60) / (var_ag) + (0 - var_a.length)))) == (address(arg3)));
        }
        require(address(var_ag) * (0 - var_a.length) + (address(var_am << 0x60)) < (address(var_am << 0x60)));
        require((address(var_ak << 0x60) * (address(var_ag)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (address(var_ag) * (address(var_ak << 0x60))) - ((address(var_ak << 0x60) * (address(var_ag)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (address(var_ag) * (address(var_ak << 0x60)))));
        require(address(var_ag) * (0 - var_a.length) + (address(var_am << 0x60)) > ((address(var_am << 0x60) * (address(var_ag)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (address(var_ag) * (address(var_am << 0x60))) - ((address(var_am << 0x60) * (address(var_ag)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (address(var_ag) * (address(var_am << 0x60))))));
        require(address(var_ag) * (0 - var_a.length) + (address(var_am << 0x60)) > 0);
        require(address(var_ag) * (0 - var_a.length) + (address(var_am << 0x60)));
        require(!(address(var_ak << 0x60) * (address(var_ag)) % (address(var_ag) * (0 - var_a.length) + (address(var_ak << 0x60)))) > 0);
        require(address(var_ag) * (address(var_ak << 0x60)) / (address(var_ag) * (0 - var_a.length) + (address(var_ak << 0x60))) < 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
        require(0 - var_a.length);
        require(!(address(var_ag) * (0 - var_a.length) / (0 - var_a.length)) == (address(var_ag)));
        require(address(var_ag) * (0 - var_a.length) / (0 - var_a.length) == (address(var_ag)));
        require((address(var_ak << 0x60) * (address(var_ag)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (address(var_ag) * (address(var_ak << 0x60))) - ((address(var_ak << 0x60) * (address(var_ag)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (address(var_ag) * (address(var_ak << 0x60)))));
        require(address(var_ak << 0x60) - (address(var_ag) * (0 - var_a.length)) > ((address(var_ak << 0x60) * (address(var_ag)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (address(var_ag) * (address(var_ak << 0x60))) - ((address(var_ak << 0x60) * (address(var_ag)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (address(var_ag) * (address(var_ak << 0x60))))));
        require(address(var_ak << 0x60) - (address(var_ag) * (0 - var_a.length)) > 0);
        require(address(var_ak << 0x60) - (address(var_ag) * (0 - var_a.length)));
        require(!(address(var_ak << 0x60) * (address(var_ag)) % (address(var_ak << 0x60) - (address(var_ag) * (0 - var_a.length)))) > 0);
        require(address(var_ag) * (address(var_ak << 0x60)) / (address(var_ak << 0x60) - (address(var_ag) * (0 - var_a.length))) < 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
        require((0x01 + (address(var_ag) * (address(var_ak << 0x60)) / (address(var_ak << 0x60) - (address(var_ag) * (0 - var_a.length))))) == (address(0x01 + (var_ag * (var_ak << 0x60) / ((var_ak << 0x60) - (var_ag * (0 - var_a.length)))))));
        require(address(var_ak << 0x60) > (address(var_ag) * (0 - var_a.length)));
        require(!0);
        require(!(0 - var_a.length) > 0xffffffffffffffffffffffffffffffffffffffff);
        require(address(var_ak));
        require(!(0 - var_a.length) > 0xffffffffffffffffffffffffffffffffffffffff);
        require(address(var_ag) > ((((0 - var_a.length) << 0x60) % (address(var_am))) + (((0 - var_a.length) << 0x60) / (address(var_am)))));
        if (address(var_aj) > (address(arg3))) {
        }
        if (!0x331b3621) {
        }
        if (!11 > 0) {
            if (!0x84fb0421) {
            }
            if (!11) {
                if (!11 > 0) {
                    if (!0x77193200) {
                    }
                    if (!11 > 0) {
                    }
                }
            }
            if (!11) {
                if (!11) {
                }
                if (!11) {
                }
            }
            if (!11) {
                if (!11) {
                }
                if (!11) {
                }
            }
            if (!11) {
                if (!11) {
                }
                if (!11) {
                }
            }
            if (!uint0(11)) {
                if (!11) {
                }
                if (!11) {
                }
            }
            if (!uint0(11)) {
                if (!uint0(11)) {
                }
                if (!uint0(11)) {
                }
            }
            if (!uint0(11)) {
                if (!uint0(11)) {
                }
                if (!uint0(11)) {
                }
            }
            if (!uint0(11)) {
                if (!uint0(11)) {
                }
                if (!uint0(11)) {
                }
            }
            if (!11) {
                if (!uint0(11)) {
                }
                if (!uint0(11)) {
                }
            }
            if (!11) {
                if (!11) {
                }
                if (!11) {
                }
            }
            if (!11) {
                if (!11) {
                }
                if (!11) {
                }
            }
            if (!11) {
                if (!11) {
                }
                if (!11) {
                }
            }
            if (!uint0(11)) {
                if (!11) {
                }
                if (!11) {
                }
            }
            if (!uint0(11)) {
                if (!uint0(11)) {
                }
                if (!uint0(11)) {
                }
            }
            if (!uint0(11)) {
                if (!uint0(11)) {
                }
                if (!uint0(11)) {
                }
            }
            if (!uint0(11)) {
                if (!uint0(11)) {
                }
                if (!uint0(11)) {
                }
            }
            if (!11) {
                if (!uint0(11)) {
                }
                if (!uint0(11)) {
                }
            }
            if (!11) {
                if (!11) {
                }
                if (!11) {
                }
            }
            if (!11) {
                if (!11) {
                }
                require(!(bytes1(11)), "T");
            }
        }
        var_au = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_av = 0x20;
        var_aw = 0x01;
        var_ax = 0x5400000000000000000000000000000000000000000000000000000000000000;
        require(!((0 - 11) > 0x0d89e8), "T");
        var_au = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_av = 0x20;
        var_aw = 0x01;
        var_ax = 0x5400000000000000000000000000000000000000000000000000000000000000;
        if (!11 > 0x0d89e8) {
            var_aa = 0x0d89e8;
            if (11 < 0) {
            }
            require(!11 > 0x0d89e8);
        }
        if (!arg1) {
            var_ah = 11;
            var_ai = 0x06;
            require(!arg1);
            require(!0 == (storage_map_i[var_ah] & (~((0x01 << (bytes1(11 % 0x0100))) - 0x01))));
            require(storage_map_i[var_ah] & (~((0x01 << (bytes1(11 % 0x0100))) - 0x01)) > 0);
            require(!address(storage_map_i[var_ah] & (~((0x01 << (bytes1(11 % 0x0100))) - 0x01))));
            require(!uint64(storage_map_i[var_ah] & (~((0x01 << (bytes1(11 % 0x0100))) - 0x01))));
            require(!uint32(storage_map_i[var_ah] & (~((0x01 << (bytes1(11 % 0x0100))) - 0x01))));
            require(!uint16(storage_map_i[var_ah] & (~((0x01 << (bytes1(11 % 0x0100))) - 0x01))));
            require(!bytes1(storage_map_i[var_ah] & (~((0x01 << (11 % 0x0100)) - 0x01))));
            require(!bytes1(storage_map_i[var_ah] & (~((0x01 << (11 % 0x0100)) - 0x01))));
            require(!bytes1(storage_map_i[var_ah] & (~((0x01 << (11 % 0x0100)) - 0x01))));
        }
        require(11 == 11, "TF");
        require(uint16(var_y) < 0xffff, "TF");
        var_a = var_a + 0x80;
        var_z = uint32(store_m);
        var_aa = 11;
        var_ab = address(store_m / 0x010000000000000000000000);
        var_ac = !(!bytes1(store_m / 0x0100000000000000000000000000000000000000000000000000000000000000));
        require(!(uint32(var_y) == (uint32(store_m))), "TF");
        slot0 = (address(var_ag)) | (uint96((uint24(11) * 0x010000000000000000000000000000000000000000) | (uint232((uint16(var_y) * 0x010000000000000000000000000000000000000000000000) | (uint240((uint16(var_aj) * 0x0100000000000000000000000000000000000000000000000000) | (uint240(slot0))))))));
        require(address(var_x) == (address(var_ao)), "TF");
        liquidity = (address(var_ak)) | (address(liquidity));
        require(!arg1, "TF");
        feeGrowthGlobal0X128 = var_at;
        require(!(address(var_ar)), "TF");
        protocolFees = (address(var_ar + (protocolFees))) | (address(protocolFees));
        require(arg1 == (arg2 > 0), "TF");
        require(!arg1, "TF");
        require(!((arg2 - var_a.length) < 0), "TF");
        address var_bq = address(arg0);
        uint256 var_br = var_ad - (arg2 - var_a.length);
        var_ad = 0x44 + (var_a - var_a);
        var_a = var_a + 0x64;
        var_ae = 0xa9059cbb00000000000000000000000000000000000000000000000000000000 | (uint224(var_as));
        require(var_a.length < 0x20, "TF");
        var_av = (var_as & (~((0x0100 ** (0x20 - var_a.length)) - 0x01))) | (var_a.length & ((0x0100 ** (0x20 - var_a.length)) - 0x01));
        (bool success, bytes memory ret0) = address(0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2).{ value: var_bb ether }adfepixw(var_bs); // call
        require(ret0.length == 0, "TF");
        var_av = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        address var_bs = 0x20;
        address var_bt = 0x02;
        address var_bu = 0x5446000000000000000000000000000000000000000000000000000000000000;
        var_bt = address(this);
        var_av = 0x24 + (var_a - var_a);
        var_a = var_a + 0x44;
        var_aw = 0x70a0823100000000000000000000000000000000000000000000000000000000 | (uint224(var_as));
        require(var_a.length < 0x20);
        var_bu = (var_as & (~((0x0100 ** (0x20 - var_a.length)) - 0x01))) | (var_a.length & ((0x0100 ** (0x20 - var_a.length)) - 0x01));
        (bool success, bytes memory ret0) = address(0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48).adfepixw(var_bv); // staticcall
        require(ret0.length == 0);
        require(!var_bw < 0x20);
        var_bu = 0xfa461e3300000000000000000000000000000000000000000000000000000000;
        uint256 var_bv = var_as;
        uint256 var_bx = arg2 - var_a.length;
        uint256 var_by = (0x20 + (0x20 + (0x20 + (0x04 + var_a)))) - (0x04 + var_a);
        address var_bz = (arg4);
        uint256 var_ca = msg.data[36:36];
        uint256 var_cb = 0;
        require(address(msg.sender).code.length);
        (bool success, bytes memory ret0) = address(msg.sender).{ value: var_bb ether }Unresolved_fa461e33(var_bv); // call
        require(!var_bw < 0x20);
        var_a = var_a + (uint248(ret0.length + 0x3f));
        var_bu = ret0.length;
        var_bu = var_as;
        if ((var_a.length + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0) < 0x20) {
        }
        require(!var_bw, "TF");
        require(!(var_bw < 0x20), "TF");
        require(var_b, "TF");
        var_av = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_bs = 0x20;
        var_bt = 0x02;
        var_bu = 0x5446000000000000000000000000000000000000000000000000000000000000;
        var_a = var_a + (uint248(ret0.length + 0x3f));
        var_av = ret0.length;
        var_ax = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_bu = 0x20;
        uint256 var_cc = 0x02;
        uint256 var_cd = 0x5446000000000000000000000000000000000000000000000000000000000000;
        if (!var_a.length) {
        }
        if (!(var_as) < 0) {
            var_bq = address(this);
            var_ad = 0x24 + (var_a - var_a);
            var_a = var_a + 0x44;
            var_ae = 0x70a0823100000000000000000000000000000000000000000000000000000000 | (uint224(var_as));
            if (var_a.length < 0x20) {
                var_br = (var_as & (~((0x0100 ** (0x20 - var_a.length)) - 0x01))) | (var_a.length & ((0x0100 ** (0x20 - var_a.length)) - 0x01));
                (bool success, bytes memory ret0) = address(0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2).adfepixw(var_ce); // staticcall
                if (ret0.length == 0) {
                }
                require(!(var_as < 0), "SPL");
            }
            feeGrowthGlobal1X128 = var_at;
            require(var_a.length < 0x20, "SPL");
        }
        require(!(uint16(var_an) > (uint16(var_aj))), "SPL");
        require(!(uint16(var_y) == (uint16(var_aj - 0x01))), "SPL");
        require(uint16(var_an), "SPL");
        var_j = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_cf = 0x20;
        uint256 var_cg = 0x03;
        uint256 var_ch = 0x53504c0000000000000000000000000000000000000000000000000000000000;
        require(!(address(arg3) > (address(var_i))), "SPL");
        require(address(arg3) < 0xfffd8963efd1fc6a506488495d951d5263988d26, "SPL");
        var_j = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_cf = 0x20;
        var_cg = 0x03;
        var_ch = 0x53504c0000000000000000000000000000000000000000000000000000000000;
        var_j = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_cf = 0x20;
        var_cg = 0x03;
        var_ch = 0x4c4f4b0000000000000000000000000000000000000000000000000000000000;
        var_b = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_ci = 0x20;
        uint256 var_cj = 0x02;
        uint256 var_ck = 0x4153000000000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x514ea4bf
    /// @custom:signature   positions(bytes32 arg0) public view returns (bytes memory)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function positions(bytes32 arg0) public view returns (bytes memory) {
        var_a = 0x07;
        uint256 var_b = arg0;
        uint256 var_c = address(storage_map_p[var_b]);
        uint256 var_d = storage_map_q[var_b];
        uint256 var_e = storage_map_r[var_b];
        uint256 var_f = address(storage_map_s[var_b]);
        uint256 var_g = address(storage_map_s[var_b] / 0x0100000000000000000000000000000000);
        return abi.encodePacked(address(storage_map_p[var_b]), storage_map_q[var_b], storage_map_r[var_b], address(storage_map_s[var_b]), address(storage_map_s[var_b] / 0x0100000000000000000000000000000000));
    }
    
    /// @custom:selector    0x883bdbfd
    /// @custom:signature   observe(uint32[] arg0) public view returns (bytes memory)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function observe(uint32[] arg0) public view returns (bytes memory) {
        require(!arg0 > 0x0100000000);
        require(0x88e6a0c2ddd26feeb64f039a2c41296fcb3f5640 == address(this));
        uint256 var_a = var_a + (0x20 + (0x20 * (arg0)));
        uint256 var_b = (arg0);
        var_c = msg.data[36:36];
        uint256 var_d = 0;
        require(uint16(slot0 / 0x0100000000000000000000000000000000000000000000000000) > 0);
        require(!var_a.length > 0xffffffffffffffff);
        var_d = var_a.length;
        var_a = var_a + (0x20 + (0x20 * var_a.length));
        require(!var_a.length);
        var_c = msg.data[4:4];
        require(!var_a.length > 0xffffffffffffffff);
        uint256 var_e = var_a.length;
        var_a = var_a + (0x20 + (0x20 * var_a.length));
        if (!var_a.length) {
            var_c = msg.data[4:4];
            if (uint32(var_c)) {
                var_a = var_a + 0x80;
                uint256 var_f = 0;
                uint256 var_g = 0;
                uint256 var_h = 0;
                uint256 var_i = 0;
                var_a = var_a + 0x80;
                uint256 var_j = 0;
                uint256 var_k = 0;
                uint256 var_l = 0;
                uint256 var_m = 0;
                if (uint16(slot0 / 0x010000000000000000000000000000000000000000000000) < 0xffff) {
                    var_a = var_a + 0x80;
                    uint32 var_n = uint32(store_t);
                    uint256 var_o = 11;
                    address var_p = address(store_t / 0x010000000000000000000000);
                    bytes1 var_q = !(!bytes1(store_t / 0x0100000000000000000000000000000000000000000000000000000000000000));
                    require(!var_a.length, "I");
                    require(uint32(var_c), "I");
                    require(uint16(slot0 / 0x010000000000000000000000000000000000000000000000) < 0xffff, "I");
                    require(!(!(uint32(store_t)) > (uint32(block.timestamp))), "I");
                    require(!(!(uint32(store_t)) > (uint32(block.timestamp))), "I");
                    require(uint32(store_t) > (uint32(block.timestamp)), "I");
                    require(uint32(block.timestamp - (var_c)) > (uint32(block.timestamp)), "I");
                    var_a = var_a + 0x80;
                    uint32 var_r = uint32(store_u);
                    uint256 var_s = 11;
                    address var_t = address(store_u / 0x010000000000000000000000);
                    bytes1 var_u = !(!bytes1(store_u / 0x0100000000000000000000000000000000000000000000000000000000000000));
                    require(!(!(uint40(uint32(uint32(store_t)))) > (uint40(uint32(block.timestamp - (var_c))))), "I");
                }
                require(uint16(slot0 / 0x0100000000000000000000000000000000000000000000000000), "I");
                require(uint16((0x01 + (slot0 / 0x010000000000000000000000000000000000000000000000)) % (slot0 / 0x0100000000000000000000000000000000000000000000000000)) < 0xffff, "I");
                require(!(uint32(var_v) == (uint32(block.timestamp - (var_c)))), "I");
                require(!(uint32(block.timestamp - (var_c)) == (uint32(var_v))), "I");
                require(!(uint32(var_a.length) == (uint32(block.timestamp - (var_w)))), "I");
                var_a = var_a + 0x80;
                var_r = 0;
                var_s = 0;
                var_t = 0;
                var_u = 0;
                var_a = 0x80 + var_a;
                uint256 var_x = uint32(block.timestamp - (var_c));
                uint256 var_y = 11;
                require(uint32(var_a.length - var_a.length), "I");
                require(uint32(var_a.length - var_a.length), "I");
                require(address(liquidity) > 0, "I");
                require(address(liquidity), "I");
                require(0x01, "I");
            }
            require(uint32(block.timestamp - (var_c)) > (uint32(block.timestamp)), "I");
            var_a = var_a + 0x80;
            var_f = uint32(store_t);
            var_g = 11;
            var_h = address(store_t / 0x010000000000000000000000);
            var_i = !(!bytes1(store_t / 0x0100000000000000000000000000000000000000000000000000000000000000));
            require(uint16(slot0 / 0x010000000000000000000000000000000000000000000000) < 0xffff, "I");
        }
        var_f = (0x20 + (0x20 + var_a)) - var_a;
        var_h = var_a.length;
        require(!(0 < (0x20 * var_a.length)), "I");
        var_g = ((0x20 * var_a.length) + (0x20 + (0x20 + (0x20 + var_a)))) - var_a;
        var_i = var_a.length;
        require(!(0 < (0x20 * var_a.length)), "I");
        return abi.encodePacked((0x20 + (0x20 + var_a)) - var_a, ((0x20 * var_a.length) + (0x20 + (0x20 + (0x20 + var_a)))) - var_a, var_a.length, var_a.length);
        var_d = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_z = 0x20;
        uint256 var_aa = 0x01;
        uint256 var_ab = 0x4900000000000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x8206a4d1
    /// @custom:signature   setFeeProtocol(uint8 arg0, uint8 arg1) public payable
    /// @param              arg0 ["bool", "uint8", "bytes1", "int8"]
    /// @param              arg1 ["bool", "uint8", "bytes1", "int8"]
    function setFeeProtocol(uint8 arg0, uint8 arg1) public payable {
        require(bytes1(slot0 / 0x01000000000000000000000000000000000000000000000000000000000000));
        slot0 = uint248(slot0);
        var_a = 0x8da5cb5b00000000000000000000000000000000000000000000000000000000;
        require(address(0x1f98431c8ad98523631ae4a59f267346ea31f984).code.length);
        (bool success, bytes memory ret0) = address(0x1f98431c8ad98523631ae4a59f267346ea31f984).Unresolved_8da5cb5b(var_b); // staticcall
        require(!ret0.length < 0x20);
        require(msg.sender == (address(var_c.length)));
        require(!bytes1(arg0));
        require(bytes1(arg0) < 0x04);
        require(bytes1(arg0) > 0x0a);
        require(!(bytes1(arg0)) > 0x0a);
        slot0 = (uint248(slot0)) | (0x010000000000000000000000000000000000000000000000000000000000 * (bytes1(arg0 + (arg1 << 0x04))));
        bytes1 var_a = bytes1((slot0 / 0x010000000000000000000000000000000000000000000000000000000000) % 0x10);
        bytes1 var_d = bytes1((slot0 / 0x010000000000000000000000000000000000000000000000000000000000) >> 0x04);
        bool var_e = bytes1(arg0);
        bool var_f = bytes1(arg1);
        emit SetFeeProtocol(bytes1((slot0 / 0x010000000000000000000000000000000000000000000000000000000000) % 0x10), bytes1((slot0 / 0x010000000000000000000000000000000000000000000000000000000000) >> 0x04), bytes1(arg0), bytes1(arg1));
        slot0 = 0x01000000000000000000000000000000000000000000000000000000000000 | (uint248(slot0));
        require(!bytes1(arg1));
        require(bytes1(arg1) < 0x04);
        require(!(bytes1(arg1)) < 0x04);
        slot0 = (uint248(slot0)) | (0x010000000000000000000000000000000000000000000000000000000000 * (bytes1(arg0 + (arg1 << 0x04))));
        var_a = bytes1((slot0 / 0x010000000000000000000000000000000000000000000000000000000000) % 0x10);
        var_d = bytes1((slot0 / 0x010000000000000000000000000000000000000000000000000000000000) >> 0x04);
        var_e = bytes1(arg0);
        var_f = bytes1(arg1);
        emit SetFeeProtocol(bytes1((slot0 / 0x010000000000000000000000000000000000000000000000000000000000) % 0x10), bytes1((slot0 / 0x010000000000000000000000000000000000000000000000000000000000) >> 0x04), bytes1(arg0), bytes1(arg1));
        slot0 = 0x01000000000000000000000000000000000000000000000000000000000000 | (uint248(slot0));
        if (arg0 < 0x04) {
        }
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_g = 0x03;
        var_h = 0x4c4f4b0000000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x5339c296
    /// @custom:signature   Unresolved_5339c296(uint256 arg0) public view returns (uint256)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function Unresolved_5339c296(uint256 arg0) public view returns (uint256) {
        var_a = 0x06;
        uint256 var_b = 11;
        uint256 var_c = storage_map_p[var_b];
        return storage_map_p[var_b];
    }
    
    /// @custom:selector    0x490e6cbc
    /// @custom:signature   Unresolved_490e6cbc(address arg0, uint256 arg1, uint256 arg2, uint256 arg3) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["uint256", "bytes32", "int256"]
    function Unresolved_490e6cbc(address arg0, uint256 arg1, uint256 arg2, uint256 arg3) public payable {
        require(!arg3 > 0x0100000000);
        require(bytes1(slot0 / 0x01000000000000000000000000000000000000000000000000000000000000));
        slot0 = uint248(slot0);
        require(0x88e6a0c2ddd26feeb64f039a2c41296fcb3f5640 == address(this));
        require(address(liquidity));
        require(((arg1 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x01f4 * arg1) - (((arg1 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x01f4 * arg1)));
        require(0x0f4240 > (((arg1 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x01f4 * arg1) - (((arg1 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x01f4 * arg1))));
        require(0x0f4240);
        require(!((arg1 * 0x01f4) % 0x0f4240) > 0);
        require((((0x01f4 * arg1) - ((arg1 * 0x01f4) % 0x0f4240) / 0x40) | (((arg1 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x01f4 * arg1) - (((arg1 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x01f4 * arg1)) - (((arg1 * 0x01f4) % 0x0f4240) > (0x01f4 * arg1)) * 0x0400000000000000000000000000000000000000000000000000000000000000) * 0xde8f6cefed634549b62c77574f722e1ac57e23f24d8fd5cb790fb65668c26139) < 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
        require(((arg2 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x01f4 * arg2) - (((arg2 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x01f4 * arg2)));
        require(0x0f4240 > (((arg2 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x01f4 * arg2) - (((arg2 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x01f4 * arg2))));
        require(0x0f4240);
        require(!((arg2 * 0x01f4) % 0x0f4240) > 0);
        require((((0x01f4 * arg2) - ((arg2 * 0x01f4) % 0x0f4240) / 0x40) | (((arg2 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x01f4 * arg2) - (((arg2 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x01f4 * arg2)) - (((arg2 * 0x01f4) % 0x0f4240) > (0x01f4 * arg2)) * 0x0400000000000000000000000000000000000000000000000000000000000000) * 0xde8f6cefed634549b62c77574f722e1ac57e23f24d8fd5cb790fb65668c26139) < 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
        address var_a = address(this);
        uint256 var_b = 0x24 + (var_c - var_c);
        uint256 var_c = var_c + 0x44;
        uint224 var_d = 0x70a0823100000000000000000000000000000000000000000000000000000000 | (uint224(var_e));
        require(var_c.length < 0x20);
        uint256 var_f = (var_e & (~((0x0100 ** (0x20 - var_c.length)) - 0x01))) | (var_c.length & ((0x0100 ** (0x20 - var_c.length)) - 0x01));
        (bool success, bytes memory ret0) = address(0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48).adfepixw(var_g); // staticcall
        require(ret0.length == 0);
        require(!var_h < 0x20);
        address var_i = address(this);
        var_f = 0x24 + (var_c - var_c);
        var_c = var_c + 0x44;
        uint224 var_j = 0x70a0823100000000000000000000000000000000000000000000000000000000 | (uint224(var_e));
        require(var_c.length < 0x20);
        uint256 var_k = (var_e & (~((0x0100 ** (0x20 - var_c.length)) - 0x01))) | (var_c.length & ((0x0100 ** (0x20 - var_c.length)) - 0x01));
        (bool success, bytes memory ret0) = address(0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2).adfepixw(var_l); // staticcall
        require(ret0.length == 0);
        require(!(var_h < 0x20), "TF");
        require(!arg1, "TF");
        address var_m = address(arg0);
        uint256 var_n = arg1;
        var_k = 0x44 + (var_c - var_c);
        var_c = var_c + 0x64;
        uint224 var_o = 0xa9059cbb00000000000000000000000000000000000000000000000000000000 | (uint224(var_e));
        require(var_c.length < 0x20, "TF");
        uint256 var_p = (var_e & (~((0x0100 ** (0x20 - var_c.length)) - 0x01))) | (var_c.length & ((0x0100 ** (0x20 - var_c.length)) - 0x01));
        (bool success, bytes memory ret0) = address(0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48).{ value: 0 ether }adfepixw(var_q); // call
        require(ret0.length == 0, "TF");
        var_p = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_q = 0x20;
        var_r = 0x02;
        var_s = 0x5446000000000000000000000000000000000000000000000000000000000000;
        require(!arg2);
        var_p = 0xe9cbafb000000000000000000000000000000000000000000000000000000000;
        uint256 var_q = 0x01 + (((0x01f4 * arg1) - ((arg1 * 0x01f4) % 0x0f4240) / 0x40) | (((arg1 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x01f4 * arg1) - (((arg1 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x01f4 * arg1)) - (((arg1 * 0x01f4) % 0x0f4240) > (0x01f4 * arg1)) * 0x0400000000000000000000000000000000000000000000000000000000000000) * 0xde8f6cefed634549b62c77574f722e1ac57e23f24d8fd5cb790fb65668c26139);
        uint256 var_r = 0x01 + (((0x01f4 * arg2) - ((arg2 * 0x01f4) % 0x0f4240) / 0x40) | (((arg2 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x01f4 * arg2) - (((arg2 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x01f4 * arg2)) - (((arg2 * 0x01f4) % 0x0f4240) > (0x01f4 * arg2)) * 0x0400000000000000000000000000000000000000000000000000000000000000) * 0xde8f6cefed634549b62c77574f722e1ac57e23f24d8fd5cb790fb65668c26139);
        uint256 var_s = (0x20 + (0x20 + (0x20 + (0x04 + var_c)))) - (0x04 + var_c);
        uint256 var_t = (arg3);
        var_u = msg.data[36:36];
        uint256 var_v = 0;
        require(address(msg.sender).code.length);
        (bool success, bytes memory ret0) = address(msg.sender).{ value: var_v ether }Unresolved_e9cbafb0(var_q); // call
        var_r = address(this);
        var_p = 0x24 + (var_c - var_c);
        var_c = var_c + 0x44;
        uint224 var_w = 0x70a0823100000000000000000000000000000000000000000000000000000000 | (uint224(var_e));
        require(var_c.length < 0x20);
        var_s = (var_e & (~((0x0100 ** (0x20 - var_c.length)) - 0x01))) | (var_c.length & ((0x0100 ** (0x20 - var_c.length)) - 0x01));
        (bool success, bytes memory ret0) = address(0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48).adfepixw(var_x); // staticcall
        require(ret0.length == 0);
        require(!var_h < 0x20);
        address var_y = address(this);
        var_s = 0x24 + (var_c - var_c);
        var_c = var_c + 0x44;
        var_t = 0x70a0823100000000000000000000000000000000000000000000000000000000 | (uint224(var_e));
        require(var_c.length < 0x20);
        uint256 var_z = (var_e & (~((0x0100 ** (0x20 - var_c.length)) - 0x01))) | (var_c.length & ((0x0100 ** (0x20 - var_c.length)) - 0x01));
        (bool success, bytes memory ret0) = address(0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2).adfepixw(var_aa); // staticcall
        require(ret0.length == 0);
        require(!var_h < 0x20);
        require(!(var_b + (0x01 + (((0x01f4 * arg1) - ((arg1 * 0x01f4) % 0x0f4240) / 0x40) | (((arg1 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x01f4 * arg1) - (((arg1 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x01f4 * arg1)) - (((arg1 * 0x01f4) % 0x0f4240) > (0x01f4 * arg1)) * 0x0400000000000000000000000000000000000000000000000000000000000000) * 0xde8f6cefed634549b62c77574f722e1ac57e23f24d8fd5cb790fb65668c26139))) < var_b);
        require(!((var_b + (0x01 + (((0x01f4 * arg1) - ((arg1 * 0x01f4) % 0x0f4240) / 0x40) | (((arg1 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x01f4 * arg1) - (((arg1 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x01f4 * arg1)) - (((arg1 * 0x01f4) % 0x0f4240) > (0x01f4 * arg1)) * 0x0400000000000000000000000000000000000000000000000000000000000000) * 0xde8f6cefed634549b62c77574f722e1ac57e23f24d8fd5cb790fb65668c26139))) > var_b), "F0");
        var_z = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        address var_aa = 0x20;
        address var_ab = 0x02;
        address var_ac = 0x4630000000000000000000000000000000000000000000000000000000000000;
        require(!var_h < 0x20);
        var_c = var_c + (uint248(ret0.length + 0x3f));
        var_z = ret0.length;
        var_z = var_e;
        if ((var_c.length + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0) < 0x20) {
            address var_ad = var_ae;
            require((var_c.length + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0) < 0x20);
        }
        require(!var_h);
        require(!var_h < 0x20);
        var_c = var_c + (uint248(ret0.length + 0x3f));
        var_p = ret0.length;
        address var_af = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_s = 0x20;
        var_t = 0x02;
        var_v = 0x5446000000000000000000000000000000000000000000000000000000000000;
        require(!var_c.length, "TF");
        require(!var_c.length, "TF");
        var_af = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_s = 0x20;
        var_t = 0x02;
        var_v = 0x5446000000000000000000000000000000000000000000000000000000000000;
        require(0x0f4240 > 0);
        if (0x0f4240) {
            require(0x0f4240);
        }
        require(((arg2 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x01f4 * arg2) - (((arg2 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x01f4 * arg2)));
        require(0x0f4240 > (((arg2 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x01f4 * arg2) - (((arg2 * 0x01f4) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x01f4 * arg2))));
        if (0x0f4240) {
            require(0x0f4240);
        }
        require(0x0f4240 > 0);
        if (0x0f4240) {
            require(0x0f4240, "L");
        }
        var_b = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        address var_ag = 0x20;
        var_a = 0x01;
        var_f = 0x4c00000000000000000000000000000000000000000000000000000000000000;
        var_b = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ag = 0x20;
        var_a = 0x03;
        var_f = 0x4c4f4b0000000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0xf30dba93
    /// @custom:signature   Unresolved_f30dba93(uint256 arg0) public view returns (bool)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function Unresolved_f30dba93(uint256 arg0) public view returns (bool) {
        var_a = 0x05;
        uint256 var_b = 11;
        uint256 var_c = address(storage_map_p[var_b]);
        uint256 var_d = 11;
        uint256 var_e = storage_map_q[var_b];
        uint256 var_f = storage_map_r[var_b];
        uint256 var_g = 11;
        uint256 var_h = address(storage_map_s[var_b] / 0x0100000000000000);
        uint256 var_i = uint32(storage_map_s[var_b] / 0x01000000000000000000000000000000000000000000000000000000);
        uint256 var_j = !(!bytes1(storage_map_s[var_b] / 0x0100000000000000000000000000000000000000000000000000000000000000));
        return abi.encodePacked(address(storage_map_p[var_b]), 11, storage_map_q[var_b], storage_map_r[var_b], 11, address(storage_map_s[var_b] / 0x0100000000000000), uint32(storage_map_s[var_b] / 0x01000000000000000000000000000000000000000000000000000000), (bytes1(storage_map_s[var_b] / 0x0100000000000000000000000000000000000000000000000000000000000000)));
    }
    
    /// @custom:selector    0x4f1eb3d8
    /// @custom:signature   Unresolved_4f1eb3d8(address arg0, uint256 arg1, uint256 arg2, address arg3, address arg4) public payable returns (bytes memory)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["address", "uint128", "bytes16", "int128"]
    /// @param              arg4 ["address", "uint128", "bytes16", "int128"]
    function Unresolved_4f1eb3d8(address arg0, uint256 arg1, uint256 arg2, address arg3, address arg4) public payable returns (bytes memory) {
        require(bytes1(slot0 / 0x01000000000000000000000000000000000000000000000000000000000000), "TF");
        slot0 = uint248(slot0);
        address var_a = address(msg.sender << 0x60);
        bytes32 var_b = 11 << 0xe8;
        bytes32 var_c = 11 << 0xe8;
        uint256 var_d = 0x1a + (var_e - var_e);
        uint256 var_e = var_e + 0x3a;
        var_f = keccak256(var_g);
        var_h = 0x07;
        require(address(arg3) > (address(storage_map_v[var_f])), "TF");
        require(address(arg4) > (address(storage_map_v[var_f] / 0x0100000000000000000000000000000000)), "TF");
        require(!(address(storage_map_v[var_f])), "TF");
        storage_map_v[var_f] = (address(storage_map_v[var_f] - (storage_map_v[var_f]))) | (address(storage_map_v[var_f]));
        address var_i = address(arg0);
        address var_j = address(storage_map_v[var_f]);
        uint256 var_k = 0x44 + (var_e - var_e);
        var_e = var_e + 0x64;
        uint224 var_l = 0xa9059cbb00000000000000000000000000000000000000000000000000000000 | (uint224(var_m));
        require(var_e.length < 0x20, "TF");
        uint256 var_n = (var_m & (~((0x0100 ** (0x20 - var_e.length)) - 0x01))) | (var_e.length & ((0x0100 ** (0x20 - var_e.length)) - 0x01));
        (bool success, bytes memory ret0) = address(0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48).{ value: 0 ether }adfepixw(var_o); // call
        require(ret0.length == 0, "TF");
        var_n = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_o = 0x20;
        var_p = 0x02;
        var_q = 0x5446000000000000000000000000000000000000000000000000000000000000;
        require(!address(storage_map_v[var_f] / 0x0100000000000000000000000000000000));
        var_n = address(arg0);
        address var_r = address(storage_map_v[var_f]);
        address var_s = address(storage_map_v[var_f] / 0x0100000000000000000000000000000000);
        emit Collect(msg.sender, 11, 11, address(arg0), address(storage_map_v[var_f]), address(storage_map_v[var_f] / 0x0100000000000000000000000000000000));
        slot0 = 0x01000000000000000000000000000000000000000000000000000000000000 | (uint248(slot0));
        var_n = address(storage_map_v[var_f]);
        var_r = address(storage_map_v[var_f] / 0x0100000000000000000000000000000000);
        return abi.encodePacked(address(storage_map_v[var_f]), address(storage_map_v[var_f] / 0x0100000000000000000000000000000000));
        require(!var_t);
        require(!var_t < 0x20);
        var_e = var_e + (uint248(ret0.length + 0x3f));
        var_n = ret0.length;
        var_s = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_q = 0x20;
        var_u = 0x02;
        var_v = 0x5446000000000000000000000000000000000000000000000000000000000000;
        require(!var_e.length, "TF");
        require(!var_e.length, "TF");
        var_s = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_q = 0x20;
        var_u = 0x02;
        var_v = 0x5446000000000000000000000000000000000000000000000000000000000000;
        if (!address(storage_map_v[var_f])) {
        }
        if (address(arg4) > (address(storage_map_v[var_f] / 0x0100000000000000000000000000000000))) {
        }
        var_d = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_w = 0x20;
        var_x = 0x03;
        var_y = 0x4c4f4b0000000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x3c8a7d8d
    /// @custom:signature   Unresolved_3c8a7d8d(address arg0, uint256 arg1, uint256 arg2, address arg3, uint256 arg4) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["address", "uint128", "bytes16", "int128"]
    /// @param              arg4 ["uint256", "bytes32", "int256"]
    function Unresolved_3c8a7d8d(address arg0, uint256 arg1, uint256 arg2, address arg3, uint256 arg4) public payable {
        require(!arg4 > 0x0100000000);
        require(bytes1(slot0 / 0x01000000000000000000000000000000000000000000000000000000000000));
        slot0 = uint248(slot0);
        require(address(arg3));
        uint256 var_a = 0x80 + var_a;
        address var_b = address(arg0);
        uint256 var_c = 11;
        uint256 var_d = 11;
        require(address(arg3) == 11);
        uint256 var_e = 11;
        require(0x88e6a0c2ddd26feeb64f039a2c41296fcb3f5640 == address(this), "TLM");
        require(11 < 11, "TLM");
        require(!(11 < 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffff27618), "TLM");
        var_f = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_g = 0x20;
        var_h = 0x03;
        var_i = 0x544c4d0000000000000000000000000000000000000000000000000000000000;
        require(!(11 > 0x0d89e8), "TUM");
        var_f = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_g = 0x20;
        var_h = 0x03;
        var_i = 0x54554d0000000000000000000000000000000000000000000000000000000000;
        var_a = var_a + 0xe0;
        address var_f = address(slot0);
        uint256 var_j = 11;
        uint16 var_k = uint16(slot0 / 0x010000000000000000000000000000000000000000000000);
        uint16 var_l = uint16(slot0 / 0x0100000000000000000000000000000000000000000000000000);
        uint16 var_m = uint16(slot0 / 0x01000000000000000000000000000000000000000000000000000000);
        bytes1 var_n = bytes1(slot0 / 0x010000000000000000000000000000000000000000000000000000000000);
        bytes1 var_o = !(!bytes1(slot0 / 0x01000000000000000000000000000000000000000000000000000000000000));
        uint256 var_p = address(var_a.length << 0x60);
        bytes32 var_q = var_c << 0xe8;
        bytes32 var_r = var_c << 0xe8;
        uint256 var_s = 0x1a + (var_a - var_a);
        var_a = var_a + 0x3a;
        var_t = keccak256(var_u);
        var_v = 0x07;
        require(!11, "LO");
        require(0, "LO");
        require(uint16(slot0 / 0x010000000000000000000000000000000000000000000000) < 0xffff, "LO");
        var_a = var_a + 0x80;
        uint32 var_w = uint32(store_t);
        uint256 var_x = 11;
        address var_y = address(store_t / 0x010000000000000000000000);
        bytes1 var_z = !(!bytes1(store_t / 0x0100000000000000000000000000000000000000000000000000000000000000));
        require(uint32(block.timestamp) == (uint32(store_t)), "LO");
        uint256 var_t = 11;
        var_v = 0x05;
        require(!(11 < 0), "LO");
        require(address(storage_map_w[var_t] - (0 - (var_aa))) < (address(storage_map_w[var_t])), "LO");
        require(!(address(storage_map_w[var_t] - (0 - (var_aa))) > 0x5e8b2285f864419ac400be907196), "LO");
        uint256 var_ab = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_ac = 0x20;
        uint256 var_ad = 0x02;
        uint256 var_ae = 0x4c4f000000000000000000000000000000000000000000000000000000000000;
        require(address(storage_map_w[var_t]));
        storage_map_w[var_t] = (address(storage_map_w[var_t] - (0 - (var_aa)))) | (address(storage_map_w[var_t]));
        require(0);
        require((!11 < 0) == (!(11 - 11) > 11));
        require((11 - 11) == 11);
        storage_map_w[var_t] = (address(storage_map_w[var_t])) | (0x0100000000000000000000000000000000 * (address(11)));
        var_t = 11;
        var_v = 0x05;
        require(!(11 < 0), "LO");
        require(address(storage_map_w[var_t] - (0 - (var_aa))) < (address(storage_map_w[var_t])), "LO");
        require(!(address(storage_map_w[var_t] - (0 - (var_aa))) > 0x5e8b2285f864419ac400be907196), "LO");
        var_ab = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ac = 0x20;
        var_ad = 0x02;
        var_ae = 0x4c4f000000000000000000000000000000000000000000000000000000000000;
        require(address(storage_map_w[var_t]));
        storage_map_w[var_t] = (address(storage_map_w[var_t] - (0 - (var_aa)))) | (address(storage_map_w[var_t]));
        require(0x01);
        require((!11 < 0) == (!(11 + 11) < 11));
        require((!11 < 0) == (!(11 - 11) > 11));
        if (11 > 11) {
        }
        var_ab = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ac = 0x20;
        var_ad = 0x02;
        var_ae = 0x4c53000000000000000000000000000000000000000000000000000000000000;
        require(!(address(storage_map_w[var_t] + (var_aa)) < (address(storage_map_w[var_t]))), "LA");
        var_ab = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ac = 0x20;
        var_ad = 0x02;
        var_ae = 0x4c41000000000000000000000000000000000000000000000000000000000000;
        if (11 > 11) {
        }
        var_ab = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ac = 0x20;
        var_ad = 0x02;
        var_ae = 0x4c53000000000000000000000000000000000000000000000000000000000000;
        var_a = var_a + 0x80;
        var_ab = 0;
        uint256 var_af = 0;
        uint256 var_ag = 0;
        uint256 var_ah = 0;
        var_a = 0x80 + var_a;
        uint256 var_ai = uint32(block.timestamp);
        uint256 var_aj = 11;
        require(address(liquidity) > 0);
        require(address(liquidity));
        require(0x01);
        var_t = 11;
        var_v = 0x05;
        var_t = 11;
        require(11 < 11);
        require(!11 < 11);
        var_a = var_a + 0xa0;
        var_w = address(storage_map_w[var_t]);
        var_x = storage_map_x[var_t];
        var_y = storage_map_y[var_t];
        var_z = address(storage_map_z[var_t]);
        var_ab = address(storage_map_z[var_t] / 0x0100000000000000000000000000000000);
        require(11);
        require(address(var_a.length));
        require(((feeGrowthGlobal0X128 - (feeGrowthGlobal0X128 - (storage_map_aa[var_t]))) - (storage_map_x[var_t]) - (var_u) * (address(var_ak)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (address(var_ak) * ((feeGrowthGlobal0X128 - (feeGrowthGlobal0X128 - (storage_map_aa[var_t]))) - (storage_map_x[var_t]) - (var_u))) - (((feeGrowthGlobal0X128 - (feeGrowthGlobal0X128 - (storage_map_aa[var_t]))) - (storage_map_x[var_t]) - (var_u) * (address(var_ak)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (address(var_ak) * ((feeGrowthGlobal0X128 - (feeGrowthGlobal0X128 - (storage_map_aa[var_t]))) - (storage_map_x[var_t]) - (var_u)))));
        require(0x0100000000000000000000000000000000 > (((feeGrowthGlobal0X128 - (feeGrowthGlobal0X128 - (storage_map_aa[var_t]))) - (storage_map_x[var_t]) - (var_u) * (address(var_ak)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (address(var_ak) * ((feeGrowthGlobal0X128 - (feeGrowthGlobal0X128 - (storage_map_aa[var_t]))) - (storage_map_x[var_t]) - (var_u))) - (((feeGrowthGlobal0X128 - (feeGrowthGlobal0X128 - (storage_map_aa[var_t]))) - (storage_map_x[var_t]) - (var_u) * (address(var_ak)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (address(var_ak) * ((feeGrowthGlobal0X128 - (feeGrowthGlobal0X128 - (storage_map_aa[var_t]))) - (storage_map_x[var_t]) - (var_u))))));
        require(((feeGrowthGlobal1X128 - (feeGrowthGlobal1X128 - (storage_map_ab[var_t]))) - (storage_map_y[var_t]) - (var_al) * (address(var_ak)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (address(var_ak) * ((feeGrowthGlobal1X128 - (feeGrowthGlobal1X128 - (storage_map_ab[var_t]))) - (storage_map_y[var_t]) - (var_al))) - (((feeGrowthGlobal1X128 - (feeGrowthGlobal1X128 - (storage_map_ab[var_t]))) - (storage_map_y[var_t]) - (var_al) * (address(var_ak)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (address(var_ak) * ((feeGrowthGlobal1X128 - (feeGrowthGlobal1X128 - (storage_map_ab[var_t]))) - (storage_map_y[var_t]) - (var_al)))));
        require(0x0100000000000000000000000000000000 > (((feeGrowthGlobal1X128 - (feeGrowthGlobal1X128 - (storage_map_ab[var_t]))) - (storage_map_y[var_t]) - (var_al) * (address(var_ak)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (address(var_ak) * ((feeGrowthGlobal1X128 - (feeGrowthGlobal1X128 - (storage_map_ab[var_t]))) - (storage_map_y[var_t]) - (var_al))) - (((feeGrowthGlobal1X128 - (feeGrowthGlobal1X128 - (storage_map_ab[var_t]))) - (storage_map_y[var_t]) - (var_al) * (address(var_ak)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (address(var_ak) * ((feeGrowthGlobal1X128 - (feeGrowthGlobal1X128 - (storage_map_ab[var_t]))) - (storage_map_y[var_t]) - (var_al))))));
        if (0 == 11) {
        }
        require(0x0100000000000000000000000000000000 > 0);
        if (0 == 11) {
        }
        var_af = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ad = 0x20;
        var_ae = 0x02;
        uint256 var_am = 0x4e50000000000000000000000000000000000000000000000000000000000000;
        var_a = var_a + 0xa0;
        var_w = address(storage_map_w[var_t]);
        var_x = storage_map_x[var_t];
        var_y = storage_map_y[var_t];
        var_z = address(storage_map_z[var_t]);
        var_ab = address(storage_map_z[var_t] / 0x0100000000000000000000000000000000);
        require(11, "NP");
        require(address(var_a.length), "NP");
        var_af = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ad = 0x20;
        var_ae = 0x02;
        var_am = 0x4e50000000000000000000000000000000000000000000000000000000000000;
        require(!(11 < 11), "NP");
        var_a = var_a + 0xa0;
        var_w = address(storage_map_w[var_t]);
        var_x = storage_map_x[var_t];
        var_y = storage_map_y[var_t];
        var_z = address(storage_map_z[var_t]);
        var_ab = address(storage_map_z[var_t] / 0x0100000000000000000000000000000000);
        require(11, "NP");
        require(address(var_a.length), "NP");
        var_af = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ad = 0x20;
        var_ae = 0x02;
        var_am = 0x4e50000000000000000000000000000000000000000000000000000000000000;
        var_a = var_a + 0xa0;
        var_w = address(storage_map_w[var_t]);
        var_x = storage_map_x[var_t];
        var_y = storage_map_y[var_t];
        var_z = address(storage_map_z[var_t]);
        var_ab = address(storage_map_z[var_t] / 0x0100000000000000000000000000000000);
        require(11, "NP");
        require(address(var_a.length), "NP");
        var_af = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ad = 0x20;
        var_ae = 0x02;
        var_am = 0x4e50000000000000000000000000000000000000000000000000000000000000;
        var_f = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_g = 0x20;
        var_h = 0x03;
        var_i = 0x544c550000000000000000000000000000000000000000000000000000000000;
        var_b = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_an = 0x20;
        uint256 var_ao = 0x03;
        uint256 var_ap = 0x4c4f4b0000000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0xa34123a7
    /// @custom:signature   Unresolved_a34123a7(uint256 arg0, uint256 arg1, address arg2) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["address", "uint128", "bytes16", "int128"]
    function Unresolved_a34123a7(uint256 arg0, uint256 arg1, address arg2) public payable {
        require(bytes1(slot0 / 0x01000000000000000000000000000000000000000000000000000000000000));
        slot0 = uint248(slot0);
        uint256 var_a = var_a + 0x80;
        address var_b = msg.sender;
        uint256 var_c = 11;
        uint256 var_d = 11;
        require(address(arg2) == 11);
        uint256 var_e = 11;
        require(0x88e6a0c2ddd26feeb64f039a2c41296fcb3f5640 == address(this), "TLM");
        require(11 < 11, "TLM");
        require(!(11 < 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffff27618), "TLM");
        var_f = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_g = 0x20;
        var_h = 0x03;
        var_i = 0x544c4d0000000000000000000000000000000000000000000000000000000000;
        require(!(11 > 0x0d89e8), "TUM");
        var_f = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_g = 0x20;
        var_h = 0x03;
        var_i = 0x54554d0000000000000000000000000000000000000000000000000000000000;
        var_a = var_a + 0xe0;
        address var_f = address(slot0);
        uint256 var_j = 11;
        uint16 var_k = uint16(slot0 / 0x010000000000000000000000000000000000000000000000);
        uint16 var_l = uint16(slot0 / 0x0100000000000000000000000000000000000000000000000000);
        uint16 var_m = uint16(slot0 / 0x01000000000000000000000000000000000000000000000000000000);
        bytes1 var_n = bytes1(slot0 / 0x010000000000000000000000000000000000000000000000000000000000);
        bytes1 var_o = !(!bytes1(slot0 / 0x01000000000000000000000000000000000000000000000000000000000000));
        uint256 var_p = address(var_a.length << 0x60);
        bytes32 var_q = var_c << 0xe8;
        bytes32 var_r = var_c << 0xe8;
        uint256 var_s = 0x1a + (var_a - var_a);
        var_a = var_a + 0x3a;
        var_t = keccak256(var_u);
        var_v = 0x07;
        if (!11) {
            require(!11, "TLU");
        }
        var_f = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_g = 0x20;
        var_h = 0x03;
        var_i = 0x544c550000000000000000000000000000000000000000000000000000000000;
        var_b = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_w = 0x20;
        var_x = 0x03;
        var_y = 0x4c4f4b0000000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x85b66729
    /// @custom:signature   collectProtocol(address arg0, uint128 arg1, uint128 arg2) public payable returns (bytes memory)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["address", "uint128", "bytes16", "int128"]
    /// @param              arg2 ["address", "uint128", "bytes16", "int128"]
    function collectProtocol(address arg0, uint128 arg1, uint128 arg2) public payable returns (bytes memory) {
        require(bytes1(slot0 / 0x01000000000000000000000000000000000000000000000000000000000000));
        slot0 = uint248(slot0);
        var_a = 0x8da5cb5b00000000000000000000000000000000000000000000000000000000;
        require(address(0x1f98431c8ad98523631ae4a59f267346ea31f984).code.length);
        (bool success, bytes memory ret0) = address(0x1f98431c8ad98523631ae4a59f267346ea31f984).Unresolved_8da5cb5b(var_b); // staticcall
        require(!ret0.length < 0x20);
        require(msg.sender == (address(var_c.length)));
        require(address(arg1) > (address(protocolFees)), "TF");
        require(address(arg2) > (address(protocolFees / 0x0100000000000000000000000000000000)), "TF");
        require(!(address(protocolFees)), "TF");
        require(!(address(protocolFees) == (address(protocolFees))), "TF");
        protocolFees = (address(protocolFees - (protocolFees))) | (address(protocolFees));
        address var_d = address(arg0);
        address var_e = address(protocolFees);
        uint256 var_a = 0x44 + (var_c - var_c);
        uint256 var_c = var_c + 0x64;
        uint224 var_f = 0xa9059cbb00000000000000000000000000000000000000000000000000000000 | (uint224(var_g));
        require(var_c.length < 0x20, "TF");
        uint256 var_h = (var_g & (~((0x0100 ** (0x20 - var_c.length)) - 0x01))) | (var_c.length & ((0x0100 ** (0x20 - var_c.length)) - 0x01));
        (bool success, bytes memory ret0) = address(0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48).{ value: 0 ether }adfepixw(var_i); // call
        require(ret0.length == 0, "TF");
        var_h = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_i = 0x20;
        var_j = 0x02;
        var_k = 0x5446000000000000000000000000000000000000000000000000000000000000;
        if (!address(protocolFees / 0x0100000000000000000000000000000000)) {
            require(!address(protocolFees / 0x0100000000000000000000000000000000));
        }
        var_h = address(protocolFees);
        address var_l = address(protocolFees / 0x0100000000000000000000000000000000);
        emit CollectProtocol(msg.sender, address(arg0), address(protocolFees), address(protocolFees / 0x0100000000000000000000000000000000));
        slot0 = 0x01000000000000000000000000000000000000000000000000000000000000 | (uint248(slot0));
        var_h = address(protocolFees);
        var_l = address(protocolFees / 0x0100000000000000000000000000000000);
        return abi.encodePacked(address(protocolFees), address(protocolFees / 0x0100000000000000000000000000000000));
        require(!var_m);
        require(!var_m < 0x20);
        var_c = var_c + (uint248(ret0.length + 0x3f));
        var_h = ret0.length;
        var_n = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_k = 0x20;
        var_o = 0x02;
        var_p = 0x5446000000000000000000000000000000000000000000000000000000000000;
        require(!var_c.length, "TF");
        require(!var_c.length, "TF");
        var_n = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_k = 0x20;
        var_o = 0x02;
        var_p = 0x5446000000000000000000000000000000000000000000000000000000000000;
        if (!address(protocolFees)) {
            if (!(address(protocolFees)) == (address(protocolFees))) {
            }
            require(!address(protocolFees));
        }
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_d = 0x03;
        var_e = 0x4c4f4b0000000000000000000000000000000000000000000000000000000000;
    }
}