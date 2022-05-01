const GameItems = artifacts.require("GameItems");
const ItemMarket = artifacts.require("ItemMarket")

module.exports = (deployer) => {
  deployer.deploy(GameItems).then(() => {
    const contract = GameItems.deployed();
    return deployer.deploy(ItemMarket, contract.address)
  })
};
