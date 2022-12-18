import { HardhatUserConfig } from "hardhat/config";
// import "@nomicfoundation/hardhat-toolbox";
import "@typechain/hardhat"
import "@nomiclabs/hardhat-waffle"
import "@nomiclabs/hardhat-etherscan"
import "@nomiclabs/hardhat-ethers"
import "hardhat-gas-reporter"
import "dotenv/config"
import "solidity-coverage"
import "hardhat-deploy"


const GOERLI_RPC_URL =
    process.env.GOERLI_RPC_URL || "https://eth-rinkeby.alchemyapi.io/v2/your-api-key"
const PRIVATE_KEY = process.env.PRIVATE_KEY

const config: HardhatUserConfig = {
  
  defaultNetwork: "hardhat",
  networks:{
    hardhat:{
      chainId:31337
    },
    localhost:{
      chainId:31337
    },
    goerli: {
      url: GOERLI_RPC_URL,
      accounts: PRIVATE_KEY !== undefined ? [PRIVATE_KEY] : [],
      chainId: 5,
  },
  },
  namedAccounts: {
    deployer: {
        default: 0, // here this will by default take the first account as deployer
         //1: 0, similarly on mainnet it will take the first account as deployer. Note though that depending on how hardhat network are configured, the account 0 on one network can be different than on another
    },},
  solidity: {
    compilers: [
        {
            version: "0.8.9",
        },
        {
            version: "0.4.24",
        },
    ],
}
};

export default config;
