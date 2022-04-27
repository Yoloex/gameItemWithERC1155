var GameItems = artifacts.require("./GameItems.sol");

module.exports = deployer => {
  deployer.deploy(GameItems);
};
