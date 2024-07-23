# CrowdFund

A crowdfunding contract with a time period

The CrowdFund contract is for fundraising on the Ethereum blockchain. It has a set time period of 30 days (can be modified in code only).

There is a fundraiser account that serves as the owner. Only this account can withdraw funds from the funds collected.

A reentrancy guard is implemented using OpenZeppelin. This is to ensure security for the contract.
