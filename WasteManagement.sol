// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract WasteManagement {

    enum UserType { Individual, WasteCollector }
    
    struct User {
        string fullName;
        string email;
        string phoneNumber;
        string password;
        UserType userType;
    }

     struct Waste {
        uint256 wasteId;
        string wasteType;
        uint256 quantity;
        string disposalMethod;
        address userAddress;
    }

    struct Pickup {
        uint256 pickupId;
        uint256 wasteId;
        address userAddress;
        string location;
        uint256 timestamp;
        bool isCollected;
    }

    mapping(string => address) userEmailToAddress;
    mapping(address => User) public users;
    mapping(uint256 => Waste) public wastes;
    mapping(uint256 => Pickup) public pickups;

    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this operation");
        _;
    }

    modifier onlyIndividual() {
        require(users[msg.sender].userType == UserType.Individual, "Only individual users can perform this operation");
        _;
    }

    modifier onlyCollector() {
        require(users[msg.sender].userType == UserType.WasteCollector, "Only waste collectors can perform this operation");
        _;
    }

    function addUser(
        string calldata _fullName,
        string calldata _email,
        string calldata _phoneNumber,
        string calldata _password,
        UserType _userType
    ) public onlyOwner {
        require(userEmailToAddress[_email] == address(0), "Email is already registered");

        users[msg.sender] = User(_fullName, _email, _phoneNumber, _password, _userType);
        userEmailToAddress[_email] = msg.sender;
    }


    function addWaste(string calldata _wasteType, uint256 _quantity, string calldata _disposalMethod) public onlyIndividual {
        uint256 wasteId = block.timestamp; // Generate a unique waste ID
        wastes[wasteId] = Waste(wasteId, _wasteType, _quantity, _disposalMethod, msg.sender);
    }


    function editWaste(uint256 _wasteId, string calldata _wasteType, uint256 _quantity, string calldata _disposalMethod) public onlyIndividual {
        Waste storage waste = wastes[_wasteId];
        require(msg.sender == waste.userAddress, "You can only edit your own waste");

        waste.wasteType = _wasteType;
        waste.quantity = _quantity;
        waste.disposalMethod = _disposalMethod;
    }


    function deleteWaste(uint256 _wasteId) public onlyIndividual {
        Waste storage waste = wastes[_wasteId];
        require(msg.sender == waste.userAddress, "You can only delete your own waste");
        delete wastes[_wasteId];
    }

    function requestPickup(uint256 _wasteId, string calldata _location, uint256 _timestamp) public onlyIndividual {
        uint256 pickupId = block.timestamp; // Generate a unique pickup ID
        pickups[pickupId] = Pickup(pickupId, _wasteId, msg.sender, _location, _timestamp, false);
    }

    function editPickupStatus(uint256 _pickupId, bool _isCollected) public onlyCollector {
        pickups[_pickupId].isCollected = _isCollected;
    }
}
