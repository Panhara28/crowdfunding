// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Crowdingfund{
    address public projectOwner;
    uint256 public fundGoal = 10 ether;
    uint256 public fundRaised = 0;
    uint256 public dealine;
    bool public crowdfundCompleted=false;
    address public contributor;

    address[] public contributors;

    mapping(address => uint256) public contributions;

    modifier onlyOwner(){
        require(msg.sender == projectOwner, "Only the project owner can call this function");
        _;
    }

    constructor(uint256 _duration){
        projectOwner = msg.sender;
        fundGoal = fundGoal;
        dealine = block.timestamp + _duration;
        crowdfundCompleted= false;
        fundRaised = fundRaised;
    }
    
    /**
     * @dev This function allows a user to contribute to the crowdfunding contract. 
     * The value sent along with the transaction becomes part of the total amount raised by the project owner.
     * If the current timestamp is greater than the deadline, it sets `crowdfundCompleted` to true.
     */
    function contribute() public payable  {

        if(contributions[msg.sender] == 0){
            contributors.push(msg.sender);
        }

        contributions[msg.sender] += msg.value;

        fundRaised += msg.value;

        if(fundRaised >= fundGoal){
            crowdfundCompleted=true;
        }
    }

    function getAllContributes() public onlyOwner view returns(address[] memory) {
        return contributors;
    }

}