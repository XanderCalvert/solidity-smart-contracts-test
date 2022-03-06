// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    // solidity events
    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver; // user who waved
        string message; // user message
        uint256 timestamp; // timestamp of message
    }

    // array to hold all the waves;
    Wave[] waves;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart");
    }

    // wave() now requires a message
    function wave(string memory _message) public {
        totalWaves += 1; //Increase waves by 1
        console.log("%s has waved!", msg.sender, _message);

        // push to the array
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // emit the event
        emit NewWave(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to widthdraw more money than the contract has."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    // returns the array
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves); // Logs the total ammount of waves
        return totalWaves;
    }
}
