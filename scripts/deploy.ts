require('dotenv').config();

import assert from "assert";
import { ethers } from "hardhat";
async function main() {
  const PRIVATE_KEY = process.env.PRIVATE_KEY;
  const INFURA_KEY = process.env.INFURA;

  assert(PRIVATE_KEY !== undefined);
  assert(INFURA_KEY !== undefined);

  let provider = new ethers.providers.JsonRpcProvider(`https://polygon-mainnet.infura.io/v3/${INFURA_KEY}`)
  const wallet = new ethers.Wallet(PRIVATE_KEY, provider);

  const FlipHackFactory = (await ethers.getContractFactory("FlipHack")).connect(wallet);

  const gasPrice = 100000000000;
  const flipHack = await FlipHackFactory.deploy({gasPrice});
  console.log({flipHack: flipHack.address});
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
