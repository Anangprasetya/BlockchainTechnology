import { ethers } from "hardhat";

async function main() {
  const instance_token_example = await ethers.deployContract("TokenExample");
  await instance_token_example.waitForDeployment();
  const addressTokenExample = await instance_token_example.getAddress();
  console.log(`Token Example: ${addressTokenExample}`);
  
  const instance_token_payment = await ethers.deployContract("TokenPayment");
  await instance_token_payment.waitForDeployment();
  console.log(`Token Payment: ${await instance_token_payment.getAddress()}`);
  const setAllowedTokenPayment = await instance_token_payment.setAllowedPayment(addressTokenExample, true);
  console.log('Set Allowed Token Payment: ', setAllowedTokenPayment.hash);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


// Token Example: 0x51e29C05AE499B3e3ae2Cd2669E991FE033E2b9A
// Token Payment: 0x7b44F592E7BE5a38b2A7ECCF5eC009De0e6eba46
// Set Allowed Token Payment:  0x17473b4e3ed9045f9521284c9c677bbc845ddd5ef1f9df1aff64c2ece2ed193b




// Token Example: 0xB13B4381830E3Afb3A9CA7A1aA44CfaB35F66049
// Token Payment: 0xec9523aeCdD7Dd82cbBdb4e60Fa82c10BB05e4eD
// Set Allowed Token Payment:  0x6541d3e0d94fa0b84409b2dfa8b173415a3a6f36ca4fb41f88c8dd4648a208ed



// Token Example: 0x1a1b296ba15DaF6f2CC91D173aF1dbD7cE1723EA
// Token Payment: 0x6f38dFA8563B32325eDE9dcF48AaCBbD318d9459
// Set Allowed Token Payment:  0x3513a69bd5682e63226aa16cb72617dab9428e9513fae6448ff8e4686f29dad2