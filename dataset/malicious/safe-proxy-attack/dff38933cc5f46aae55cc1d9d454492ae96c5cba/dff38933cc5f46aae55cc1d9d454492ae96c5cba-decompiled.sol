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
    uint256 store_b;
    address store_a;
    
    
    /// @custom:selector    0x582515c7
    /// @custom:signature   Unresolved_582515c7(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_582515c7(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x6a761202
    /// @custom:signature   Unresolved_6a761202(address arg0, uint256 arg1, uint256 arg2, bool arg3) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["bool", "uint8", "bytes1", "int8"]
    function Unresolved_6a761202(address arg0, uint256 arg1, uint256 arg2, bool arg3) public pure {
        require(arg0 == (address(arg0)));
        require(!arg2 > 0xffffffffffffffff);
        require(!(arg2) > 0xffffffffffffffff);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x41;
        require(!((var_c + (uint248(0x3f + (arg2 + 0x1f)))) < var_c) | ((var_c + (uint248(0x3f + (arg2 + 0x1f)))) > 0xffffffffffffffff));
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x41;
        uint256 var_c = var_c + (uint248(0x3f + (arg2 + 0x1f)));
        uint256 var_d = (arg2);
        var_e = msg.data[36:36];
        uint256 var_f = 0;
        require(arg3 == (bytes1(arg3)));
    }
    
    /// @custom:selector    0xa9059cbb
    /// @custom:signature   transfer(address arg0, uint256 arg1) public
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function transfer(address arg0, uint256 arg1) public {
        require(arg0 == (address(arg0)));
        store_a = (address(arg0)) | (uint96(store_a));
        store_b = arg1;
    }
    
    /// @custom:selector    0x1163b2b0
    /// @custom:signature   sweepETH(address arg0) public
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function sweepETH(address arg0) public {
        require(arg0 == (address(arg0)));
        require(address(this).balance > 0, "ETH transfer failed");
        (bool success, bytes memory ret0) = address(arg0).transfer(address(this).balance);
        require(ret0.length == 0, "ETH transfer failed");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x13;
        var_d = 0x455448207472616e73666572206661696c656400000000000000000000000000;
        (bool success, bytes memory ret0) = address(arg0).transfer(address(this).balance);
        if (ret0.length == 0) {
        }
    }
}