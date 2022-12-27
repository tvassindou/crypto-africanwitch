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

    function _createWitch(string _name, uint _dna) private {
        uint id = witches.push(Witch(_name, _dna)) - 1;
        NewWitch(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomWitch(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createWitch(_name, randDna);
    }

}
