pragma solidity ^0.5.0;

import "./Token.sol";

contract EthSwap {
  
  string public name = "EthSwap instant exchange";
  Token  public token;
  uint   public rate = 100;

  event TokenPurchased(
         address account,
         address token,
         uint amount,
         uint rate
  );

  event TokensSold(
         address account,
         address token,
         uint amount,
         uint rate
  );
  constructor(Token _token) public {
    token = _token;
  }

  
  function  buyTokens() public payable{
    
    uint tokenAmount = msg.value * rate;
    uint balance =  token.balanceOf(msg.sender);
    
    require( balance <= tokenAmount, "Insufficient funds to allow transfer" );
  
    token.transfer(msg.sender,tokenAmount);

    // emit event
    emit TokenPurchased(msg.sender,address(token),tokenAmount,rate);
    
  }

  function sellTokens(uint _amount) public{

    uint etherAmount = _amount / rate;

    token.transferFrom(msg.sender,address(this),_amount);
    msg.sender.transfer(etherAmount);
    
    emit TokensSold(msg.sender, address(token), _amount, rate);
  }
}