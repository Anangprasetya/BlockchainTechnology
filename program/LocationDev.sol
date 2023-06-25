// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// lokasi data menentukan gas yang dipakai
// gas minimum

// storage (state)
// memory (local)
// call data
// stack

contract DataLocationCont {
    uint public angka1 = 10;
    uint public angka2 = 20;

    function kalkulasi(uint a, uint b) public pure returns (uint hsl){
        hsl = a + b;
    }

    // by value & by referense
    function ubahValue() public returns (uint r) {
        angka1 = angka2;
        angka2 = 30;

        r = angka1;
    }

    function ubahReference() public pure returns (uint[] memory, uint[] memory) {
        uint[] memory arr1 = new uint[](3);

        arr1[0] = 5;
        arr1[1] = 6;
        arr1[2] = 7;

        uint[] memory arr2 = arr1;
        arr1[0] = 10;

        return (arr1, arr2);
    }
}