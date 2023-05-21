// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract VariabelTypesCont {
    uint angka;

    function tambah(uint x, uint y) public {
        uint tmp = x + y;
        angka = tmp;
    }

    function ambil() public view returns (uint){
        return angka;
    }
}

contract VariabelTypesContPart2 {
    bool public valid = true;

    int32 public angka1 = -43;
    uint public angka2 = 20;

    uint public cek_float = 2.5 + 1.5;

    //bytes 1-32
    bytes public huruf1 = "A";
    string public kalimat = "Hello Anangprasetya";

    // enum
    enum hari {
        Senin, Selasa, Rabu, Kamis, Jumat, Sabtu, Minggu
    }

    function ambilHari() public pure returns (hari){
        return hari.Selasa; // return index
    }
}