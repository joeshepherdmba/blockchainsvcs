pragma solidity ^0.4.16;

contract Loan {
    enum State { New, Active, Declined, Paid, Default }
    address debtor;
    address lender;
    uint loanAmount;
    uint interestRate;
    uint months;
    State public state; 

    function CreateLoan(address debtor, address lender, uint amount) public payable {
        debtor = debtor; 
        lender = lender;
        loanAmount = amount;
    }

    event LoanApproved();
    event PaidInFull();
    event Defaulted();
    event Declined();
}
// set terms

// transfer funds

// accept payment

// close loan