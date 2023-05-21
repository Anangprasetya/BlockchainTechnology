// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract TipeStructCont {
    struct User {
        string nama;
        uint usia;
        bool status;
    }

    User anang;

    function addUser(string memory nama, uint usia, bool status) public {
        anang = User(nama, usia, status);
    }

    function cetak() public view returns (string memory, uint, bool) {
        return (anang.nama, anang.usia, anang.status);
    }

    User[] data;

    function addArrData(string memory nama, uint usia, bool status) public {
        User memory tmp = User(nama, usia, status);
        data.push(tmp);
    }

    function cetakArrData(uint idx) public view returns (string memory, uint, bool){
        User storage tmp = data[idx];
        return (tmp.nama, tmp.usia, tmp.status);
    }
}