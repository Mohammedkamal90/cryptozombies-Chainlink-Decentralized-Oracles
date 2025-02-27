pragma solidity ^0.6.6;
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";

// 1. Have our `ZombieFactory` contract inherit from the `VRFConsumerBase` contract
contract ZombieFactory is VRFConsumerBase {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    // 2. Create a constructor
    constructor() VRFConsumerBase (0x6168499c0cFfCaCD319c818142124B7A15E857ab,
        0x01BE23585060835E02B77ef475b0Cc51aA1e0709) public {}

    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

    function _generatePseudoRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

}
