// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;
import "@openzeppelin/contracts/utils/Counters.sol";
import 'hardhat/console.sol';

// error isNotVotingOrganiser();

contract Create {
  using Counters for Counters.Counter;
  Counters.Counter public _voterId;
  Counters.Counter public _candidateId;

  address public votingOrganiser;


  // CANDITATE FOR VOTING
  struct Candidate{
    uint256 cantidateId;
    string age;
    string name;
    string image;
    uint256 voteCount;
    address _address;
    string ipfs;
  }
  event CantidateCreate(
     uint256 indexed cantidateId,
    string age,
    string name,
    string image,
    uint256 voteCount,
    address _address,
    string ipfs
  );

  address [] public canditatesAddress;
  mapping(address=> Candidate) public addressToCandidates;

  // ---------------VODTER VARIABLES

  address[] public votersVoters;

  address[] public votersAddress;
  mapping(address => Voter) public voters;

  struct Voter{
    uint256 voter_voterId;
    string voter_name;
    string voter_image;
    address voter_address;
    uint256 voter_allowed;
    bool voter_voted;
    uint256 voter_vote;
    string voter_ipfs;
  }

  event VoterCreated(
    uint256 voter_voterId,
    string voter_name,
    string voter_image,
    address voter_address,
    uint256 voter_allowed,
    bool voter_voted,
    uint256 voter_vote,
    string voter_ipfs

  );
 
    constructor(){
      votingOrganiser = msg.sender;
    }

  function addCanditate(address _address, string memory _age, string memory _name, string memory _image, string memory _ipfs)public{
    require(votingOrganiser == msg.sender, 'Only organizer can add a candidate');
    _candidateId.increment();
    uint256 idNumber = _candidateId.current();
    Candidate storage candidate = addressToCandidates[_address];

    candidate.age = _age;
    candidate.name = _name;
    candidate.image = _image;
    candidate.cantidateId = idNumber;
    candidate.voteCount = 0;
    candidate._address = _address;
    candidate.ipfs = _ipfs;

    canditatesAddress.push(_address);
    emit CantidateCreate(
      idNumber,
      _age,
      _name,
      _image,
      candidate.voteCount,
      _address,
      _ipfs
      );
    }


function getCandidate() public view returns(address [] memory){
  return canditatesAddress;
}
function getCandidateLength() public view returns(uint256){
  return canditatesAddress.length;
}

function getCandidateData(address _address) public view returns(string memory,string memory, uint256,string memory,uint256,string memory,address){
  return (
    addressToCandidates[_address].age,
    addressToCandidates[_address].name,
    addressToCandidates[_address].cantidateId,
    addressToCandidates[_address].image,
    addressToCandidates[_address].voteCount,
    addressToCandidates[_address].ipfs,
    addressToCandidates[_address]._address
  );
}

// -----VOTER SECTION

function voterRight(address _address, string memory _name, string memory _image, string memory _ipfs) public {
  require(votingOrganiser == msg.sender, 'Only organizer can add a candidate');
  _voterId.increment();
    uint256 idNumber = _voterId.current();
    Voter storage voter = voters[_address];
    require(voter.voter_allowed == 0);

    voter.voter_allowed = 1;
    voter.voter_name = _name;
    voter.voter_image = _image;
    voter.voter_ipfs = _ipfs;
    voter.voter_address = _address;
    voter.voter_voterId = idNumber;
    voter.voter_vote = 100;
    voter.voter_voted = false;
    voter.voter_ipfs = _ipfs;

    votersAddress.push(_address);
    emit VoterCreated(
      idNumber, 
      _name, 
      _image, 
      _address, 
      voter.voter_allowed, 
      voter.voter_voted, 
      voter.voter_vote , 
      _ipfs);
}

function vote( address _candidateAddress, uint256 _candidateVotedId) external{
  Voter storage voter = voters[msg.sender];
  require(!voter.voter_voted, "you have already voted");
  require(voter.voter_allowed !=0, "you have no right to vote");

  voter.voter_voted = true;
  voter.voter_vote  = _candidateVotedId;

  votersVoters.push(msg.sender);

  addressToCandidates[_candidateAddress].voteCount += voter.voter_allowed;

}

function getVotersLength() public view returns(uint256){
  return votersVoters.length;
}

function getVoterData( address _address) public view returns (
  uint256, 
  string memory, 
  string memory,
  address,
  string memory,
  uint256,
  bool
  ){
    return (
      voters[_address].voter_voterId,
      voters[_address].voter_name,
      voters[_address].voter_image,
      voters[_address].voter_address,
      voters[_address].voter_ipfs,
      voters[_address].voter_allowed,
      voters[_address].voter_voted
    );
  }

  function getVotedVoterList() public view returns (address [] memory){
    return votersVoters;
  }

  function getVoterList() public view returns(address [] memory){
    return votersAddress;
  }
}