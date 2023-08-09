// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

struct ERC2711ContextStorage {
  address trustedForwarder;
}

struct ERC20 {
  string name;
  string symbol;
  uint8 decimals;
  mapping(address => uint256) balances;
  mapping(address => mapping(address => uint256)) allowances;
  uint256 totalSupply;
}

struct ERC20Tokens {
  mapping(address => ERC20) erc20s;
}

