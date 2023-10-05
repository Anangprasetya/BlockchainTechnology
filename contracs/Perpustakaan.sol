// SPDX-License-Identifier: MIT
// Anangprasetya
pragma solidity 0.8.13;

contract Perpustakaan {
    address public admin;
    
    struct Book {
        string ISBN;
        string title;
        uint128 year;
        string author;
    }
    
    mapping(string => Book) public books;
    
    event BookAdded(string ISBN, string title, uint128 year, string author);
    event BookUpdated(string ISBN, string title, uint128 year, string author);
    event BookRemoved(string ISBN);
    
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }
    
    constructor() {
        admin = msg.sender;
    }
    
    function store(string calldata _ISBN, string calldata _title, uint128 _year, string calldata _author) public onlyAdmin {
        require(bytes(_ISBN).length > 0, "ISBN cannot be empty");
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_author).length > 0, "Author cannot be empty");
        
        require(books[_ISBN].year == 0, "Book with this ISBN already exists");
        
        books[_ISBN] = Book(_ISBN, _title, _year, _author);
        emit BookAdded(_ISBN, _title, _year, _author);
    }

    function update(string memory _ISBN, string memory _title, uint128 _year, string memory _author) public onlyAdmin {
        require(bytes(_ISBN).length > 0, "ISBN cannot be empty");
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_author).length > 0, "Author cannot be empty");
        
        require(books[_ISBN].year != 0, "Book with this ISBN does not exist");
        
        books[_ISBN] = Book(_ISBN, _title, _year, _author);
        emit BookUpdated(_ISBN, _title, _year, _author);
    }
    
    function destroy(string calldata _ISBN) public onlyAdmin {
        require(books[_ISBN].year != 0, "Book with this ISBN does not exist");
        delete books[_ISBN];
        emit BookRemoved(_ISBN);
    }
}