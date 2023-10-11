// Layout contract elements in the following order:

// Pragma statements

// Import statements

// Interfaces

// Libraries

// Contracts

// Inside each contract, library or interface, use the following order:

// Type declarations

// State variables

// Events

// Modifiers

// Functions

// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

/**
 * @title A sample Raffle Contract
 * @author Mavis
 * @notice This contract is for creating a sample raffle
 * @dev Implements Chainlink VRFv2
 */
contract Raffle {
    error Raffle__NotEnoughEthSent();

    uint256 private immutable i_entranceFee;
    // @dev Duration of the lottery in seconds
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    /** Events */
    event EnteredRaffle(address indexed player);

    // What data structure should we use? How to keep track of all the players?

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
        // require(msg.value >= i_entranceFee, "Not enouth ETH sent!");
        if (msg.value <= i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }
        s_players.push(payable(msg.sender));
        // event 的作用
        // 1. Makes migration easier 使合约迁移更方便
        // 2. Makes front end "indexing" easier 方便前后端进行索引
        emit EnteredRaffle(msg.sender);
    }

    // 1. Get a random number
    // 2. Use the random number to pick a player
    // 3. Be automatically called
    function pickWinner() external {
        // check to see if enouth time has passed
        // 1000 - 500 = 500. 600 seconds
        // 1200 - 500 = 700. 600 seconds
        if ((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert();
        }
    }

    /** Getter Function */
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
