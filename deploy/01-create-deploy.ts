import { developmentChains,} from "../helper-hardhat-config"
import verify from "../utils/verify"
import {DeployFunction} from "hardhat-deploy/types"
import {HardhatRuntimeEnvironment} from "hardhat/types"

const deployCreate: DeployFunction = async function (
  hre: HardhatRuntimeEnvironment
){
  const { deployments, getNamedAccounts, network } = hre
  const { deploy, log } = deployments
  const { deployer } = await getNamedAccounts()

  log("----------------------------------------------------")
  const args: any[]= []
  const createContract = await deploy("Create", {
    from:deployer,
    args:args,
    log:true
  })
  // Verify the deployment
  if (!developmentChains.includes(network.name) && process.env.ETHERSCAN_API_KEY) {
    log("Verifying...")
    await verify(createContract.address, args)
}
log("----------------------------------------------------")

}

export default deployCreate