const GameItems = artifacts.require("./GameItems.sol");

contract("GameItems", (accounts) => {
  
  before(async () => {
    let gameItems = await GameItems.new()
    
    gameItems.setRate(10**12).send()
    gameItems.createNFT("Hammer", 10)
  })

  it("...should store the value 89.", async () => {

    assert.equal(storedData, 89, "The value 89 was not stored.");
  });
});
