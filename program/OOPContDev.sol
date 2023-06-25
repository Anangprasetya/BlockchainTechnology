// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Induk {
    uint private data;
    string public info;

    constructor() {
        info = "Hello Anang";
    }

    function increment(uint a) private pure returns (uint) {
        return a + 1;
    }

    function setIncrement() public pure returns (uint){
        return increment(3);
    }

    function updateData(uint a) public {
        data = a;
    }

    function getData() public view returns (uint) {
        return  data;
    }

    function compute(uint a, uint b) internal pure returns (uint) {
        return a+b;
    }
}


contract LuarClass {
    function readData() public returns (uint) {
        Induk indk = new Induk();
        indk.updateData(10);
        return indk.getData();
    }
}

contract Turunan is Induk {
    uint private result;
    Induk private c;

    constructor() {
        c = new Induk();
    }

    function getCompute() public {
        result = compute(3, 9);
    }

    function getResult() public view returns (uint) {
        return result;
    }

    function getDataBaru () public view returns (string memory) {
        return c.info();
    }
}