// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.9.0;

import "./GameItems.sol";

contract ItemMarket{

    GameItems gameItems;

    address _owner = gameItems.owner();

    uint rate = gameItems.getRate();
    uint GT = gameItems.getTokenId();

    event BuyNFT(address _buyer, uint _id);
    event BuyGT(address _buyer, uint _amount);

    constructor(address _user) {
        gameItems = GameItems(_user);
    }

    function buyNFT(uint _id) public {

        uint price = gameItems.getNFTPrice(_id);

        require(_id != GT, "You can only buy Items.");
        require(msg.sender != gameItems.owner(), "The owner can't buy GameItem!!!");
        require(gameItems.balanceOf(_owner, _id) == 1, "There is no Item you want!!!");
        require(gameItems.balanceOf(msg.sender, GT) > price, "You don't have enough GT.");

        emit BuyNFT(msg.sender, _id);

        gameItems.safeTransferFrom(_owner, msg.sender, _id, 1, "");
        gameItems.safeTransferFrom(msg.sender, _owner, GT, price, "");
    }

    function buyGT(uint _amount) public payable{
        
        require(msg.value == _amount * rate, "Incorrect!!!");
        
        emit BuyGT(msg.sender, _amount);

        gameItems.safeTransferFrom(_owner, msg.sender, GT, _amount, "");
        payable(_owner).transfer(msg.value);
    }
}