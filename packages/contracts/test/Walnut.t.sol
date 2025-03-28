// SPDX-License-Identifier: MIT License
pragma solidity ^0.8.13;

contract Walnut {
    uint256 private secretNumber;
    uint256 private shellStrength;
    bool private isCracked;
    uint256 private currentRound;
    
    // Track contributors for each round
    mapping(uint256 => mapping(address => bool)) private contributors;
    // Track shake counts per contributor per round
    mapping(uint256 => mapping(address => uint256)) private shakeCounts;
    
    event WalnutCracked(uint256 round, address crackedBy);
    event WalnutShaken(uint256 round, address shakenBy, uint256 amount);
    event WalnutHit(uint256 round, address hitBy);
    event WalnutReset(uint256 newRound);

    constructor(uint256 initialShellStrength) {
        shellStrength = initialShellStrength;
        currentRound = 1;
    }

    modifier onlyContributor() {
        require(contributors[currentRound][msg.sender], "NOT_A_CONTRIBUTOR");
        _;
    }

    modifier onlyWhenCracked() {
        require(isCracked, "SHELL_INTACT");
        _;
    }

    modifier onlyWhenIntact() {
        require(!isCracked, "SHELL_ALREADY_CRACKED");
        _;
    }

    function hit() external onlyWhenIntact {
        shellStrength--;
        contributors[currentRound][msg.sender] = true;
        
        emit WalnutHit(currentRound, msg.sender);
        
        if (shellStrength == 0) {
            isCracked = true;
            emit WalnutCracked(currentRound, msg.sender);
        }
    }

    function shake(uint256 amount) external onlyWhenIntact {
        secretNumber += amount;
        contributors[currentRound][msg.sender] = true;
        shakeCounts[currentRound][msg.sender] += amount;
        
        emit WalnutShaken(currentRound, msg.sender, amount);
    }

    function look() external view onlyContributor onlyWhenCracked returns (uint256) {
        return secretNumber;
    }

    function reset() external onlyWhenCracked {
        // Only allow reset by someone who contributed to cracking
        require(contributors[currentRound][msg.sender], "NOT_A_CRACKER");
        
        shellStrength = 2;
        isCracked = false;
        currentRound++;
        
        emit WalnutReset(currentRound);
    }

    // New function to get current round
    function getCurrentRound() external view returns (uint256) {
        return currentRound;
    }

    // New function to check if caller is contributor in current round
    function isContributor() external view returns (bool) {
        return contributors[currentRound][msg.sender];
    }

    // New function to get shake count for current contributor
    function getMyShakeCount() external view returns (uint256) {
        return shakeCounts[currentRound][msg.sender];
    }

    // New function to get shell status
    function getShellStatus() external view returns (bool) {
        return isCracked;
    }

    // New function to get remaining shell strength
    function getShellStrength() external view returns (uint256) {
        return shellStrength;
    }
}
