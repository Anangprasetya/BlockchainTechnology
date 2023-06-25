// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract ArrayTypeCont {
    // array statis & dinamis

    uint[5] usia;

    function ambilData() public pure returns (uint) {
        uint[5] memory arr1 = [uint(50), 60, 70, 80, 90];
        return arr1[1];
    }

    function ambilUsia() public returns (uint) {
        usia = [uint(3), 5, 9, 7, 6];
        return usia[3];
    }

    function tampilUsia(uint x) public view returns (uint) {
        return usia[x];
    }
}

contract ArrayDinamis {
    uint[] data;

    // uint[] databaru;
    function ambilData() public returns (uint[] memory) {
        data = [20, 30, 40, 50, 60];
        return data;
    }

    function perbaruiSize(uint x) public returns (uint[] memory) {
        uint[] memory tmp = new uint[](x); // bisa memperbarui ukuran, tapi data array hilang
        data = tmp;
        data[0] = 20;
        data[1] = 60;
        data[2] = 80;
        data[3] = 110;
        return data;
    }

    function lenArr() public view returns (uint){
        return data.length;
    }
}

contract OperasiArrayCont {
    uint[] data;

    function deklarasi() public {
        data = [10, 20, 30, 50];
    }

    function cetak() public view returns (uint[] memory) {
        uint[] memory x = data;
        return x;
    }

    function tambahArr(uint x) public {
        data.push(x);
    }

    function hapusArr() public {
        data.pop();
    }
}