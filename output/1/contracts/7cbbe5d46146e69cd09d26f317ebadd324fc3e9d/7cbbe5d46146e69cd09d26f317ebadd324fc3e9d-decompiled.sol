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
    fallback() external payable {
        var_a = 0x80;
        var_b = 0x5c60da1b00000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(0x28cd26607b09f6a2c89c1ec02cc5ec9b25cb0257).implementation(var_c); // staticcall
        uint256 var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(var_a.length == (address(var_a.length)));
        var_d = msg.data[0:0];
        (bool success, bytes memory ret0) = address(var_a.length).Unresolved_(var_e); // delegatecall
        return ;
    }
    
}