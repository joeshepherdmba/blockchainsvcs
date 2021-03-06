pragma solidity ^0.4.2;

contract Loan {
    address _debtor;
    address _lender;
    uint loanAmount;
    uint interestRate;
    uint datePaid;
    
    enum State { New, Active, Declined, Paid, Default }
    State public state; 

    // Track Debtor loan amounts 
    mapping(address => uint) loanBalances;

    // Set up new loan
    function Loan(address debtor, uint rate) public {
        _lender = msg.sender;
        _debtor = debtor;
        interestRate = rate;
        New(_lender, _debtor, interestRate);
    }

    /*
     Modifiers
    */

    // Require Lender is sender
    modifier onlyLender() {
        require(msg.sender == _lender);
        _;
    }
    
    // Require Debtor is sender
    modifier onlyDebtor() {
        require(msg.sender == _debtor);
        _;
    }

    modifier inState(State _state) {
        require(state == _state);
        _;
    }

    /*
     Events
    */

    event New(address lender, address debtor, uint rate);
    event Funded(address lender, address debtor, uint amount);
    event PaidInFull(address debtor, address lender, uint amount, uint datePaid);
    event PaymentMade(address debtor, address lender, uint amount, uint datePaid, uint balance);
    event Defaulted();

        // Fund new loan
    function fund(address debtor) public payable onlyLender {
        loanAmount = msg.value;
  
        _debtor = debtor; 

        _debtor.transfer(loanAmount);
        loanBalances[_debtor] += loanAmount;

        Funded(msg.sender, debtor, loanAmount);
    }

    // Make payment
    function makePayment(address lender, uint date) public payable onlyDebtor {
        _lender.transfer(msg.value);
        loanBalances[_debtor] -= loanAmount;

        if (loanBalances[_debtor] == 0) {
            PaidInFull(msg.sender, lender, msg.value, date);
        } else {
            PaymentMade(msg.sender, lender, msg.value, date, loanBalances[_debtor]);
        }
    }

    // Subcurrency Example: http://solidity.readthedocs.io/en/develop/introduction-to-smart-contracts.html?highlight=mappings
    // Bank Walkthrough: https://learnxinyminutes.com/docs/solidity/
}