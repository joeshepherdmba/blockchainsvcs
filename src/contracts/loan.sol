pragma solidity ^0.4.16;

contract Loan {
    enum State { New, Active, Declined, Paid, Default }
    address _debtor;
    uint loanAmount;
    uint interestRate;
    uint datePaid;
    State public state; 

    mapping(address => uint) public balances;

    function createLoan(address debtor, uint amount) public payable {
        if (balances[msg.sender] < amount) 
        return;
        
        _debtor = debtor; 
        balances[msg.sender] -= amount;
        balances[debtor] += amount;
        Funded(msg.sender, debtor, amount);
    }

    function payOff(address lender, uint amount, uint date) public payable {
        if (balances[msg.sender] < amount) 
        return;
        
        balances[msg.sender] -= amount;
        balances[lender] += amount;
        PaidInFull(msg.sender, lender, amount, date);
    }

    event Funded(address lender, address debtor, uint amount);
    event PaidInFull(address debtor, address lender, uint amount, uint datePaid);
    event Defaulted();
}
// set terms

// transfer funds

// accept payment

// close loan