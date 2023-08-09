// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibERC20 } from "../libs/LibERC20.sol";

error ERC20InvalidToken(address token);
error ERC20InvalidSender(address sender);
error ERC20InvalidReceiver(address receiver);

contract ERC20Facet {
  modifier isValidToken(address token) {
    if (len(LibAppStorage.diamondStorage().erc20s[token].name) == 0) {
      revert ERC20InvalidToken(token);
    }
    _;
  }

  function erc20NewToken(string memory name, string memory symbol, uint8 decimals) external {
    LibERC20.create(name, symbol, decimals);
  }

  function erc20Name(address token) external view isValidToken(token) returns (string memory) {
    return LibAppStorage.diamondStorage().erc20s[token].name;
  }

  /**
    * @dev Returns the symbol of the token.
    */
  function erc20Symbol(address token) external view isValidToken(token) returns (string memory) {
    return LibAppStorage.diamondStorage().erc20s[token].symbol;
  }

  /**
    * @dev Returns the decimals places of the token.
    */
  function erc20Decimals(address token) external view isValidToken(token) returns (uint8) {
    return LibAppStorage.diamondStorage().erc20s[token].decimals;
  }

  /**
    * @dev Get the total supply.
    */
  function erc20TotalSupply(address token) public view isValidToken(token) returns (uint256) {
    return LibAppStorage.diamondStorage().erc20s[token].totalSupply;
  }

  /**
    * @dev Get the balance of the given wallet.
    */
  function erc20BalanceOf(address token, address account) public view isValidToken(token) returns (uint256) {
    return LibAppStorage.diamondStorage().erc20s[token].balances[account];
  }

  /**
    * @dev Transfer a token.
    */
  function erc20Transfer(address token, address from, address to, uint256 amount) public isValidToken(token) returns (uint256) {
    return LibAppStorage.diamondStorage().erc20s[token].balances[account];
  }
}
