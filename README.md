# CrowdFund

A crowdfunding contract with a time period

The CrowdFund contract is for fundraising on the Ethereum blockchain. It has a set time period of 30 days (can be modified in code only).

There is a fundraiser account that serves as the owner. Only this account can withdraw funds from the funds collected.

A reentrancy guard is implemented using OpenZeppelin. This is to ensure security for the contract.

Contract address of deployed contract on Sepolia test network:
0x3A320694D215de10ff06a65eA9775eBE1b527ce4
