// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    // seed number
    uint256 private seed;

    // solidity events
    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver; // user who waved
        string message; // user message
        uint256 timestamp; // timestamp of message
    }

    // array to hold all the waves;
    Wave[] waves;

    //map addresses
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart");

        // init seed
        seed = (block.timestamp + block.difficulty) % 100;
    }

    // wave() now requires a message
    function wave(string memory _message) public {
        //wait 15mins
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15 mins"
        );

        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1; //Increase waves by 1
        console.log("%s has waved!", msg.sender, _message);

        // push to the array
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // generate new seed
        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random number: %d", seed);

        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to widthdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        // emit the event
        emit NewWave(msg.sender, block.timestamp, _message);
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
