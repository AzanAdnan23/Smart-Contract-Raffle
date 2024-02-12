//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Raffle} from "../../src/Raffle.sol";
import {Test} from "../../lib/forge-std/src/Test.sol";
import {DeployRaffle} from "../../script/DeployRaffle.s.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";

contract RaffleTest is Test {
    //
    Raffle raffle;
    address public Player = makeAddr("Azan");
    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() external {
        DeployRaffle deployer = new DeployRaffle();

        raffle = deployer.run();
    }
}
