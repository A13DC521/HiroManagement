pragma solidity ^0.4.16;

contract Owned {
    address owner;
    
    function Owned() public {
        owner = msg.sender;
    }
    
   modifier onlyOwner {
       require(msg.sender == owner);
       _;
   }
}


contract HiroManagement is Owned{

    //Structure of clients
    Client public registeredClients;

    //Count the number of registered clients
    address[] public clientsAccounts;
    
    // Map verified addresses
    // mapping (address => bool) public verified;

    //Map all clients
    mapping (address => Client) public clients;

    //Events
    event ClientHistory(address indexed client);
    event ClientInfo(string projectName, string firstName, string lastName, string eMail);

    // For clients' info
    struct Client{
        string projectName;
        string firstName;
        string lastName;
        string eMail;
    }
    
    // modifier onlyHiro{
    //     require(msg.sender == hiro);
    //     _;
    // }
    
    // modifier onlyVerified{
    //     require(verified[msg.sender]);
    //     _;
    // }
    
    function addClient(address _client, string _projectName, string _firstName, string _lastName, string _eMail) public{
        // verified[_client] = true;
        var client = clients[_client];
        uint index;
        for(uint i = 0; i < clientsAccounts.length; i ++){
            if(_client == clientsAccounts[i]){
                index = i;
                
                clientsAccounts[index] = clientsAccounts[clientsAccounts.length - 1];
                delete clientsAccounts[index];
                delete clients[_client];
                clientsAccounts.length --;

                client.projectName = _projectName;
                client.firstName = _firstName;
                client.lastName = _lastName;
                client.eMail = _eMail;
            }
        }
        
        client.projectName = _projectName;
        client.firstName = _firstName;
        client.lastName = _lastName;
        client.eMail = _eMail;
        
        clientsAccounts.push(_client) - 1;
        ClientHistory(_client);
        ClientInfo(_projectName, _firstName, _lastName, _eMail);
    }
    
    function removeClient(address _clientAddress) public{
        // verified[_clientAddress] = false;
        uint index;
        for(uint i = 0; i < clientsAccounts.length; i ++){
            if(_clientAddress == clientsAccounts[i]){
                index = i;
            }
        }
        
        clientsAccounts[index] = clientsAccounts[clientsAccounts.length - 1];
        delete clientsAccounts[index];
        delete clients[_clientAddress];
        clientsAccounts.length --;
        ClientHistory(_clientAddress);
    }
    
    function getAllClients() view public returns(address[]) {
        return clientsAccounts;
    }
    
    function getOneClient(address _address) view public returns (string, string, string, string) {
        return (clients[_address].projectName, clients[_address].firstName, clients[_address].lastName, clients[_address].eMail);
    }
    
    function clientsNumber() view public returns (uint) {
        return clientsAccounts.length;
    }

}
