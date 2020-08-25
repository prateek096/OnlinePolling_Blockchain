pragma solidity 0.4.25;

contract Election {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    // Store accounts that voted
    mapping(address => bool) public voters;

    // Store Candidates
    mapping(uint => Candidate) public candidates;

    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
        addCandidate("Candidate 3");
    }

    function addCandidate (string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        //they haven't voted before
        require(!voters[msg.sender]);

        //valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record voter that voted
        voters[msg.sender] = true;

        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}
