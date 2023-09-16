// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

contract DeadMansSwitch {
    address public sendAddress;  //pre determined address
    address public contractOwnerAddress;  
    uint lastActiveBlock;

    event fundsTransferred(address _from, address _to, uint amount); //funds transferred 
    
    modifier ownerVerification() {   
        require(msg.sender == contractOwnerAddress);
        _;
    }

    constructor(address _sendAddress) {    
        contractOwnerAddress = msg.sender;
        sendAddress = _sendAddress;
        lastActiveBlock = block.number;
    }
 
    function still_alive() external ownerVerification {
        lastActiveBlock = block.number;
    }


    function transferFunds() external payable ownerVerification {
        require(block.number - lastActiveBlock > 10);
        uint balance = address(this).balance;
        payable(sendAddress).transfer(balance);
        emit fundsTransferred(contractOwnerAddress, sendAddress, balance);
    }
    
    /* function checkBalance() public view returns (uint) {
        return (address(this).balance);
    } */

    // recieve and fallback are functions to receive ether 

    receive() external payable {

    }
    
    fallback() external payable {

    }

  
    /* function checkbalance() public view returns (uint, uint , uint, uint, address, address) {
        return (address(this).balance, contractOwnerAddress.balance ,(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db).balance, lastActiveBlock, contractOwnerAddress, address(this));
    } */

}