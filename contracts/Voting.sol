// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        string name;
        string ipfsHash;
        uint voteCount;
    }

    address public chairperson;
    bool public electionStarted;
    bool public electionEnded;

    Candidate[] public candidates;
    mapping(address => bool) public voters;

    constructor() {
        chairperson = msg.sender;
        electionStarted = false;
        electionEnded = false;
    }

    modifier onlyChairperson() {
        require(msg.sender == chairperson, "Only chairperson can call this function");
        _;
    }

    modifier onlyDuringElection() {
        require(electionStarted && !electionEnded, "Election is not active");
        _;
    }

    function startElection() public onlyChairperson {
        require(!electionStarted, "Election already started");
        electionStarted = true;
        electionEnded = false;
    }

    function endElection() public onlyChairperson {
        require(electionStarted, "Election has not started");
        electionStarted = false;
        electionEnded = true;
    }

    function addCandidate(string memory name, string memory ipfsHash) public onlyChairperson {
        candidates.push(Candidate({
            name: name,
            ipfsHash: ipfsHash,
            voteCount: 0
        }));
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    function vote(uint candidateIndex) public onlyDuringElection {
        require(!voters[msg.sender], "You have already voted");
        voters[msg.sender] = true;
        candidates[candidateIndex].voteCount += 1;
    }

    function removeCandidate(uint index) public onlyChairperson {
        require(index < candidates.length, "Invalid candidate index");
        candidates[index] = candidates[candidates.length - 1];
        candidates.pop();
    }
}
