import { ethers } from "hardhat";

async function main() {
  let instance_basic_erc20 = await (await ethers.getContractFactory("BasicERC20")).deploy();
  console.log(`Address BasicERC20 Contract: ${await instance_basic_erc20.getAddress()}`);
  
  // let instance_oz_erc20 = await (await ethers.getContractFactory("OzERC20")).deploy();
  // console.log(`Address OzERC20 Contract: ${await instance_oz_erc20.getAddress()}`);
  
  // let instance_oz_erc20_custom = await (await ethers.getContractFactory("OzERC20Custom")).deploy("OZ Custom Token", "OZCT");
  // console.log(`Address OzERC20 Contract: ${await instance_oz_erc20_custom.getAddress()}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.

// Compiled 1 Solidity file successfully
// Address BasicERC20 Contract: 0xe002afe5A7cAAF06f0f5b01d2dA9D4B558B0Cb61
// 0x5B758668f10973c1dc6688e7457529B7559080AD
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
