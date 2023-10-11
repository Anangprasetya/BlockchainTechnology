import { ethers } from "hardhat";

async function main() {
  const instance_nft_example = await ethers.deployContract("NftExample");
  await instance_nft_example.waitForDeployment();
  const addressNftExample = await instance_nft_example.getAddress();
  console.log(`NFT Example: ${addressNftExample}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


// NFT Example: 0x03960D31ffAE37AA0a7EC73e4F99a7cf69810d62