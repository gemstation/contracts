// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { IERC20 } from "lib/openzeppelin-contracts/contracts/tokens/ERC20/IERC20.sol";
import { IERC20Metadata } from "lib/openzeppelin-contracts/contracts/tokens/ERC20/extensions/IERC20Metadata.sol";

contract ERC20 is IERC20, IERC20Metadata {
  IERC20Facet private _parent;

  constructor(IERC20Facet parent) {
    _parent = parent;
  }

  function name() public view override returns (string memory) {
    return _parent.erc20Name(address(this));
  }

  function symbol() public view override returns (string memory) {
    return _parent.erc20Symbol(address(this));
  }  

  function decimals() public view override returns (uint8) {
    return _parent.erc20Decimals(address(this));
  }

  function totalSupply() public view override returns (uint256) {
    return _parent.erc20TotalSupply(address(this));
  }

  function balanceOf(address account) public view override returns (uint256) {
    return _parent.erc20BalanceOf(address(this), account);
  }

  function transfer(address recipient, uint256 amount) public override returns (bool) {
    _parent.erc20Transfer(address(this), msg.sender, recipient, amount);
    return true;
  }

  function allowance(address owner, address spender) public view override returns (uint256) {
    return _parent.erc20Allowance(address(this), owner, spender);
  }

  function approve(address spender, uint256 amount) public override returns (bool) {
    _parent.erc20Approve(address(this), msg.sender, spender, amount);
    return true;
  }

  function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
    _parent.erc20TransferFrom(address(this), msg.sender, sender, recipient, amount);
    return true;
  }
}
