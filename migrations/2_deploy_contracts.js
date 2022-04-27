var GameItems = artifacts.require("./GameItems.sol");
var ItemMarket = artifacts.require("./ItemMarket.sol");

module.exports = deployer => {
  deployer.deploy(GameItems);
  deployer.deploy(ItemMarket);
};
