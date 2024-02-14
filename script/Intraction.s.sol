// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Raffle} from "../src/Raffle.sol";
import {Script, console} from "lib/forge-std/src/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {VRFCoordinatorV2Mock} from "@chainlink/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";

contract CreateSubscription is Script {
    function CreateSubscriptionUsingConfig() public returns (uint64) {
        HelperConfig helperConfig = new HelperConfig();
        (, , address vrfCoordinator, , , ) = helperConfig.activeNetworkConfig();

        return createSubscription(vrfCoordinator);
    }

    function createSubscription(
        address vrfCoordinator
    ) public returns (uint64) {
        console.log("Creating Subscribtion on ChainId", block.chainid);
        vm.startBroadcast();
        uint64 subid = VRFCoordinatorV2Mock(vrfCoordinator)
            .createSubscription();

        vm.stopBroadcast();
        console.log("Subscription Created with id", subid);
        console.log(" Please update in HelperConfig.s.sol file");
        return subid;
    }

    function run() external returns (uint64) {
        return CreateSubscriptionUsingConfig();
    }
}
