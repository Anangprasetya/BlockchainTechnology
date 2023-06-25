// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract MappingCont {
    mapping (address => uint) public myMap;

    function set(address addr, uint x) public {
        myMap[addr] = x;
    }

    function get(address addr) public view returns (uint) {
        return myMap[addr];
    }
}

contract MappingBersarangCont {
    mapping (address => mapping (uint => bool)) public myMap;

    function set(address addr, uint x, bool val) public {
        myMap[addr][x] = val;
    }

    function get(address addr, uint x) public view  returns (bool) {
        return myMap[addr][x];
    }
}