// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract IntroDevCont {
    uint simpanData;

    function set(uint x) public {
        simpanData = x;
    }

    function get() public view returns (uint){
        return simpanData;
    }
}