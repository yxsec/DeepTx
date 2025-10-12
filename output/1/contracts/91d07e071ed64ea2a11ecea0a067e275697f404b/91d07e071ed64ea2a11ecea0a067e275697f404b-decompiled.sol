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
    uint256 public constant decimals = 18;
    
    bytes32 store_d;
    mapping(bytes32 => bytes32) storage_map_h;
    bytes32 store_m;
    bytes32 store_j;
    uint256 public totalSupply;
    mapping(bytes32 => bytes32) storage_map_k;
    address public unresolved_8da5cb5b;
    mapping(bytes32 => bytes32) storage_map_b;
    address public pod;
    uint256 public totalAssets;
    address public unresolved_8d053382;
    address public unresolved_5db48b97;
    uint256 public lpSlippage;
    mapping(bytes32 => bytes32) storage_map_n;
    bytes32 store_o;
    
    error OwnableInvalidOwner(address);
    event Transfer(address, address, uint256);
    event Event_d6835634();
    event Event_9feee421();
    event Event_d618dae3();
    event Approval(address, address, uint256);
    event Event_5c01ded6();
    event Event_811ce756();
    event Event_13568239();
    event Event_d6fdc17a();
    event OwnershipTransferred(address, address);
    
    /// @custom:selector    0x095ea7b3
    /// @custom:signature   approve(address arg0, uint256 arg1) public payable returns (bool)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function approve(address arg0, uint256 arg1) public payable returns (bool) {
        require(arg0 == (address(arg0)));
        require(address(msg.sender), CustomError_94280d62());
        require(address(arg0), CustomError_94280d62());
        address var_a = address(msg.sender);
        var_b = 0x01;
        var_a = address(arg0);
        address var_b = keccak256(var_a);
        storage_map_b[var_a] = arg1;
        require(!0x01, CustomError_94280d62());
        var_c = 0x01;
        return 0x01;
        uint256 var_c = arg1;
        emit Approval(address(msg.sender), address(arg0), arg1);
        var_c = 0x01;
        return 0x01;
        var_c = 0x94280d6200000000000000000000000000000000000000000000000000000000;
        uint256 var_d = 0;
        var_c = 0xe602df0500000000000000000000000000000000000000000000000000000000;
        var_d = 0;
    }
    
    /// @custom:selector    0xa52f01e3
    /// @custom:signature   Unresolved_a52f01e3(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_a52f01e3(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x715018a6
    /// @custom:signature   renounceOwnership() public payable
    function renounceOwnership() public payable {
        require(msg.sender == (address(unresolved_8da5cb5b)), CustomError_118cdaa7());
        var_a = 0x118cdaa700000000000000000000000000000000000000000000000000000000;
        address var_b = msg.sender;
        unresolved_8da5cb5b = 0 | (uint96(unresolved_8da5cb5b));
        emit OwnershipTransferred(address(unresolved_8da5cb5b), 0);
    }
    
    /// @custom:selector    0x8795cccb
    /// @custom:signature   withdrawProtocolFees() public payable
    function withdrawProtocolFees() public payable {
        require(store_d > 0);
        store_d = 0;
        var_a = 0x4f4ce61d00000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(pod).Unresolved_4f4ce61d(var_b); // staticcall
        uint256 var_c = var_c + (uint248(ret0.length + 0x1f));
        require(!((var_c + ret0.length) - var_c) < 0x20);
        require(var_c.length == (address(var_c.length)));
        address var_d = address(unresolved_8da5cb5b);
        var_e = store_d;
        uint256 var_f = ((0x64 + var_c) - var_c) - 0x20;
        var_c = 0x64 + var_c;
        uint224 var_g = (uint224(var_h)) | 0xa9059cbb00000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(var_c.length).{ value: store_d ether }Unresolved_a9059cbb(var_d); // call
        require(!ret0.length, CustomError_5274afe7());
        require(!(!address(var_c.length).code.length), CustomError_5274afe7());
        var_i = 0x5274afe700000000000000000000000000000000000000000000000000000000;
        uint256 var_j = address(var_c.length);
        var_i = store_d;
        emit Event_d6fdc17a(store_d);
        require(!(!0x01 == var_k), CustomError_5274afe7());
        var_i = store_d;
        emit Event_d6fdc17a(store_d);
        var_i = 0x5274afe700000000000000000000000000000000000000000000000000000000;
        var_j = address(var_c.length);
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_l = 0x01;
        var_d = 0x5a00000000000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0xa9059cbb
    /// @custom:signature   transfer(address arg0, uint256 arg1) public payable returns (bool)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function transfer(address arg0, uint256 arg1) public payable returns (bool) {
        require(arg0 == (address(arg0)));
        require(address(msg.sender), CustomError_e450d38c());
        require(address(arg0), CustomError_e450d38c());
        require(address(msg.sender), CustomError_e450d38c());
        address var_a = address(msg.sender);
        uint256 var_b = 0;
        require(!(storage_map_b[var_a] < arg1), CustomError_e450d38c());
        var_c = 0xe450d38c00000000000000000000000000000000000000000000000000000000;
        address var_d = address(msg.sender);
        address var_e = storage_map_b[var_a];
        uint256 var_f = arg1;
        var_a = address(msg.sender);
        var_b = 0;
        storage_map_b[var_a] = storage_map_b[var_a] - arg1;
        require(address(arg0), CustomError_ec442f05());
        var_a = address(arg0);
        var_b = 0;
        storage_map_b[var_a] = var_f + storage_map_b[var_a];
        uint256 var_c = arg1;
        emit Transfer(address(msg.sender), address(arg0), arg1);
        var_c = 0x01;
        return 0x01;
        totalSupply = totalSupply - arg1;
        var_c = arg1;
        emit Transfer(address(msg.sender), address(arg0), arg1);
        var_c = 0x01;
        return 0x01;
        require(!(totalSupply > (arg1 + totalSupply)), CustomError_ec442f05());
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x11;
        var_c = 0xec442f0500000000000000000000000000000000000000000000000000000000;
        var_d = 0;
        var_c = 0x96c6fd1e00000000000000000000000000000000000000000000000000000000;
        var_d = 0;
    }
    
    /// @custom:selector    0x0a28a477
    /// @custom:signature   previewWithdraw(uint256 arg0) public view returns (uint256)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function previewWithdraw(uint256 arg0) public view returns (uint256) {
        if (!totalSupply) {
            require(!totalSupply);
            var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_b = 0x11;
            require((totalAssets == ((totalAssets * 0x0de0b6b3a7640000) / 0x0de0b6b3a7640000)) | !0x0de0b6b3a7640000);
            require(totalSupply);
            var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_b = 0x21;
            require(!0x01 > 0x03);
            var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_b = 0x12;
            require(0x02);
            require(!0x01 == 0x01);
            require(((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))));
            var_a = 0x4e487b71;
            uint256 var_c = 0x11 ^ ((!(totalAssets * 0x0de0b6b3a7640000) / totalSupply) * 0x03);
            require((totalAssets * 0x0de0b6b3a7640000) / totalSupply);
            require(!((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) > ((0x01 == 0x01) + ((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply))));
            var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_b = 0x11;
            uint256 var_d = (0x01 == 0x01) + ((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply));
            return (0x01 == 0x01) + ((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply));
            var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_b = 0x12;
            require((totalAssets * 0x0de0b6b3a7640000) / totalSupply);
            require(0 - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))));
        }
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        require(!0x01 > 0x03);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x21;
        require(0x02);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        require(!0x01 == 0x01);
        require(0x0de0b6b3a7640000);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
    }
    
    /// @custom:selector    0xc6e6f592
    /// @custom:signature   convertToShares(uint256 arg0) public view returns (uint256)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function convertToShares(uint256 arg0) public view returns (uint256) {
        require(!totalSupply);
        require((totalAssets == ((totalAssets * 0x0de0b6b3a7640000) / 0x0de0b6b3a7640000)) | !0x0de0b6b3a7640000);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x11;
        require(totalSupply);
        require(!0 > 0x03);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x21;
        require(0x02);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        require(!0x01 == 0);
        require((totalAssets * 0x0de0b6b3a7640000) / totalSupply);
        require(0 - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))));
        require(((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))));
        var_a = 0x4e487b71;
        uint256 var_c = 0x11 ^ ((!(totalAssets * 0x0de0b6b3a7640000) / totalSupply) * 0x03);
        require((totalAssets * 0x0de0b6b3a7640000) / totalSupply);
        require(!((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) > (((arg0 * 0x0de0b6b3a7640000) % ((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > 0) + ((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply))));
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x11;
        uint256 var_d = ((arg0 * 0x0de0b6b3a7640000) % ((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > 0) + ((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply));
        return ((arg0 * 0x0de0b6b3a7640000) % ((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > 0) + ((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply));
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        require(0 - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))));
        require(((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))));
        var_a = 0x4e487b71;
        var_c = 0x11 ^ ((!(totalAssets * 0x0de0b6b3a7640000) / totalSupply) * 0x03);
        require((totalAssets * 0x0de0b6b3a7640000) / totalSupply);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        require(!0 > 0x03);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x21;
        require(0x02);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        require(!0x01 == 0);
        require(0x0de0b6b3a7640000);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
    }
    
    /// @custom:selector    0xf79a4036
    /// @custom:signature   Unresolved_f79a4036(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_f79a4036(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x7ecebe00
    /// @custom:signature   nonces(address arg0) public view returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function nonces(address arg0) public view returns (uint256) {
        require(arg0 == (address(arg0)));
        address var_a = address(arg0);
        var_b = 0x07;
        address var_c = storage_map_b[var_a];
        return storage_map_b[var_a];
    }
    
    /// @custom:selector    0x37fb6217
    /// @custom:signature   Unresolved_37fb6217(address arg0) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_37fb6217(address arg0) public payable {
        require(arg0 == (address(arg0)));
        require(msg.sender == (address(unresolved_8da5cb5b)), CustomError_118cdaa7());
        var_a = 0x118cdaa700000000000000000000000000000000000000000000000000000000;
        address var_b = msg.sender;
        unresolved_8d053382 = (address(arg0)) | (uint96(unresolved_8d053382));
        address var_a = address(arg0);
        emit Event_13568239(address(arg0));
    }
    
    /// @custom:selector    0x6e553f65
    /// @custom:signature   Unresolved_6e553f65(uint256 arg0, address arg1) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_6e553f65(uint256 arg0, address arg1) public payable {
        require(arg1 == (address(arg1)));
        require(!bytes1(unresolved_8d053382 / 0x010000000000000000000000000000000000000000));
        var_a = 0x94cc699e00000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(pod).lpStakingPool(var_b); // staticcall
        uint256 var_c = var_c + (uint248(ret0.length + 0x1f));
        require(!((var_c + ret0.length) - var_c) < 0x20);
        require(var_c.length == (address(var_c.length)));
        var_d = 0xf5996fe400000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(var_c.length).Unresolved_f5996fe4(var_e); // staticcall
        require(!totalSupply, "MS");
        require((totalAssets == ((totalAssets * 0x0de0b6b3a7640000) / 0x0de0b6b3a7640000)) | !0x0de0b6b3a7640000, "MS");
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x11;
        require(totalSupply, "MS");
        require(!(0 > 0x03), "MS");
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x21;
        require(0x02, "MS");
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x12;
        require(!(0x01 == 0), "MS");
        require((totalAssets * 0x0de0b6b3a7640000) / totalSupply, "MS");
        require(0 - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))), "MS");
        require(((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))), "MS");
        var_f = 0x4e487b71;
        uint256 var_h = 0x11 ^ ((!(totalAssets * 0x0de0b6b3a7640000) / totalSupply) * 0x03);
        require((totalAssets * 0x0de0b6b3a7640000) / totalSupply, "MS");
        require(!((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > (((arg0 * 0x0de0b6b3a7640000) % ((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > 0) + ((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)))), "MS");
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x11;
        require(0 - arg0, "MS");
        require(0 - (((arg0 * 0x0de0b6b3a7640000) % ((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > 0) + ((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply))), "MS");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_e = 0x02;
        var_i = 0x4d53000000000000000000000000000000000000000000000000000000000000;
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_e = 0x02;
        var_i = 0x4d41000000000000000000000000000000000000000000000000000000000000;
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x12;
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x12;
        require(0 - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))));
        require(((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))));
        var_f = 0x4e487b71;
        var_h = 0x11 ^ ((!(totalAssets * 0x0de0b6b3a7640000) / totalSupply) * 0x03);
        require((totalAssets * 0x0de0b6b3a7640000) / totalSupply);
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x12;
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x12;
        require(!0 > 0x03);
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x21;
        require(0x02);
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x12;
        require(!0x01 == 0);
        require(0x0de0b6b3a7640000);
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x12;
    }
    
    /// @custom:selector    0xd905777e
    /// @custom:signature   maxRedeem(address arg0) public view returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function maxRedeem(address arg0) public view returns (uint256) {
        require(arg0 == (address(arg0)));
        address var_a = address(arg0);
        uint256 var_b = 0;
        address var_c = storage_map_b[var_a];
        return storage_map_b[var_a];
    }
    
    /// @custom:selector    0xdc22a6d8
    /// @custom:signature   Unresolved_dc22a6d8(uint16 arg0, uint256 arg1, uint256 arg2) public payable
    /// @param              arg0 ["uint16", "bytes2", "int16"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    function Unresolved_dc22a6d8(uint16 arg0, uint256 arg1, uint256 arg2) public payable {
        require(arg0 == (uint16(arg0)));
        require(msg.sender == (address(unresolved_8da5cb5b)), CustomError_118cdaa7());
        var_a = 0x118cdaa700000000000000000000000000000000000000000000000000000000;
        address var_b = msg.sender;
        require(!(uint16(arg0) > 0x03e8), "MAX");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x03;
        var_d = 0x4d41580000000000000000000000000000000000000000000000000000000000;
        require(!bytes1(unresolved_8d053382 / 0x010000000000000000000000000000000000000000));
        var_a = 0x94cc699e00000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(pod).lpStakingPool(var_b); // staticcall
        uint256 var_e = var_e + (uint248(ret0.length + 0x1f));
        require(!((var_e + ret0.length) - var_e) < 0x20);
        require(var_e.length == (address(var_e.length)));
        var_f = 0xf5996fe400000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(var_e.length).Unresolved_f5996fe4(var_c); // staticcall
        unresolved_8d053382 = (uint240(unresolved_8d053382)) | (0x01000000000000000000000000000000000000000000 * (uint16(arg0)));
        uint16 var_a = uint16(unresolved_8d053382 / 0x01000000000000000000000000000000000000000000);
        uint16 var_f = uint16(arg0);
        emit Event_5c01ded6(uint16(unresolved_8d053382 / 0x01000000000000000000000000000000000000000000), uint16(arg0));
    }
    
    /// @custom:selector    0xdd62ed3e
    /// @custom:signature   Unresolved_dd62ed3e(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_dd62ed3e(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0xd505accf
    /// @custom:signature   Unresolved_d505accf(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_d505accf(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x6b08f691
    /// @custom:signature   Unresolved_6b08f691(address arg0, uint256 arg1) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function Unresolved_6b08f691(address arg0, uint256 arg1) public payable {
        require(arg0 == (address(arg0)));
        require(msg.sender == (address(unresolved_8da5cb5b)), CustomError_118cdaa7());
        var_a = 0x118cdaa700000000000000000000000000000000000000000000000000000000;
        address var_b = msg.sender;
        address var_c = address(arg0);
        var_d = 0x0e;
        storage_map_h[var_c] = arg1;
        address var_a = address(arg0);
        uint256 var_e = arg1;
        emit Event_811ce756(address(arg0), arg1);
    }
    
    /// @custom:selector    0x84b0196e
    /// @custom:signature   eip712Domain() public view returns (uint256)
    function eip712Domain() public view returns (uint256) {
        require(0xff == 0xff, CustomError_b3512b0c());
        require(!(0xff > 0x1f), CustomError_b3512b0c());
        var_a = 0x20;
        uint256 var_b = 0x40 + var_b;
        var_c = msg.data[4:36];
        var_a = 0xff;
        var_d = 0xff;
        require(0x3100000000000000000000000000000000000000000000000000000000000001 == 0xff, CustomError_b3512b0c());
        require(bytes1(store_j), CustomError_b3512b0c());
        require(bytes1(store_j) - ((store_j >> 0x01) < 0x20), CustomError_b3512b0c());
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x22;
        var_b = var_b + (0x20 + (((0x1f + (store_j >> 0x01)) / 0x20) * 0x20));
        bytes32 var_g = store_j >> 0x01;
        require(bytes1(store_j), CustomError_b3512b0c());
        require(bytes1(store_j) - ((store_j >> 0x01) < 0x20), CustomError_b3512b0c());
        var_e = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_f = 0x22;
        require(!(store_j >> 0x01), CustomError_b3512b0c());
        require(0x1f < (store_j >> 0x01), CustomError_b3512b0c());
        var_e = 0x06;
        var_h = storage_map_k[var_e];
        require((0x20 + var_b) + (store_j >> 0x01) > (0x20 + (0x20 + var_b)), CustomError_b3512b0c());
        uint256 var_h = 0;
        var_b = var_b + 0x20;
        var_i = 0x0f00000000000000000000000000000000000000000000000000000000000000;
        var_j = 0xe0;
        uint256 var_k = var_b.length;
        uint256 var_l = 0;
        uint256 var_m = ((var_b + 0xe0) + (uint248(var_b.length + 0x1f)) + 0x20) - var_b;
        uint256 var_n = var_b.length;
        uint256 var_o = 0;
        uint256 var_p = block.chainid;
        address var_q = address(this);
        uint256 var_r = 0;
        uint256 var_s = (((var_b + 0xe0) + (uint248(var_b.length + 0x1f)) + 0x20) + (uint248(var_b.length + 0x1f)) + 0x20) - var_b;
        var_o = var_b.length;
        return abi.encodePacked(0x0f00000000000000000000000000000000000000000000000000000000000000, 0xe0, ((var_b + 0xe0) + (uint248(var_b.length + 0x1f)) + 0x20) - var_b, block.chainid, address(this), 0, (((var_b + 0xe0) + (uint248(var_b.length + 0x1f)) + 0x20) + (uint248(var_b.length + 0x1f)) + 0x20) - var_b, var_b.length, var_b.length, var_b.length);
        require(!(0x01 > 0x1f), CustomError_b3512b0c());
        var_g = 0xb3512b0c00000000000000000000000000000000000000000000000000000000;
        var_a = 0xb3512b0c00000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x4cdad506
    /// @custom:signature   previewRedeem(uint256 arg0) public view returns (uint256)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function previewRedeem(uint256 arg0) public view returns (uint256) {
        if (!totalSupply) {
            if ((totalAssets == ((totalAssets * 0x0de0b6b3a7640000) / 0x0de0b6b3a7640000)) | !0x0de0b6b3a7640000) {
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x11;
                require(!totalSupply);
                require((totalAssets == ((totalAssets * 0x0de0b6b3a7640000) / 0x0de0b6b3a7640000)) | !0x0de0b6b3a7640000);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x21;
                require(totalSupply);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(!0 > 0x03);
                require(0x02);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(0x0de0b6b3a7640000);
                require(0 - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0))));
                var_a = 0x4e487b71;
                uint256 var_c = 0x11 ^ (!0x0de0b6b3a7640000 * 0x03);
                require(0x0de0b6b3a7640000 > (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0))));
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x11;
                uint256 var_d = (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > 0) + (((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669);
                return (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > 0) + (((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669);
                require(!(((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669) > ((((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > 0) + (((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669)));
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(0x0de0b6b3a7640000);
                require(0 - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0))));
                var_a = 0x4e487b71;
                var_c = 0x11 ^ (!0x0de0b6b3a7640000 * 0x03);
                require(0x0de0b6b3a7640000 > (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0))));
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(0x0de0b6b3a7640000);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x21;
                require(!0 > 0x03);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(0x02);
            }
        }
    }
    
    /// @custom:selector    0xb460af94
    /// @custom:signature   Unresolved_b460af94(uint256 arg0, address arg1) public pure
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_b460af94(uint256 arg0, address arg1) public pure {
        require(arg1 == (address(arg1)));
    }
    
    /// @custom:selector    0x06fdde03
    /// @custom:signature   name() public view returns (string memory)
    function name() public view returns (string memory) {
        if (store_m) {
            if (store_m - ((store_m >> 0x01) < 0x20)) {
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x22;
                uint256 var_c = var_c + (0x20 + (((0x1f + (store_m >> 0x01)) / 0x20) * 0x20));
                bytes32 var_d = store_m >> 0x01;
                if (store_m) {
                    if (store_m - ((store_m >> 0x01) < 0x20)) {
                        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                        var_b = 0x22;
                        if (!store_m >> 0x01) {
                            if (0x1f < (store_m >> 0x01)) {
                                var_a = 0x03;
                                var_e = storage_map_b[var_a];
                                if ((0x20 + var_c) + (store_m >> 0x01) > (0x20 + (0x20 + var_c))) {
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
    
    /// @custom:selector    0x07a2d13a
    /// @custom:signature   convertToAssets(uint256 arg0) public view returns (uint256)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function convertToAssets(uint256 arg0) public view returns (uint256) {
        if (!totalSupply) {
            if ((totalAssets == ((totalAssets * 0x0de0b6b3a7640000) / 0x0de0b6b3a7640000)) | !0x0de0b6b3a7640000) {
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x11;
                require(!totalSupply);
                require((totalAssets == ((totalAssets * 0x0de0b6b3a7640000) / 0x0de0b6b3a7640000)) | !0x0de0b6b3a7640000);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x21;
                require(totalSupply);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(!0 > 0x03);
                require(0x02);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(0x0de0b6b3a7640000);
                require(0 - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0))));
                var_a = 0x4e487b71;
                uint256 var_c = 0x11 ^ (!0x0de0b6b3a7640000 * 0x03);
                require(0x0de0b6b3a7640000 > (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0))));
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x11;
                uint256 var_d = (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > 0) + (((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669);
                return (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > 0) + (((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669);
                require(!(((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669) > ((((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > 0) + (((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669)));
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(0x0de0b6b3a7640000);
                require(0 - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0))));
                var_a = 0x4e487b71;
                var_c = 0x11 ^ (!0x0de0b6b3a7640000 * 0x03);
                require(0x0de0b6b3a7640000 > (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0))));
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(0x0de0b6b3a7640000);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x21;
                require(!0 > 0x03);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(0x02);
            }
        }
    }
    
    /// @custom:selector    0x0a1af273
    /// @custom:signature   maxSwap(address arg0) public view returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function maxSwap(address arg0) public view returns (uint256) {
        require(arg0 == (address(arg0)));
        var_a = 0x0e;
        address var_b = arg0;
        address var_c = storage_map_n[var_b];
        return storage_map_n[var_b];
    }
    
    /// @custom:selector    0x95d89b41
    /// @custom:signature   symbol() public view returns (string memory)
    function symbol() public view returns (string memory) {
        if (store_o) {
            if (store_o - ((store_o >> 0x01) < 0x20)) {
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x22;
                uint256 var_c = var_c + (0x20 + (((0x1f + (store_o >> 0x01)) / 0x20) * 0x20));
                bytes32 var_d = store_o >> 0x01;
                if (store_o) {
                    if (store_o - ((store_o >> 0x01) < 0x20)) {
                        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                        var_b = 0x22;
                        if (!store_o >> 0x01) {
                            if (0x1f < (store_o >> 0x01)) {
                                var_a = 0x04;
                                var_e = storage_map_b[var_a];
                                if ((0x20 + var_c) + (store_o >> 0x01) > (0x20 + (0x20 + var_c))) {
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
    /// @custom:signature   maxDeposit(address arg0) public pure returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function maxDeposit(address arg0) public pure returns (uint256) {
        require(arg0 == (address(arg0)));
        var_a = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
        return 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    }
    
    /// @custom:selector    0xef8b30f7
    /// @custom:signature   previewDeposit(uint256 arg0) public view returns (uint256)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function previewDeposit(uint256 arg0) public view returns (uint256) {
        require(!totalSupply);
        require((totalAssets == ((totalAssets * 0x0de0b6b3a7640000) / 0x0de0b6b3a7640000)) | !0x0de0b6b3a7640000);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x11;
        require(totalSupply);
        require(!0 > 0x03);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x21;
        require(0x02);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        require(!0x01 == 0);
        require((totalAssets * 0x0de0b6b3a7640000) / totalSupply);
        require(0 - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))));
        require(((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))));
        var_a = 0x4e487b71;
        uint256 var_c = 0x11 ^ ((!(totalAssets * 0x0de0b6b3a7640000) / totalSupply) * 0x03);
        require((totalAssets * 0x0de0b6b3a7640000) / totalSupply);
        require(!((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) > (((arg0 * 0x0de0b6b3a7640000) % ((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > 0) + ((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply))));
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x11;
        uint256 var_d = ((arg0 * 0x0de0b6b3a7640000) % ((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > 0) + ((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply));
        return ((arg0 * 0x0de0b6b3a7640000) % ((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > 0) + ((0x0de0b6b3a7640000 * arg0) / ((totalAssets * 0x0de0b6b3a7640000) / totalSupply));
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        require(0 - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))));
        require(((totalAssets * 0x0de0b6b3a7640000) / totalSupply) > (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (0x0de0b6b3a7640000 * arg0) - (((arg0 * 0x0de0b6b3a7640000) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (0x0de0b6b3a7640000 * arg0))));
        var_a = 0x4e487b71;
        var_c = 0x11 ^ ((!(totalAssets * 0x0de0b6b3a7640000) / totalSupply) * 0x03);
        require((totalAssets * 0x0de0b6b3a7640000) / totalSupply);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        require(!0 > 0x03);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x21;
        require(0x02);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
        require(!0x01 == 0);
        require(0x0de0b6b3a7640000);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
    }
    
    /// @custom:selector    0x431fb9c7
    /// @custom:signature   Unresolved_431fb9c7(uint256 arg0) public pure
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function Unresolved_431fb9c7(uint256 arg0) public pure {
        require(arg0 == arg0);
    }
    
    /// @custom:selector    0x23b872dd
    /// @custom:signature   Unresolved_23b872dd(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_23b872dd(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x3644e515
    /// @custom:signature   fopwCDKKK() public view returns (uint256)
    function fopwCDKKK() public view returns (uint256) {
        if (!0x91d07e071ed64ea2a11ecea0a067e275697f404b == address(this)) {
            if (!block.chainid == 0x01) {
                var_a = 0x8b73c3c69bb8fe3d512ecc4cf759cc79239f7b179b0ffacaa9a75d522b39400f;
                var_b = 0x038310df6efc1ec88145bbcd5f1364385716033ea0372ca67b619b771793070b;
                var_c = 0xc89efdaa54c0f20c7adf612882df0950f5a951637e0307cdcb4c672f298b8bc6;
                uint256 var_d = block.chainid;
                address var_e = address(this);
                uint256 var_f = ((0xc0 + var_g) - var_g) - 0x20;
                uint256 var_g = 0xc0 + var_g;
                var_h = keccak256(var_i);
                return keccak256(var_i);
                var_f = 0xc2079e4d921342c9234d9029854532e3caf4f1ee7450a08e33ab17844a116f30;
                return 0xc2079e4d921342c9234d9029854532e3caf4f1ee7450a08e33ab17844a116f30;
                if (!0x91d07e071ed64ea2a11ecea0a067e275697f404b == address(this)) {
                    var_f = 0xc2079e4d921342c9234d9029854532e3caf4f1ee7450a08e33ab17844a116f30;
                    return 0xc2079e4d921342c9234d9029854532e3caf4f1ee7450a08e33ab17844a116f30;
                    var_a = 0x8b73c3c69bb8fe3d512ecc4cf759cc79239f7b179b0ffacaa9a75d522b39400f;
                    var_b = 0x038310df6efc1ec88145bbcd5f1364385716033ea0372ca67b619b771793070b;
                    var_c = 0xc89efdaa54c0f20c7adf612882df0950f5a951637e0307cdcb4c672f298b8bc6;
                    var_d = block.chainid;
                    var_e = address(this);
                    var_f = ((0xc0 + var_g) - var_g) - 0x20;
                    var_g = 0xc0 + var_g;
                    var_h = keccak256(var_i);
                    return keccak256(var_i);
                }
            }
        }
    }
    
    /// @custom:selector    0xf2fde38b
    /// @custom:signature   transferOwnership(address arg0) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function transferOwnership(address arg0) public payable {
        require(arg0 == (address(arg0)));
        require(msg.sender == (address(unresolved_8da5cb5b)), CustomError_118cdaa7());
        var_a = 0x118cdaa700000000000000000000000000000000000000000000000000000000;
        address var_b = msg.sender;
        require(address(arg0), CustomError_1e4fbdf7());
        unresolved_8da5cb5b = (address(arg0)) | (uint96(unresolved_8da5cb5b));
        emit OwnershipTransferred(address(unresolved_8da5cb5b), address(arg0));
        var_a = 0x1e4fbdf700000000000000000000000000000000000000000000000000000000;
        var_b = 0;
    }
    
    /// @custom:selector    0xc63d75b6
    /// @custom:signature   maxMint(address arg0) public pure returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function maxMint(address arg0) public pure returns (uint256) {
        require(arg0 == (address(arg0)));
        var_a = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
        return 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    }
    
    /// @custom:selector    0x70a08231
    /// @custom:signature   balanceOf(address arg0) public view returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function balanceOf(address arg0) public view returns (uint256) {
        require(arg0 == (address(arg0)));
        address var_a = address(arg0);
        uint256 var_b = 0;
        address var_c = storage_map_b[var_a];
        return storage_map_b[var_a];
    }
    
    /// @custom:selector    0x38d52e0f
    /// @custom:signature   asset() public payable returns (address)
    function asset() public payable returns (address) {
        var_a = 0x94cc699e00000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(pod).lpStakingPool(var_b); // staticcall
        uint256 var_c = var_c + (uint248(ret0.length + 0x1f));
        require(!((var_c + ret0.length) - var_c) < 0x20);
        require(var_c.length == (address(var_c.length)));
        uint256 var_d = address(var_c.length);
        return address(var_c.length);
    }
    
    /// @custom:selector    0xfaf419ec
    /// @custom:signature   setLpSlippage(uint256 arg0) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function setLpSlippage(uint256 arg0) public payable {
        require(msg.sender == (address(unresolved_8da5cb5b)), CustomError_118cdaa7());
        var_a = 0x118cdaa700000000000000000000000000000000000000000000000000000000;
        address var_b = msg.sender;
        require(!(arg0 > 0x03e8), "MAX");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x03;
        var_d = 0x4d41580000000000000000000000000000000000000000000000000000000000;
        lpSlippage = arg0;
        uint256 var_a = arg0;
        emit Event_9feee421(arg0);
    }
    
    /// @custom:selector    0xda04d01c
    /// @custom:signature   Unresolved_da04d01c(address arg0) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_da04d01c(address arg0) public payable {
        require(arg0 == (address(arg0)));
        require(msg.sender == (address(unresolved_8da5cb5b)), CustomError_118cdaa7());
        var_a = 0x118cdaa700000000000000000000000000000000000000000000000000000000;
        address var_b = msg.sender;
        unresolved_5db48b97 = (address(arg0)) | (uint96(unresolved_5db48b97));
        address var_a = address(arg0);
        emit Event_d6835634(address(arg0));
    }
    
    /// @custom:selector    0xbe9c8dbb
    /// @custom:signature   Unresolved_be9c8dbb(address arg0) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_be9c8dbb(address arg0) public payable {
        require(arg0 == (address(arg0)));
        require(msg.sender == (address(unresolved_8da5cb5b)), CustomError_118cdaa7());
        var_a = 0x118cdaa700000000000000000000000000000000000000000000000000000000;
        address var_b = msg.sender;
        require(address(arg0), "S");
        require(address(arg0), "S");
        require(!(address(pod)), "S");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x01;
        var_d = 0x5300000000000000000000000000000000000000000000000000000000000000;
        pod = (address(arg0)) | (uint96(pod));
        address var_a = address(arg0);
        emit Event_d618dae3(address(arg0));
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_c = 0x03;
        var_d = 0x494e500000000000000000000000000000000000000000000000000000000000;
    }
    
    /// @custom:selector    0x94bf804d
    /// @custom:signature   mint(uint256 arg0, address arg1) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function mint(uint256 arg0, address arg1) public payable {
        require(arg1 == (address(arg1)));
        require(!bytes1(unresolved_8d053382 / 0x010000000000000000000000000000000000000000));
        var_a = 0x94cc699e00000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(pod).lpStakingPool(var_b); // staticcall
        uint256 var_c = var_c + (uint248(ret0.length + 0x1f));
        require(!((var_c + ret0.length) - var_c) < 0x20);
        require(var_c.length == (address(var_c.length)));
        var_d = 0xf5996fe400000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(var_c.length).Unresolved_f5996fe4(var_e); // staticcall
        require(!totalSupply, "MA");
        require((totalAssets == ((totalAssets * 0x0de0b6b3a7640000) / 0x0de0b6b3a7640000)) | !0x0de0b6b3a7640000, "MA");
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x11;
        require(totalSupply, "MA");
        require(!(0x01 > 0x03), "MA");
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x21;
        require(0x02, "MA");
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x12;
        require(!(0x01 == 0x01), "MA");
        require(0 - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0))), "MA");
        require(0x0de0b6b3a7640000 > (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0))), "MA");
        var_f = 0x4e487b71;
        uint256 var_h = 0x11 ^ (!0x0de0b6b3a7640000 * 0x03);
        require(!((((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669) > ((0x01 == 0x01) + (((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669))), "MA");
        var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_g = 0x11;
        require(0 - ((0x01 == 0x01) + (((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669)), "MA");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_e = 0x02;
        var_i = 0x4d41000000000000000000000000000000000000000000000000000000000000;
        require(0 - arg0, "MS");
        var_a = 0x08c379a000000000000000000000000000000000000000000000000000000000;
        var_b = 0x20;
        var_e = 0x02;
        var_i = 0x4d53000000000000000000000000000000000000000000000000000000000000;
        if (0x0de0b6b3a7640000) {
            var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_g = 0x12;
            require(0x0de0b6b3a7640000);
            var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_g = 0x12;
            var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_g = 0x12;
            require(0x0de0b6b3a7640000);
            var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_g = 0x21;
            require(!0x01 > 0x03);
            var_f = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
            var_g = 0x12;
            require(0x02);
        }
    }
    
    /// @custom:selector    0xce96cb77
    /// @custom:signature   maxWithdraw(address arg0) public view
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function maxWithdraw(address arg0) public view {
        require(arg0 == (address(arg0)));
        require(!totalSupply);
        require((totalAssets == ((totalAssets * 0x0de0b6b3a7640000) / 0x0de0b6b3a7640000)) | !0x0de0b6b3a7640000);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x11;
        require(totalSupply);
        var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
        var_b = 0x12;
    }
    
    /// @custom:selector    0xbe8a6e2f
    /// @custom:signature   Unresolved_be8a6e2f(uint256 arg0, uint256 arg1) public payable returns (uint256)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function Unresolved_be8a6e2f(uint256 arg0, uint256 arg1) public payable returns (uint256) {
        require(msg.sender == (address(unresolved_8da5cb5b)), CustomError_118cdaa7());
        var_a = 0x118cdaa700000000000000000000000000000000000000000000000000000000;
        address var_b = msg.sender;
        require(!bytes1(unresolved_8d053382 / 0x010000000000000000000000000000000000000000));
        var_a = 0x94cc699e00000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(pod).lpStakingPool(var_b); // staticcall
        uint256 var_c = var_c + (uint248(ret0.length + 0x1f));
        require(!((var_c + ret0.length) - var_c) < 0x20);
        require(var_c.length == (address(var_c.length)));
        var_d = 0xf5996fe400000000000000000000000000000000000000000000000000000000;
        (bool success, bytes memory ret0) = address(var_c.length).Unresolved_f5996fe4(var_e); // staticcall
        uint256 var_a = 0;
        return 0;
    }
    
    /// @custom:selector    0xb3d7f6b9
    /// @custom:signature   previewMint(uint256 arg0) public view returns (uint256)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function previewMint(uint256 arg0) public view returns (uint256) {
        if (!totalSupply) {
            if ((totalAssets == ((totalAssets * 0x0de0b6b3a7640000) / 0x0de0b6b3a7640000)) | !0x0de0b6b3a7640000) {
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x11;
                require(!totalSupply);
                require((totalAssets == ((totalAssets * 0x0de0b6b3a7640000) / 0x0de0b6b3a7640000)) | !0x0de0b6b3a7640000);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x21;
                require(totalSupply);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(!0x01 > 0x03);
                require(0x02);
                require(0 - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0))));
                var_a = 0x4e487b71;
                uint256 var_c = 0x11 ^ (!0x0de0b6b3a7640000 * 0x03);
                require(0x0de0b6b3a7640000 > (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0))));
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x11;
                uint256 var_d = (0x01 == 0x01) + (((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669);
                return (0x01 == 0x01) + (((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669);
                require(!(((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669) > ((0x01 == 0x01) + (((((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - ((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) / 0x040000) | (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) - (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) - (((arg0 * ((totalAssets * 0x0de0b6b3a7640000) / totalSupply)) % 0x0de0b6b3a7640000) > (((totalAssets * 0x0de0b6b3a7640000) / totalSupply) * arg0)) * 0x400000000000000000000000000000000000000000000000000000000000) * 0xaccb18165bd6fe31ae1cf318dc5b51eee0e1ba569b88cd74c1773b91fac10669)));
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(0x0de0b6b3a7640000);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(0x0de0b6b3a7640000);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x21;
                require(!0x01 > 0x03);
                var_a = 0x4e487b7100000000000000000000000000000000000000000000000000000000;
                var_b = 0x12;
                require(0x02);
            }
        }
    }
    
    /// @custom:selector    0xba087652
    /// @custom:signature   Unresolved_ba087652(uint256 arg0, address arg1) public pure
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_ba087652(uint256 arg0, address arg1) public pure {
        require(arg1 == (address(arg1)));
    }
}