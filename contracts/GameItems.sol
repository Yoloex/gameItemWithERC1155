// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.9.0;

import "openzeppelin-solidity/contracts/token/ERC1155/ERC1155.sol";
import "openzeppelin-solidity/contracts/access/AccessControl.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";

contract GameItems is ERC1155, Ownable{
    
    uint public constant GT = 0;
    uint public rate; // This is used for exchanging ETH with GT token. It's the amount of Wei per GT. 
    uint public tokenNum;
    uint public decimal;

    mapping(uint => uint) public tokenPrice;
    mapping(string => uint) public nameToId;
    mapping (string => bool) public tokenExist;

    constructor () {
        _mint(msg.sender, GT, 10**8, "");
        rate = 10**13;
        decimal = 2;
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC1155) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function changeRate(uint _rate) public onlyOwner {
        rate = _rate;
    }

    function createNFT(string memory _name, uint _price) public onlyOwner returns(uint){
        require(tokenExist[_name] == false);
        tokenNum ++;
        tokenPrice[tokenNum] = _price;
        nameToId[_name] = tokenNum;
        tokenExist[_name] = true;
        _mint(msg.sender, tokenNum, 1, "");
        return tokenNum;
    }

    function buyNFT(uint _id) public {
        require(_id != GT, "You can only buy Items.");
        require(balanceOf(owner(), _id) == 1, "There is no Item you want!!!");
        require(balanceOf(msg.sender, GT) > tokenPrice[_id], "You don't have enough GT.");
        safeTransferFrom(owner(), msg.sender, _id, 1, "");
    }

    function buyGT(uint _amount) public{
        require(msg.value == _amount * rate, "Incorrect!!!");
        safeTransferFrom(owner(), msg.sender, GT, _amount, "");
    }


}