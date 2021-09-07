//SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Coin{
    
    address public owner;
    mapping (address => uint) public balances;
    
    constructor(){
        owner = msg.sender;
    }
    
    function addBalanceByOwner(address _receiver, uint _amount) public {
        require(msg.sender == owner);
        balances[_receiver]+=_amount;
    }
    
    event Sent(address from, address to, uint amount);
    error InsufficientBalance(uint requested, uint available);
    
    function sendMoney(address  _receiver, uint _amount)public{
        if(balances[msg.sender]<_amount) 
         revert InsufficientBalance({requested: _amount, available: balances[msg.sender]});
         
         balances[msg.sender] -= _amount;
         balances[_receiver] += _amount;
         
         emit Sent(msg.sender, _receiver, _amount);
    }
    
    
    
}