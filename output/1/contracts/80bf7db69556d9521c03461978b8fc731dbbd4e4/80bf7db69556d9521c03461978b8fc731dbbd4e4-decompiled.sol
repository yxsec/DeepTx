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
    
    /// @custom:selector    0x205c2878
    /// @custom:signature   withdrawTo(address arg0, uint256 arg1) public
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function withdrawTo(address arg0, uint256 arg1) public {
        require(arg0 == (address(arg0)));
        require(0xfde0d1575ed8e06fbf36256bcdfa1f359281455a == msg.sender);
        (bool success, bytes memory ret0) = address(arg0).transfer(arg1);
    }
    
    /// @custom:selector    0x5b2e9917
    /// @custom:signature   Unresolved_5b2e9917(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_5b2e9917(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x9846cd9e
    /// @custom:signature   Unresolved_9846cd9e(uint256 arg0, uint256 arg1, uint256 arg2, uint256 arg3, uint256 arg4, uint256 arg5, uint256 arg6) public
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["uint256", "bytes32", "int256"]
    /// @param              arg4 ["uint256", "bytes32", "int256"]
    /// @param              arg5 ["uint256", "bytes32", "int256"]
    /// @param              arg6 ["uint256", "bytes32", "int256"]
    function Unresolved_9846cd9e(uint256 arg0, uint256 arg1, uint256 arg2, uint256 arg3, uint256 arg4, uint256 arg5, uint256 arg6) public {
        require(0xfde0d1575ed8e06fbf36256bcdfa1f359281455a == msg.sender);
        require(!arg0 >> 0xf8);
        require(!arg1 >> 0x80);
        require(address(arg0 >> 0x60));
        var_a = 0x70a0823100000000000000000000000000000000000000000000000000000000;
        var_b = 0xfde0d1575ed8e06fbf36256bcdfa1f359281455a;
        (bool success, bytes memory ret0) = address(arg0 >> 0x60).Unresolved_70a08231(var_b); // staticcall
        uint256 var_c = var_c + (uint248(ret0.length + 0x1f));
        if (!((var_c + ret0.length) - var_c) < 0x20) {
            if (!arg1 >> 0xf8) {
                require(!((var_c + ret0.length) - var_c) < 0x20);
                uint256 var_d = arg1 >> 0xe0;
                require(!arg1 >> 0xf8);
                require(!0 < (arg1 >> 0xf8));
            }
            transient[keccak256(var_d)] = arg1;
            require(!0x3e < ((0x3e + ((arg1 << 0x08) >> 0xe0)) + ((arg1 << 0x28) >> 0xe0) + 0x09));
            require(!0x5e < ((0x3e + ((arg1 << 0x08) >> 0xe0)) + ((arg1 << 0x28) >> 0xe0) + 0x09));
        }
        require(!0x3a < msg.data.length);
        require(!0x3a > 0x3b);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(!(arg1 >> 0xf8) < 0x02);
        require(!(arg1 >> 0xf8) < 0x06);
        require(0x06 - (arg1 >> 0xf8));
        require(!arg0 >> 0xff);
        require(address(arg1 >> 0x60) + 0xffffffffffffffffffffffff3fd555c64ddc0172f5f1a3b0d81526f7c38a933e);
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_g = 0xd0e30db000000000000000000000000000000000000000000000000000000000;
        require(address(var_e).code.length);
        (bool success, bytes memory ret0) = address(var_e).{ value: arg1 }deposit(var_h); // call
        address var_i = address(msg.sender);
        uint256 var_j = arg1;
        uint256 var_g = 0x44 + (var_c - var_c);
        var_c = var_c + 0x64;
        uint224 var_k = 0xa9059cbb00000000000000000000000000000000000000000000000000000000 | (uint224(var_l));
        uint256 var_m = 0;
        (bool success, bytes memory ret0) = address(arg1 >> 0x60).transfer(0);
        require(ret0.length == 0, "Bad transfer");
        require(!0, "Bad transfer");
        var_n = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_o = 0x20;
        var_p = 0x0c;
        var_m = 0x426164207472616e736665720000000000000000000000000000000000000000;
        require(address(arg1 >> 0x60) + 0xffffffffffffffffffffffff3fd555c64ddc0172f5f1a3b0d81526f7c38a933e);
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_g = 0xd0e30db000000000000000000000000000000000000000000000000000000000;
        require(address(var_e).code.length);
        var_i = address(msg.sender);
        var_j = arg0;
        var_g = 0x44 + (var_c - var_c);
        var_c = var_c + 0x64;
        var_k = 0xa9059cbb00000000000000000000000000000000000000000000000000000000 | (uint224(var_l));
        var_m = 0;
        (bool success, bytes memory ret0) = address(arg1 >> 0x60).Unresolved_08c379a0(var_o); // call
        require(ret0.length == 0, "Bad transfer");
        require(!0, "Bad transfer");
        var_n = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_o = 0x20;
        var_p = 0x0c;
        var_m = 0x426164207472616e736665720000000000000000000000000000000000000000;
        if (0x07 - (arg1 >> 0xf8)) {
            var_g = arg1 >> 0xe0;
            if (transient[keccak256(var_q)] >> 0xf8) {
                require(0x07 - (arg1 >> 0xf8));
            }
        }
        require(0x08 - (arg1 >> 0xf8));
        var_g = 0x70a0823100000000000000000000000000000000000000000000000000000000;
        address var_h = address(this);
        (bool success, bytes memory ret0) = address(arg1 >> 0x60).balanceOf(var_h); // staticcall
        var_c = var_c + (uint248(ret0.length + 0x1f));
        require(!(((var_c + ret0.length) - var_c) < 0x20), "08:token");
        require(!(var_c.length < (arg2 >> 0x80)), "08:token");
        var_k = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_i = 0x20;
        var_j = 0x08;
        var_n = 0x30383a746f6b656e000000000000000000000000000000000000000000000000;
        require(!(var_c.length > 0x01), "Bad transfer");
        require(!((var_c.length - 0x01) > var_c.length), "Bad transfer");
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        var_j = 0xc70f00cd7e461686b04b0e912e309beca8b80ea0;
        uint256 var_n = var_c.length - 0x01;
        var_k = 0x44 + (var_c - var_c);
        var_c = var_c + 0x64;
        uint224 var_r = 0xa9059cbb00000000000000000000000000000000000000000000000000000000 | (uint224(var_l));
        uint256 var_s = 0;
        (bool success, bytes memory ret0) = address(arg1 >> 0x60).transfer(0);
        require(ret0.length == 0, "Bad transfer");
        require(!((arg2 >> 0x80) > 0), "Bad transfer");
        var_t = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_p = 0x20;
        var_m = 0x0c;
        var_s = 0x426164207472616e736665720000000000000000000000000000000000000000;
        require(0x09 - (arg1 >> 0xf8));
        var_g = 0x70a0823100000000000000000000000000000000000000000000000000000000;
        var_h = address(this);
        var_e = this.code[9869:9901];
        var_e = var_e;
        (bool success, bytes memory ret0) = address(var_e).balanceOf(var_h); // staticcall
        require(!((arg1 >> 0xf8) < 0x0c), "Unknown flag");
        var_g = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_h = 0x20;
        var_i = 0x0c;
        var_j = 0x556e6b6e6f776e20666c61670000000000000000000000000000000000000000;
        require(0x04444c5dc75cb358380d2e3de08a90 == msg.sender);
        require(0 - (arg2 >> 0x80));
        require(0x0a - (arg1 >> 0xf8));
        var_g = 0xa584119400000000000000000000000000000000000000000000000000000000;
        var_h = address(arg1 >> 0x60);
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).sync(var_h); // call
        var_g = 0x0144;
        var_c = var_c + 0x0180;
        var_l = msg.data[4:328];
        require(0x3b < msg.data.length, "poor");
        require(!(bytes1((arg1 >> 0xf8) << 0xf8) > 0), "poor");
        var_e = this.code[9869:9901];
        var_e = var_e;
        require(!(address(arg1 >> 0x60) < var_e), "poor");
        var_k = 0xf3cd914c00000000000000000000000000000000000000000000000000000000;
        require(!0x01, "poor");
        require(0x01, "poor");
        var_u = 0xfffd8963efd1fc6a506488495d951d5263988d25;
        var_v = msg.data[60:80];
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_j = var_e;
        var_w = msg.data[80:83];
        var_x = msg.data[83:86];
        uint256 var_y = arg2 >> 0x80;
        var_z = 0x0120;
        uint256 var_aa = 0;
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).transfer(0);
        require(ret0.length == 0, "poor");
        require(!(address(this).balance < ((arg0 >> 0x80) + address(this).balance)), "poor");
        var_ab = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ac = 0x20;
        var_ad = 0x04;
        var_ae = 0x706f6f7200000000000000000000000000000000000000000000000000000000;
        require(!var_c.length + (arg1 >> 0x80));
        require(0 - msg.value);
        require(!msg.value < 0x03e8);
        (bool success, bytes memory ret0) = address(block.coinbase).transfer(0x174876e800 * msg.value);
        if (!((address(this).balance - address(this).balance * msg.value) / 0x03e8) > (address(this).balance - address(this).balance - (arg0 >> 0x80))) {
        }
        require(address(arg0 >> 0x60));
        var_ab = 0x70a0823100000000000000000000000000000000000000000000000000000000;
        var_ac = 0xfde0d1575ed8e06fbf36256bcdfa1f359281455a;
        (bool success, bytes memory ret0) = address(arg0 >> 0x60).Unresolved_70a08231(var_ac); // staticcall
        require(!((var_c.length + (arg1 >> 0x80)) > address(0xfde0d1575ed8e06fbf36256bcdfa1f359281455a).balance), "origin poor");
        var_ab = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ac = 0x20;
        var_ad = 0x0b;
        var_ae = 0x6f726967696e20706f6f72000000000000000000000000000000000000000000;
        require(!0x01);
        require(0x01);
        require(!arg3 >> 0x80);
        require(!(0x01 + ~(11)) > (arg3 >> 0x80));
        require(0x3b < msg.data.length);
        require(!(bytes1((arg1 >> 0xf8) << 0xf8)) > 0);
        var_ab = 0xa584119400000000000000000000000000000000000000000000000000000000;
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_ac = var_e;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_a5841194(var_ac); // call
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_ab = 0xd0e30db000000000000000000000000000000000000000000000000000000000;
        require(address(var_e).code.length);
        (bool success, bytes memory ret0) = address(var_e).{ value: 0x01 + ~(11) }deposit(var_ac); // call
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_ad = 0x04444c5dc75cb358380d2e3de08a90;
        uint256 var_ae = 0x01 + ~(11);
        uint256 var_ab = 0x44 + (var_c - var_c);
        var_c = var_c + 0x64;
        uint224 var_af = 0xa9059cbb00000000000000000000000000000000000000000000000000000000 | (uint224(var_l));
        uint256 var_ag = 0;
        (bool success, bytes memory ret0) = address(var_e).transfer(0);
        require(ret0.length == 0, "Bad transfer");
        require(!0, "Bad transfer");
        var_ah = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ai = 0x20;
        var_aj = 0x0c;
        var_ag = 0x426164207472616e736665720000000000000000000000000000000000000000;
        var_ah = 0x11da60b400000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).settle(var_ai); // call
        var_c = var_c + (uint248(ret0.length + 0x1f));
        require(!((var_c + ret0.length) - var_c) < 0x20);
        require(!0x01);
        require(0x01);
        var_ak = 0x0b0d9c0900000000000000000000000000000000000000000000000000000000;
        uint256 var_aj = address(arg1 >> 0x60);
        var_ag = address(this);
        bytes32 var_al = var_a >> 0x80;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_0b0d9c09(var_aj); // call
        var_ak = 0x0b0d9c0900000000000000000000000000000000000000000000000000000000;
        var_aj = address(arg1 >> 0x60);
        var_ag = address(this);
        var_al = 0x01 + ~(11);
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_0b0d9c09(var_aj); // call
        require(0x01);
        var_ak = 0x0b0d9c0900000000000000000000000000000000000000000000000000000000;
        var_aj = address(arg1 >> 0x60);
        var_ag = address(this);
        var_al = 11;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_0b0d9c09(var_aj); // call
        var_ab = 0xa584119400000000000000000000000000000000000000000000000000000000;
        uint256 var_ac = 0;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).sync(var_ac); // call
        var_ab = 0x11da60b400000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).{ value: 0x01 + ~(11) }settle(var_ac); // call
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x32;
        var_ab = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ac = 0x20;
        var_ad = 0x07;
        var_ae = 0x31313a7765746800000000000000000000000000000000000000000000000000;
        require(!(arg3 >> 0x80), "11:weth");
        require(!((arg2 >> 0x80) > (arg3 >> 0x80)), "11:weth");
        var_ab = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ac = 0x20;
        var_ad = 0x07;
        var_ae = 0x31313a7765746800000000000000000000000000000000000000000000000000;
        require(0x3b < msg.data.length);
        require(!(bytes1((arg1 >> 0xf8) << 0xf8)) > 0);
        var_ab = 0xa584119400000000000000000000000000000000000000000000000000000000;
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_ac = var_e;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).sync(var_ac); // call
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_ab = 0xd0e30db000000000000000000000000000000000000000000000000000000000;
        require(address(var_e).code.length);
        var_ab = 0xa584119400000000000000000000000000000000000000000000000000000000;
        var_ac = 0;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).sync(var_ac); // call
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x32;
        if (0x01) {
            require(0x01, "11:weth");
        }
        var_c = var_c + (uint248(ret0.length + 0x3f));
        var_ab = ret0.length;
        require(!0x01, "11:weth");
        require(0x01, "11:weth");
        require(!(arg3 >> 0x80), "11:weth");
        require(!((arg2 >> 0x80) > (arg3 >> 0x80)), "11:weth");
        var_am = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_ae = 0x20;
        var_ah = 0x07;
        var_ak = 0x31313a7765746800000000000000000000000000000000000000000000000000;
        require(0x01);
        require(!arg3 >> 0x80);
        require(0x3b < msg.data.length);
        require(!(bytes1((arg1 >> 0xf8) << 0xf8)) > 0);
        var_am = 0xa584119400000000000000000000000000000000000000000000000000000000;
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_ae = var_e;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_a5841194(var_ae); // call
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_am = 0xd0e30db000000000000000000000000000000000000000000000000000000000;
        require(address(var_e).code.length);
        var_am = 0xa584119400000000000000000000000000000000000000000000000000000000;
        var_ae = 0;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_a5841194(var_ae); // call
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x32;
        var_an = 0x01;
        var_u = 0x01000276a4;
        if (!arg1 >> 0xf8) {
            var_e = this.code[9869:9901];
            var_e = var_e;
            var_i = var_e;
            var_ao = msg.data[60:80];
            if (0x01) {
            }
            var_k = 0xf3cd914c00000000000000000000000000000000000000000000000000000000;
            if (!0) {
                require(!arg1 >> 0xf8);
            }
            require(!0);
        }
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x32;
        var_g = 0x70a0823100000000000000000000000000000000000000000000000000000000;
        var_h = address(this);
        (bool success, bytes memory ret0) = address(arg1 >> 0x60).balanceOf(var_h); // staticcall
        var_g = 0x60;
        var_c = var_c + 0x80;
        var_l = msg.data[4:100];
        var_k = 0xcb00000000000000000000000000000000000000000000000000000000000000;
        var_ap = msg.data[58:118];
        var_aq = 0x3dbc;
        var_ar = 0x48c8949100000000000000000000000000000000000000000000000000000000;
        var_t = 0x20;
        uint256 var_as = var_c.length;
        uint256 var_z = 0;
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_48c89491(var_t); // call
        var_c = var_c + (uint248(ret0.length + 0x1f));
        require(!((var_c + ret0.length) - var_c) < 0x20);
        require(!var_c.length > 0xffffffffffffffff);
        require((var_c + ret0.length) > ((var_c + var_c.length) + 0x1f));
        require(!(var_at) > 0xffffffffffffffff);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x41;
        require(!((var_c + (uint248(0x3f + (var_au + 0x1f)))) < var_c) | ((var_c + (uint248(0x3f + (var_au + 0x1f)))) > 0xffffffffffffffff));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x41;
        var_c = var_c + (uint248(0x3f + (var_au + 0x1f)));
        var_av = var_at;
        require(!(var_c + ret0.length) < (0x20 + (var_au + (var_c + var_c.length))));
        require(0 - (arg2 >> 0x80), "03:weth");
        var_e = this.code[9869:9901];
        var_e = var_e;
        require(0x02 - (arg1 >> 0xf8), "03:weth");
        require(0x03 - (arg1 >> 0xf8), "03:weth");
        var_g = 0x20;
        var_c = 0x40 + var_c;
        var_l = msg.data[4:36];
        var_k = 0xcb060000000000000000000000000000000000000000000000000000000016bc + ((arg2 >> 0x60) << 0x50);
        require(!(address(arg2 >> 0x60) < var_e), "03:weth");
        var_r = 0x128acb0800000000000000000000000000000000000000000000000000000000;
        var_j = address(this);
        var_n = 0;
        uint256 var_t = arg2 >> 0x80;
        var_as = 0xfffd8963efd1fc6a506488495d951d5263988d25;
        var_an = 0xa0;
        var_y = var_c.length;
        var_z = 0;
        (bool success, bytes memory ret0) = address(arg1 >> 0x60).Unresolved_128acb08(var_j, var_n, var_t, var_as); // call
        require(!(0 < (arg3 >> 0x80)), "03:weth");
        var_r = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_j = 0x20;
        var_n = 0x07;
        var_t = 0x30333a7765746800000000000000000000000000000000000000000000000000;
        var_r = 0x2e1a7d4d00000000000000000000000000000000000000000000000000000000;
        var_j = 0;
        var_e = this.code[9869:9901];
        var_e = var_e;
        require(address(var_e).code.length);
        (bool success, bytes memory ret0) = address(var_e).withdraw(var_j); // call
        require(var_c + 0x8000000000000000000000000000000000000000000000000000000000000000);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        var_c = var_c + (uint248(ret0.length + 0x1f));
        require(!((var_c + ret0.length) - var_c) < 0x40);
        require(!0x01);
        require(!(var_l) < var_c);
        var_aq = 0x2e1a7d4d00000000000000000000000000000000000000000000000000000000;
        var_n = var_l;
        var_e = this.code[9869:9901];
        var_e = var_e;
        require(address(var_e).code.length);
        (bool success, bytes memory ret0) = address(var_e).withdraw(var_n); // call
        require(!((arg1 >> 0xf8) < (arg1 >> 0x60)), "Fail");
        require(!((arg1 >> 0xf8) > (0x01 + (arg1 >> 0xf8))), "Fail");
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(!((msg.data[arg1 >> 0xf8] >> 0xf8) < 0x02), "Fail");
        require(!(msg.data[arg1 >> 0xf8] >> 0xf8), "Fail");
        var_q = msg.data[24:4640182];
        uint256 var_aw = 0;
        (bool success, bytes memory ret0) = address(msg.data[0x01 + (arg1 >> 0xf8)] >> 0x48).withdraw(var_n); // call
        require(ret0.length == 0, "Fail");
        var_aq = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_n = 0x20;
        var_t = 0x04;
        var_as = 0x4661696c00000000000000000000000000000000000000000000000000000000;
        var_q = msg.data[40:4640198];
        var_aw = 0;
        (bool success, bytes memory ret0) = address(msg.data[0x01 + (arg1 >> 0xf8)] >> 0x48).{ value: (msg.data[(0x01 + (arg1 >> 0xf8)) + 0x17]) >> 0x80 }Unresolved_08c379a0(var_n, var_t, var_as, var_an, var_y, var_u); // call
        if (ret0.length == 0) {
        }
        if (!(msg.data[arg1 >> 0xf8] >> 0xf8) < 0x06) {
            require(!((msg.data[arg1 >> 0xf8] >> 0xf8) < 0x06), "03:weth");
            var_e = this.code[9869:9901];
            var_e = var_e;
            require(0 - (msg.data[(0x01 + (arg1 >> 0xf8)) + 0x28] >> 0x80), "03:weth");
            var_t = address(msg.data[0x01 + (arg1 >> 0xf8)] >> 0x60);
            var_as = (msg.data[(0x01 + (arg1 >> 0xf8)) + 0x28]) >> 0x80;
            uint256 var_aq = 0x44 + (var_c - var_c);
            var_c = var_c + 0x64;
            uint224 var_ar = 0xa9059cbb00000000000000000000000000000000000000000000000000000000 | (uint224(var_l));
            uint256 var_ax = 0;
            (bool success, bytes memory ret0) = address(msg.data[(0x01 + (arg1 >> 0xf8)) + 0x14] >> 0x60).adfepixw(var_s); // call
            require(0x02 - (msg.data[arg1 >> 0xf8] >> 0xf8), "03:weth");
        }
        require(0x03 - (msg.data[arg1 >> 0xf8] >> 0xf8), "03:weth");
        var_aq = 0x20;
        var_c = 0x40 + var_c;
        var_l = msg.data[4:36];
        var_ar = 0xcb060000000000000000000000000000000000000000000000000000000016bc + ((msg.data[(0x01 + (arg1 >> 0xf8)) + 0x14] >> 0x60) << 0x50);
        require(!(address(msg.data[(0x01 + (arg1 >> 0xf8)) + 0x14] >> 0x60) < var_e), "03:weth");
        var_av = 0x128acb0800000000000000000000000000000000000000000000000000000000;
        var_as = address(this);
        uint256 var_an = 0;
        var_y = (msg.data[(0x01 + (arg1 >> 0xf8)) + 0x28]) >> 0x80;
        var_u = 0xfffd8963efd1fc6a506488495d951d5263988d25;
        var_z = 0xa0;
        uint256 var_ay = var_c.length;
        var_ac = 0;
        (bool success, bytes memory ret0) = address(msg.data[0x01 + (arg1 >> 0xf8)] >> 0x60).Unresolved_128acb08(var_as, var_an); // call
        require(!(0 < (msg.data[0x38 + (0x01 + (arg1 >> 0xf8))] >> 0x80)), "03:weth");
        var_av = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_as = 0x20;
        var_an = 0x07;
        var_y = 0x30333a7765746800000000000000000000000000000000000000000000000000;
        require(var_c + 0x8000000000000000000000000000000000000000000000000000000000000000);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        var_c = var_c + (uint248(ret0.length + 0x1f));
        require(!((var_c + ret0.length) - var_c) < 0x40);
        require(!0x01);
        require(!(var_l) < var_c);
        var_az = 0x2e1a7d4d00000000000000000000000000000000000000000000000000000000;
        var_an = var_l;
        var_e = this.code[9869:9901];
        var_e = var_e;
        require(address(var_e).code.length);
        (bool success, bytes memory ret0) = address(var_e).Unresolved_2e1a7d4d(var_an); // call
        require(!(msg.data[arg1 >> 0xf8] >> 0xf8) < (msg.data[0x01 + (arg1 >> 0xf8)] >> 0x60));
        require(!(msg.data[arg1 >> 0xf8] >> 0xf8) > (0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        require(!(msg.data[(msg.data[arg1 >> 0xf8]) >> 0xf8] >> 0xf8) < 0x02);
        require(!(msg.data[(msg.data[arg1 >> 0xf8]) >> 0xf8] >> 0xf8) < 0x06);
        require(0x06 - (msg.data[(msg.data[arg1 >> 0xf8]) >> 0xf8] >> 0xf8));
        require(!arg0 >> 0xff);
        require(address(msg.data[0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)] >> 0x60) + 0xffffffffffffffffffffffff3fd555c64ddc0172f5f1a3b0d81526f7c38a933e);
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_az = 0xd0e30db000000000000000000000000000000000000000000000000000000000;
        require(address(var_e).code.length);
        (bool success, bytes memory ret0) = address(var_e).{ value: arg1 }deposit(var_an); // call
        require(address(msg.data[0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)] >> 0x60) + 0xffffffffffffffffffffffff3fd555c64ddc0172f5f1a3b0d81526f7c38a933e);
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_az = 0xd0e30db000000000000000000000000000000000000000000000000000000000;
        require(address(var_e).code.length);
        if (0x07 - (msg.data[(msg.data[arg1 >> 0xf8]) >> 0xf8] >> 0xf8)) {
            uint256 var_az = (msg.data[0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)]) >> 0xe0;
            if (transient[keccak256(var_q)] >> 0xf8) {
                require(0x07 - (msg.data[(msg.data[arg1 >> 0xf8]) >> 0xf8] >> 0xf8));
            }
        }
        require(0x08 - (msg.data[(msg.data[arg1 >> 0xf8]) >> 0xf8] >> 0xf8));
        var_az = 0x70a0823100000000000000000000000000000000000000000000000000000000;
        var_an = address(this);
        (bool success, bytes memory ret0) = address(msg.data[0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)] >> 0x60).Unresolved_70a08231(var_an); // staticcall
        require(0x09 - (msg.data[(msg.data[arg1 >> 0xf8]) >> 0xf8] >> 0xf8));
        var_az = 0x70a0823100000000000000000000000000000000000000000000000000000000;
        var_an = address(this);
        var_e = this.code[9869:9901];
        var_e = var_e;
        (bool success, bytes memory ret0) = address(var_e).Unresolved_70a08231(var_an); // staticcall
        require(!((msg.data[(msg.data[arg1 >> 0xf8]) >> 0xf8] >> 0xf8) < 0x0c), "Unknown flag");
        var_az = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_an = 0x20;
        var_y = 0x0c;
        var_u = 0x556e6b6e6f776e20666c61670000000000000000000000000000000000000000;
        require(0x04444c5dc75cb358380d2e3de08a90 == msg.sender);
        require(0 - (msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x1b] >> 0x80));
        require(0x0a - (msg.data[(msg.data[arg1 >> 0xf8]) >> 0xf8] >> 0xf8));
        var_az = 0xa584119400000000000000000000000000000000000000000000000000000000;
        var_an = address(msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x01] >> 0x60);
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_a5841194(var_an); // call
        var_y = 0x04444c5dc75cb358380d2e3de08a90;
        uint256 var_u = (msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x1b]) >> 0x80;
        var_az = 0x44 + (var_c - var_c);
        var_c = var_c + 0x64;
        uint224 var_ba = 0xa9059cbb00000000000000000000000000000000000000000000000000000000 | (uint224(var_l));
        uint256 var_bb = 0;
        (bool success, bytes memory ret0) = address(msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x01] >> 0x60).adfepixw(var_bc); // call
        if (ret0.length == 0) {
        }
        var_az = 0x0144;
        var_c = var_c + 0x0180;
        var_l = msg.data[4:328];
        require((0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) < msg.data.length);
        require(!(bytes1((msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0] >> 0xf8) << 0xf8)) > 0);
        var_e = this.code[9869:9901];
        var_e = var_e;
        require(!(address(msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x01] >> 0x60)) < var_e);
        var_ba = 0xf3cd914c00000000000000000000000000000000000000000000000000000000;
        require(!0x01);
        require(0x01);
        var_ae = 0xfffd8963efd1fc6a506488495d951d5263988d25;
        var_v = msg.data[154:174];
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_u = var_e;
        var_w = msg.data[174:177];
        var_x = msg.data[177:180];
        uint256 var_ad = (msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x1b]) >> 0x80;
        var_ah = 0x0120;
        uint256 var_bd = 0;
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).transfer(0);
        require(ret0.length == 0);
        require(!0x01);
        require(0x01);
        require(!(msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x2b]) >> 0x80);
        require(!(0x01 + ~(11)) > (msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x2b] >> 0x80));
        require((0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) < msg.data.length);
        require(!(bytes1((msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0] >> 0xf8) << 0xf8)) > 0);
        var_be = 0xa584119400000000000000000000000000000000000000000000000000000000;
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_bf = var_e;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_a5841194(var_bf); // call
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_be = 0xd0e30db000000000000000000000000000000000000000000000000000000000;
        require(address(var_e).code.length);
        (bool success, bytes memory ret0) = address(var_e).{ value: 0x01 + ~(11) }deposit(var_bf); // call
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_bg = 0x04444c5dc75cb358380d2e3de08a90;
        uint256 var_bh = 0x01 + ~(11);
        uint256 var_be = 0x44 + (var_c - var_c);
        var_c = var_c + 0x64;
        uint224 var_bi = 0xa9059cbb00000000000000000000000000000000000000000000000000000000 | (uint224(var_l));
        uint256 var_bj = 0;
        (bool success, bytes memory ret0) = address(var_e).adfepixw(var_bk); // call
        require(ret0.length == 0, "Bad transfer");
        require(!0, "Bad transfer");
        var_bl = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_bk = 0x20;
        var_bm = 0x0c;
        var_bj = 0x426164207472616e736665720000000000000000000000000000000000000000;
        var_bl = 0x11da60b400000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).settle(var_bk); // call
        var_c = var_c + (uint248(ret0.length + 0x1f));
        require(!((var_c + ret0.length) - var_c) < 0x20);
        require(!0x01);
        require(0x01);
        var_aa = 0x0b0d9c0900000000000000000000000000000000000000000000000000000000;
        uint256 var_bm = address(msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x01] >> 0x60);
        var_bj = address(this);
        bytes32 var_bn = var_a >> 0x80;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_0b0d9c09(var_bm); // call
        var_aa = 0x0b0d9c0900000000000000000000000000000000000000000000000000000000;
        var_bm = address(msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x01] >> 0x60);
        var_bj = address(this);
        var_bn = 0x01 + ~(11);
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_0b0d9c09(var_bm); // call
        require(0x01);
        var_aa = 0x0b0d9c0900000000000000000000000000000000000000000000000000000000;
        var_bm = address(msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x01] >> 0x60);
        var_bj = address(this);
        var_bn = 11;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_0b0d9c09(var_bm); // call
        var_be = 0xa584119400000000000000000000000000000000000000000000000000000000;
        uint256 var_bf = 0;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).sync(var_bf); // call
        var_be = 0x11da60b400000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).{ value: 0x01 + ~(11) }settle(var_bf); // call
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x32;
        var_be = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_bf = 0x20;
        var_bg = 0x07;
        var_bh = 0x31313a7765746800000000000000000000000000000000000000000000000000;
        require(!(msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x2b] >> 0x80), "11:weth");
        require(!((msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x1b] >> 0x80) > (msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x2b] >> 0x80)), "11:weth");
        var_be = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_bf = 0x20;
        var_bg = 0x07;
        var_bh = 0x31313a7765746800000000000000000000000000000000000000000000000000;
        require((0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) < msg.data.length);
        require(!(bytes1((msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0] >> 0xf8) << 0xf8)) > 0);
        var_be = 0xa584119400000000000000000000000000000000000000000000000000000000;
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_bf = var_e;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).sync(var_bf); // call
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_be = 0xd0e30db000000000000000000000000000000000000000000000000000000000;
        require(address(var_e).code.length);
        var_be = 0xa584119400000000000000000000000000000000000000000000000000000000;
        var_bf = 0;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).sync(var_bf); // call
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x32;
        if (0x01) {
            require(0x01, "11:weth");
        }
        var_c = var_c + (uint248(ret0.length + 0x3f));
        var_be = ret0.length;
        require(!0x01, "11:weth");
        require(0x01, "11:weth");
        require(!(msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x2b] >> 0x80), "11:weth");
        require(!((msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x1b] >> 0x80) > (msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x2b] >> 0x80)), "11:weth");
        var_bo = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_bh = 0x20;
        var_bl = 0x07;
        var_aa = 0x31313a7765746800000000000000000000000000000000000000000000000000;
        require(0x01);
        require(!(msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x2b]) >> 0x80);
        require((0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) < msg.data.length);
        require(!(bytes1((msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0] >> 0xf8) << 0xf8)) > 0);
        var_bo = 0xa584119400000000000000000000000000000000000000000000000000000000;
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_bh = var_e;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_a5841194(var_bh); // call
        var_e = this.code[9869:9901];
        var_e = var_e;
        var_bo = 0xd0e30db000000000000000000000000000000000000000000000000000000000;
        require(address(var_e).code.length);
        var_bo = 0xa584119400000000000000000000000000000000000000000000000000000000;
        var_bh = 0;
        require(address(0x04444c5dc75cb358380d2e3de08a90).code.length);
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).Unresolved_a5841194(var_bh); // call
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x32;
        var_ac = 0x01;
        var_ae = 0x01000276a4;
        if (!(msg.data[0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)]) >> 0xf8) {
            var_e = this.code[9869:9901];
            var_e = var_e;
            var_y = var_e;
            var_ao = msg.data[154:174];
            if (0x01) {
            }
            var_ba = 0xf3cd914c00000000000000000000000000000000000000000000000000000000;
            if (!0) {
                require(!(msg.data[0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)]) >> 0xf8);
            }
            require(!0);
        }
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x32;
        var_az = 0x70a0823100000000000000000000000000000000000000000000000000000000;
        var_an = address(this);
        (bool success, bytes memory ret0) = address(msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x01] >> 0x60).balanceOf(var_an); // staticcall
        var_az = 0x60;
        var_c = var_c + 0x80;
        var_l = msg.data[4:100];
        var_ba = 0xcb00000000000000000000000000000000000000000000000000000000000000;
        var_ap = msg.data[152:212];
        var_bp = 0x3dbc;
        var_bq = 0x48c8949100000000000000000000000000000000000000000000000000000000;
        var_ay = 0x20;
        uint256 var_br = var_c.length;
        uint256 var_ah = 0;
        (bool success, bytes memory ret0) = address(0x04444c5dc75cb358380d2e3de08a90).unlock(var_ay); // call
        var_c = var_c + (uint248(ret0.length + 0x1f));
        require(!((var_c + ret0.length) - var_c) < 0x20);
        require(!var_c.length > 0xffffffffffffffff);
        require((var_c + ret0.length) > ((var_c + var_c.length) + 0x1f));
        require(!(var_at) > 0xffffffffffffffff);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x41;
        require(!((var_c + (uint248(0x3f + (var_au + 0x1f)))) < var_c) | ((var_c + (uint248(0x3f + (var_au + 0x1f)))) > 0xffffffffffffffff));
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x41;
        var_c = var_c + (uint248(0x3f + (var_au + 0x1f)));
        var_bs = var_at;
        require(!(var_c + ret0.length) < (0x20 + (var_au + (var_c + var_c.length))));
        require(0 - (msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x28] >> 0x80), "03:weth");
        var_e = this.code[9869:9901];
        var_e = var_e;
        require(0x02 - (msg.data[(msg.data[arg1 >> 0xf8]) >> 0xf8] >> 0xf8), "03:weth");
        require(0x03 - (msg.data[(msg.data[arg1 >> 0xf8]) >> 0xf8] >> 0xf8), "03:weth");
        var_az = 0x20;
        var_c = 0x40 + var_c;
        var_l = msg.data[4:36];
        var_ba = 0xcb060000000000000000000000000000000000000000000000000000000016bc + ((msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x14] >> 0x60) << 0x50);
        require(!(address(msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x14] >> 0x60) < var_e), "03:weth");
        var_bt = 0x128acb0800000000000000000000000000000000000000000000000000000000;
        var_u = address(this);
        var_z = 0;
        var_ay = (msg.data[(0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)) + 0x28]) >> 0x80;
        var_br = 0xfffd8963efd1fc6a506488495d951d5263988d25;
        var_ac = 0xa0;
        var_ad = var_c.length;
        var_ah = 0;
        (bool success, bytes memory ret0) = address(msg.data[0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8)] >> 0x60).Unresolved_128acb08(var_u, var_z, var_ay, var_br, var_ac, var_ad, var_ae); // call
        require(!(0 < (msg.data[0x38 + (0x01 + (msg.data[arg1 >> 0xf8] >> 0xf8))] >> 0x80)), "03:weth");
        var_bt = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_u = 0x20;
        var_z = 0x07;
        var_ay = 0x30333a7765746800000000000000000000000000000000000000000000000000;
        require(var_c + 0x8000000000000000000000000000000000000000000000000000000000000000);
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x11;
        var_c = var_c + (uint248(ret0.length + 0x1f));
        require(!((var_c + ret0.length) - var_c) < 0x40);
        require(!0x01);
        require(!(var_l) < var_c);
        var_bp = 0x2e1a7d4d00000000000000000000000000000000000000000000000000000000;
        var_z = var_l;
        var_e = this.code[9869:9901];
        var_e = var_e;
        require(address(var_e).code.length);
        (bool success, bytes memory ret0) = address(var_e).withdraw(var_z); // call
        var_bp = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_z = 0x20;
        var_ay = 0x07;
        var_br = 0x30333a7765746800000000000000000000000000000000000000000000000000;
        var_az = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_an = 0x20;
        var_y = 0x07;
        var_u = 0x30333a7765746800000000000000000000000000000000000000000000000000;
        var_aq = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_n = 0x20;
        var_t = 0x07;
        var_as = 0x30333a7765746800000000000000000000000000000000000000000000000000;
        if (!arg1 >> 0xf8) {
        }
        if (!arg1 >> 0xf8) {
        }
    }
}