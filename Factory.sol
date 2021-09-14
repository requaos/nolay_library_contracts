pragma solidity ^0.5.16;

import "./erc721.sol";

contract Factory {
    address public owner;
    mapping(address => uint256) token_num;
    event CreateNFT(address indexed book, address indexed issuer);
    event MintBook(address indexed book, address indexed issuer);

    constructor(address _owner) public {
        owner = _owner;
    }

    function create_book(string calldata class_id, address issuer)
        external
        returns (address book)
    {
        require(msg.sender == owner);
        bytes memory bytecode = type(ERC721).creationCode;
        ERC721Mintable book = new ERC721Mintable();
        token_num[address(book)] = 0;
        emit CreateNFT(address(book), issuer);
        return address(book);
    }

    function mint_book(address book_address, address to_address)
        external
        returns (address book)
    {
        require(msg.sender == owner);
        ERC721Mintable(book_address).mint(to_address, token_num[address(book)]);
        token_num[address(book)] += 1;
        emit MintBook(address(book), to_address);
        return address(book);
    }
}
