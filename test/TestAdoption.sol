pragma solidity >=0.5.16;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {
    //Address of the adoption contract to be tested
    Adoption adoption = Adoption(DeployedAddresses.Adoption());

    //id of pet that will be tested
    uint expectedPetId = 8;

    //owner of the adopted pet
    address expectedAdopter = address(this);

    //testing the adopt() function
    function testUserCanAdoptPet() public {
        uint returnedId = adoption.adopt(expectedPetId);

        Assert.equal(returnedId, expectedPetId, "Adoption of the expected pet should match what is returned.");
    }

    //testing the retrieval of a single pet's owner
    function testGetAdopterAddressByPetId() public {
        address adopter = adoption.adopters(expectedPetId);

        Assert.equal(adopter, expectedAdopter, "Owner of the expected pet should be in this contract.");
    }

    //testing the retrievl of all pet owners
    function testGetAdopterAddressByPetIdInArray() public {
        //store adopters in memory rather than contract's storage
        address[16] memory adopters = adoption.getAdopters();

        Assert.equal(adopters[expectedPetId], expectedAdopter, "Owner of the expected pet should be in this contract.");
    }
}