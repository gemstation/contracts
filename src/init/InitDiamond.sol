// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { AppStorage, LibAppStorage } from "../libs/LibAppStorage.sol";

error DiamondAlreadyInitialized();

contract InitDiamond {
  event InitializeDiamond(address sender);

  function initialize() external {
    AppStorage storage s = LibAppStorage.diamondStorage();
    if (s.diamondInitialized) {
      revert DiamondAlreadyInitialized();
    }
    s.diamondInitialized = true;

    /*
        TODO: add custom initialization logic here
    */

    emit InitializeDiamond(msg.sender);
  }
}
