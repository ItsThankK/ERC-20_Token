// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract learnableToken {

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

    string public constant name = "Learnable'22 Token";
    string public constant symbol = "LBT";
    uint8 public constant decimals = 18;

    mapping(address => uint256) balances;

    mapping(address => mapping (address => uint256)) allowed;

    uint256 totalSupply_;

    constructor(uint256 total) {
      totalSupply_ = total;
      balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public view returns (uint256) {
      return totalSupply_;
    }

    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint numOfTokens) public returns (bool) {
        require(numOfTokens <= balances[msg.sender]);
        balances[msg.sender] -= numOfTokens;
        balances[receiver] += numOfTokens;
        emit Transfer(msg.sender, receiver, numOfTokens);
        return true;
    }

    function approve(address delegate, uint numOfTokens) public returns (bool) {
        allowed[msg.sender][delegate] = numOfTokens;
        emit Approval(msg.sender, delegate, numOfTokens);
        return true;
    }

    function allowance(address owner, address delegate) public view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint numOfTokens) public returns (bool) {
        require(numOfTokens <= balances[owner]);
        require(numOfTokens <= allowed[owner][msg.sender]);

        balances[owner] -= numOfTokens;
        allowed[owner][msg.sender] -= numOfTokens;
        balances[buyer] += numOfTokens;
        emit Transfer(owner, buyer, numOfTokens);
        return true;
    }
}