// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    address[] addressArray; // Adress array

    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }

    function wave() public {
        totalWaves += 1; //Increase waves by 1
        console.log("%s has waved!", msg.sender);
        // addressArray.push(msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves); // Logs the total ammount of waves
        return totalWaves;
    }

    // function arrayAddressWavers() public view returns (address[]) {
    //     // console.log("Here is my array of data", addressArray);
    //     return addressArray;
    // }
}
