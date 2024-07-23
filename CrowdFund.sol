// SPDX-License-Identifier: MIT

//Contract for crowdfunding on the Ethereum blockchain

pragma solidity ^0.8.26;

//use a reentrancy guard contract for secure best practice
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract CrowdFund is ReentrancyGuard {
    //declare the owner of the contract
    //only the owner can withdraw the donated funds
    address public fundraiser;
    //declare a variable for the expiration date
    uint256 public expirationDate;

    //track two events
    //Donation are the funds from donors
    //Withdrawal is when the funds are withdrawn
    event Donation(address indexed _address, uint _value);
    event Withdrawal(address indexed _address, uint _value);

    //this is the mapping for donor balances
    mapping(address => uint) private balances;

    //Initialize the fundraiser, require no zero address, set expiration date to 30 days
    constructor() {
        require(msg.sender != address(0), "Fundraiser address cannot be zero");
        fundraiser = msg.sender;
        expirationDate = block.timestamp + 30 * 86400; // 30 days in seconds
    }

    //set the contract to receive funds
    //anyone can donate except for the fundraiser account as a rule
    //those who donate do not need to provide personal information
    //perform pre-checks to make sure payment is valid
    receive() external payable {
        require(
            block.timestamp <= expirationDate,
            "Fundraising period has ended"
        );
        require(msg.value > 0, "Invalid Amount");
        require(
            msg.sender != fundraiser,
            "Fundraiser not allowed to send funds"
        );
        balances[msg.sender] += msg.value;
        emit Donation(msg.sender, msg.value);
    }

    //check the balance of the contract
    //these are all the donations made
    function checkBalance() public view returns (uint) {
        return address(this).balance;
    }

    //check the balance of an individual donation
    //this is for users to check how much they have donated
    function checkMyBalance() public view returns (uint) {
        return balances[msg.sender];
    }

    //withdraw function with reentrancy guard
    //only the fundraiser is allowed to withdraw
    function withdrawAll() public nonReentrant {
        require(msg.sender == fundraiser, "Unauthorized Withdrawal");
        uint amount = address(this).balance;
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed.");
        emit Withdrawal(msg.sender, amount);
    }
}
