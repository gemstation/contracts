// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { ERC20Token } from "../shared/Structs.sol";
import { AppStorage, LibAppStorage } from "./LibAppStorage.sol";

library LibERC20 {
  event ERC20Minted(address token, address to, uint256 amount);
  event ERC20Transferred(address token, address from, address to, uint256 value);

  /**
    * @dev Transfer a token.
    *
    * @param token The token to transfer.
    * @param from The address to transfer the token from.
    * @param to The address to transfer the token to.
    * @param amount The amount to transfer.
    */
  function transfer(address token, address from, address to, uint256 amount) internal {
    ERC20Token storage t = LibAppStorage.diamondStorage().erc20s[token];

    t.balances[from] -= amount;
    t.balances[to] += amount;

    emit ERC20Transferred(token, from, to, amount);
  }  

  /**
    * @dev Mint a token.
    *
    * @param token The token to mint.
    * @param to The address to mint the token to.
    * @param amount The amount to mint.
    */
  function mint(address token, address to, uint256 amount) internal {
    ERC20Token storage t = LibAppStorage.diamondStorage().erc20s[token];
    t.totalSupply += amount;
    t.balances[to] += amount;
    emit ERC20Minted(token, to, amount);
  }  
}
