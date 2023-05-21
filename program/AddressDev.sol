// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract AlamatDompetCont {
    // address = no rekening
    // smart contract = punya addresss sendiri (tidak hanya akun)

    // address payable -> send dan trasnfer

    address public akun;
    uint danaKontrak;

    function ambilAlamat() public returns (address) {
        akun = msg.sender;
        return akun;
    }

    function caraAmbil2() public view returns (address almt) {
        almt = msg.sender;
    }

    // ambil alamat dari contract
    function caraAmbil3() public view returns (address){
        address ambl = address(this);
        return ambl;
    }


    // address transaksi
    function kirimDana(address payable almt, uint nominal) public {
        almt.transfer(nominal);
    }

    function prosesKirim(address payable almt, uint nomintal) public returns (bool) {
        return almt.send(nomintal);
    }

    function terimaDana() public payable {
        danaKontrak = msg.value;
    }
}