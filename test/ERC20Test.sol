// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import "forge-std/Test.sol";
import { ERC20 } from "src/facades/ERC20.sol";
import { Vm } from "forge-std/Vm.sol";
import { TestBaseContract, console2 } from "./utils/TestBaseContract.sol";
import "../src/facets/ERC20Facet.sol";

contract ERC20Test is TestBaseContract {
  function setUp() public virtual override {
    super.setUp();
  }

  function testDeployFacadeFails() public {
    vm.expectRevert( abi.encodePacked(ERC20InvalidInput.selector) );
    diamond.erc20DeployToken("", "TEST", 18);

    vm.expectRevert( abi.encodePacked(ERC20InvalidInput.selector) );
    diamond.erc20DeployToken("TestToken", "", 18);

    vm.expectRevert( abi.encodePacked(ERC20InvalidInput.selector) );
    diamond.erc20DeployToken("TestToken", "TEST", 0);
  }

  function testDeployFacadeSucceeds() public returns (ERC20) {
    vm.recordLogs();
    diamond.erc20DeployToken("TestToken", "TEST", 18);
    Vm.Log[] memory entries = vm.getRecordedLogs();
    assertEq(entries.length, 1, "Invalid entry count");
    assertEq(entries[0].topics.length, 1, "Invalid event count");
    assertEq(
        entries[0].topics[0],
        keccak256("ERC20NewToken(address)"),
        "Invalid event signature"
    );
    (address t) = abi.decode(entries[0].data, (address));

    ERC20 token = ERC20(t);

    assertEq(token.name(), "TestToken", "Invalid name");
    assertEq(token.symbol(), "TEST", "Invalid symbol");
    assertEq(token.decimals(), 18, "Invalid decimals");

    return token;
  }
}
