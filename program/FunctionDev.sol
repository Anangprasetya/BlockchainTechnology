// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract HelloFunctionCont {
    // pure -> return satu kali dan tanpa modifikasi variabel state
    uint hasil;

    function cetak() public pure returns (string memory){
        return "Hello Anang Nur Prasetya";
    }

    function tambah(uint a, uint b) public {
        hasil = a + b;
    }

    function ambil() public view returns(uint) {
        return hasil;
    }


    // menerima dana ether
    uint nominal;
    function terimaDana() public payable {
        nominal = msg.value;
    }

    function tampilDana() public view returns (uint) {
        return nominal;
    }

    // overload
    function tambah(uint a, uint b, uint c) public pure returns (uint hsl) {
        hsl = a + b + c;
    }
}