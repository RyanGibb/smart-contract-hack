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

  const CoinFlipFactory = (await ethers.getContractFactory("CoinFlip")).connect(wallet);

  const gasPrice = 1000000000000;
  // TODO: Approve CoinFlip to spend CamHack tokens
  console.log("------------------------CoinFlip---------------------------");
  const coinFlip = await CoinFlipFactory.deploy({gasPrice});
  console.log({coinFlip: coinFlip.address});
}

// TODO: remember to vault.giveMoneyBack() after the challenge is over

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
