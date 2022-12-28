pragma solidity ^0.4.19;
//SPDX-License-Identifier: UNLICENSED

contract WitchFactory {

    event NewWitch(uint witchId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Witch {
        string name;
        uint dna;
    }

    Witch[] public witches;

    mapping (uint => address) public witchToOwner;
    mapping (address => uint) ownerWitchCount;

    function _createWitch(string _name, uint _dna) internal {
        uint id = witches.push(Witch(_name, _dna)) - 1;
        witchToOwner[id] = msg.sender;
        ownerWitchCount[msg.sender]++;
        NewWitch(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomWitch(string _name) public {
        require(ownerWitchCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createWitch(_name, randDna);
    }

}
