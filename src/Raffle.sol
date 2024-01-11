// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

/**
 * @title Raffle contract
 * @author Azan Adnan
 * @notice This contract is used to create a raffle
 * @dev Implements Chainlink VRF
 */

contract Raffle {
    error Raffle_NotEnoughEthSend();

    /** State Variables */
    uint256 private immutable i_entranceFee;
    uint256 private immutable i_Interval;
    address payable[] private s_players;

    /** Events */
    event EnterRaffle(address indexed _player);

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_Interval = interval;
    }

    function enterRaffle() external payable {
        if (msg.value < i_entranceFee) {
            revert Raffle_NotEnoughEthSend();
        }
        s_players.push(payable(msg.sender));
        emit EnterRaffle(msg.sender);
    }

    function pickWinner() public {}

    /** Getter Functions */

    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }
}
