//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Lottery{
    address public manager;
    address payable[] public participants;
    address [] public winnersList;


    constructor()
    {
        // gives the address of the entity contacting with the contract
        manager = msg.sender; //global variable
    }

    receive() external payable
    {
        // require statement fulfill if else purpose
        require(msg.value == 1 ether);
        participants.push(payable(msg.sender));
    }
    function getBalance() public view returns(uint)
    {
        require(msg.sender == manager);
        return address(this).balance;
    }
    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));  
    }
    function selectWinner() public
    {
        require(msg.sender == manager);
        require(participants.length>=3);
        // calling random function
        uint r = random();
        // whenever we apply % infront of a value it return a remainder of that number
        // for eg: 19%10 = 9 so the special thing about remaider is the answer will 
        // always be lower than the value on right of the % i.e. 10 in this case
        // here we are dividing the array length to a random integer so it will give
        // a number smaller than the length of our array 
        address payable winner;
        uint index = r % participants.length;
        winner = participants[index];
        winnersList.push(winner);
        winner.transfer(getBalance()-1 ether);
        // resetting the dynamic array
        participants = new address payable[](0);
    }
    function lenPar() public view returns(uint256){
        uint256 x = participants.length;
        return x;
    }
    
    
}