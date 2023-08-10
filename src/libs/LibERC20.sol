// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { ERC20 } from "../share/Structs.sol";
import { AppStorage, LibAppStorage } from "./LibAppStorage.sol";

error ERC20InvalidInput();
error ERC20InvalidToken(address token);
error ERC20InvalidSender(address sender);
error ERC20InvalidReceiver(address receiver);
error ERC20NotEnoughBalance(address sender);

library LibERC20 {
  event ERC20NewToken(address token);
  event ERC20Minted(address token, address to, uint256 amount);
  event ERC20Transferred(address token, address indexed from, address indexed to, uint256 value);

  /**
   * @dev Deploy new token.
   */
  function create(string name, string symbol, uint8 decimals) internal returns (address) {
    if (name == "" || symbol == "") {
      revert ERC20InvalidInput();
    }

    address token = address(new ERC20(address(this)));

    LibAppStorage.diamondStorage().erc20s[token].name = name;
    LibAppStorage.diamondStorage().erc20s[token].symbol = symbol;
    LibAppStorage.diamondStorage().erc20s[token].decimals = decimals;

    emit ERC20NewToken(token);

    return token;
  }

  /**
    * @dev Returns the name of the token.
    */
  function name(address token) internal view returns (string memory) {
    return LibAppStorage.diamondStorage().erc20s[token].name;
  }

  /**
    * @dev Returns the symbol of the token.
    */
  function symbol(address token) internal view returns (string memory) {
    return LibAppStorage.diamondStorage().erc20s[token].symbol;
  }

  /**
    * @dev Returns the decimals places of the token.
    */
  function decimals(address token) internal view returns (uint8) {
    return LibAppStorage.diamondStorage().erc20s[token].decimals;
  }

  /**
    * @dev Get the total supply.
    */
  function totalSupply(address token) internal view returns (uint256) {
    return LibAppStorage.diamondStorage().erc20s[token].totalSupply;
  }

  /**
    * @dev Get the balance of the given wallet.
    */
  function balanceOf(address token, address account) internal view returns (uint256) {
    return LibAppStorage.diamondStorage().erc20s[token].balances[account];
  }

  /**
    * @dev Transfer a token.
    */
  function transfer(address token, address from, address to, uint256 amount) internal {
    if (from == address(0)) {
      revert ERC20InvalidSender(from);
    }

    if (to == address(0)) {
      revert ERC20InvalidReceiver(to);
    }
    
    LibERC20._update(token, from, to, amount);

    emit ERC20Transferred(token, from, to, amount);
  }  

  /**
    * @dev Mint a token.
    */
  function mint(address token, address to, uint256 amount) internal {
    if (to == address(0)) {
      revert ERC20InvalidReceiver(to);
    }
    
    LibERC20._update(token, address(0), to, value);

    emit ERC20Minted(token, to, amount);
  }  

  // Private methods

  /**
   * @dev Transfer or mint token.
   */
  function _update(address token, address from, address to, uint256 amount) private {
    ERC20 storage erc20 = LibAppStorage.diamondStorage().erc20s[token];

    if (from != address(0) && erc20.balances[from] < amount) {
      revert ERC20NotEnoughBalance(from);
    }

    if (from != address(0)) {
      erc20.balances[from] -= amount;
    } else {
      erc20.totalSupply += amount;
    }
    
    erc20.balances[to] += amount;
  }
}
