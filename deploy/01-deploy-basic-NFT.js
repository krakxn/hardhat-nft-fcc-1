const { network } = require("hardhat")
const { develompentChains } = require("../helper-hardhat-config")
const { verify } = require("../utils/verify")

module.exports = async ({ getNamedAccounts, deployments }) => {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    log("---------------------------------------------")
    const args = [] //does not take any constructor
    const basicNft = await deploy("BasicNft", {
        from: deployer,
        args: args,
        logs: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })

    if (
        !develompentChains.includes(network.name) &&
        process.env.ETHERSCAN_API_KEY
    ) {
        log("Verifyin....!")
        await verify(basicNft.address, args)
    }
    log("------------------------------------------")
}
