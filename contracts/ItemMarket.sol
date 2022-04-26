// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.9.0;

import "./GameItems.sol";

contract ItemMarket is GameItems{
    
    function buyNFT(address _buyer, uint _id) public {
        require(balanceOf(_buyer, GT) > tokenPrice[_id], "You don't have enough token.");
        safeTransferFrom(owner(), _buyer, _id, 1, "");
    }

    function buyGT(address _buyer, uint _amount) public{
        require(_buyer.balance >= _amount * rate);
        _buyer.send();
    }
}