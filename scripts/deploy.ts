import { ethers } from "hardhat";

async function main() {
 

  const Create = await ethers.getContractFactory("Create");
  const create = await Create.deploy();

  await create.deployed();

  console.log(`Create contract deployed to ${create.address}`);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
