// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/**
 * @title Stacks Builder NFT
 * @dev Low-gas, self-contained ERC721 implementation for Base Network.
 */
contract StacksBuilder {
    string public name = "Stacks Builder";
    string public symbol = "SB";
    uint256 public totalSupply = 0;
    uint256 public constant MAX_SUPPLY = 100;
    uint256 public constant MAX_PER_WALLET = 2;
    address public owner;

    string private baseURI;
    bool public mintLive = false;

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(address => uint256) public mintedPerWallet;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function mint(uint256 quantity) external {
        require(mintLive, "Mint not active");
        require(quantity > 0, "Min 1");
        require(totalSupply + quantity <= MAX_SUPPLY, "Sold out");
        require(mintedPerWallet[msg.sender] + quantity <= MAX_PER_WALLET, "Exceeds limit");

        for (uint256 i = 0; i < quantity; i++) {
            uint256 tokenId = totalSupply + 1;
            _owners[tokenId] = msg.sender;
            emit Transfer(address(0), msg.sender, tokenId);
            totalSupply++;
        }
        
        _balances[msg.sender] += quantity;
        mintedPerWallet[msg.sender] += quantity;
    }

    function toggleMint() external onlyOwner {
        mintLive = !mintLive;
    }

    function setBaseURI(string memory _newURI) external onlyOwner {
        baseURI = _newURI;
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(tokenId <= totalSupply, "Inexistent token");
        return string(abi.encodePacked(baseURI, uint2str(tokenId), ".json"));
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return _balances[_owner];
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        return _owners[tokenId];
    }

    function uint2str(uint256 _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) return "0";
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}
