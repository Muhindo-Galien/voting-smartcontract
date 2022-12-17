import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
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
  solidity: {
    compilers: [
        {
            version: "0.8.7",
        },
        {
            version: "0.4.24",
        },
    ],
}
};

export default config;
