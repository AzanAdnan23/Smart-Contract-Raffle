// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LotteryFoundry {
    address public owner;
    uint256 public ticketPrice;
    uint256 public totalTickets;
    uint256 public totalAmount;
    uint256 public winningTicket;
    bool public isLotteryOpen;

    mapping(address => uint256) public tickets;

    event LotteryOpened(uint256 ticketPrice, uint256 totalTickets);
    event LotteryClosed(uint256 winningTicket);
    event TicketPurchased(address indexed buyer, uint256 ticketNumber);

    constructor(uint256 _ticketPrice, uint256 _totalTickets) {
        owner = msg.sender;
        ticketPrice = _ticketPrice;
        totalTickets = _totalTickets;
        isLotteryOpen = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function openLottery() external onlyOwner {
        require(!isLotteryOpen, "Lottery is already open");
        isLotteryOpen = true;
        emit LotteryOpened(ticketPrice, totalTickets);
    }

    function closeLottery(uint256 _winningTicket) external onlyOwner {
        require(isLotteryOpen, "Lottery is not open");
        require(
            _winningTicket > 0 && _winningTicket <= totalTickets,
            "Invalid winning ticket number"
        );
        winningTicket = _winningTicket;
        isLotteryOpen = false;
        emit LotteryClosed(winningTicket);
    }

    function purchaseTicket(uint256 _ticketNumber) external payable {
        require(isLotteryOpen, "Lottery is not open");
        require(msg.value == ticketPrice, "Incorrect ticket price");
        require(
            _ticketNumber > 0 && _ticketNumber <= totalTickets,
            "Invalid ticket number"
        );
        require(
            tickets[msg.sender] == 0,
            "You have already purchased a ticket"
        );

        tickets[msg.sender] = _ticketNumber;
        totalAmount += msg.value;

        emit TicketPurchased(msg.sender, _ticketNumber);
    }

    function getTicketNumber(address _buyer) external view returns (uint256) {
        return tickets[_buyer];
    }
}
