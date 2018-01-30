pragma solidity ^0.4.16;

contract Loan {
    address _debtor;
    address _lender;
    uint loanAmount;
    uint interestRate;
    uint datePaid;
    
    enum State { New, Active, Declined, Paid, Default }
    State public state; 

    mapping(address => uint) public balances;

    modifier onlyLender() {
        require(msg.sender == _lender);
        _;
    }

    modifier onlyDebtor() {
        require(msg.sender == _debtor);
        _;
    }

    function Loan(address debtor, uint rate) public {
        _lender = msg.sender;
        _debtor = debtor;
        interestRate = rate;
    }

    function fund(address debtor) public payable onlyLender {
        loanAmount = msg.value;
        
        if (balances[msg.sender] < loanAmount) 
        return;
        
        _debtor = debtor; 
        balances[msg.sender] -= loanAmount;
        balances[debtor] += loanAmount;
        Funded(msg.sender, debtor, loanAmount);
    }

    function payOff(address lender, uint amount, uint date) public payable onlyDebtor {
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