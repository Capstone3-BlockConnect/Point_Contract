// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MyToken is ERC20 {
    uint256 public initialSupply;
    using SafeMath for uint256;

    event TransferEvent(address from, address to, uint256 amount);
    event BurnEvent(address from, uint256 amount);
    event MintEvent(address to, uint256 amount);

    constructor() ERC20("Soong", "SBC") {
        initialSupply = 0;
        _mint(msg.sender, initialSupply.mul(1e18));
    }

    function sendToOther(address to, uint256 amount) public returns(bool){
        require(address(to) != address(0), "invalid address");
        _transfer(msg.sender, to, amount.mul(1e18));
        
        emit TransferEvent(msg.sender, to, amount);
        return true;
    }

    function awardToUser(uint256 awardAmount) public returns(bool){
        _mint(msg.sender, awardAmount.mul(1e18));

        emit MintEvent(msg.sender, awardAmount);
        return true;
    }

    function burnToken(uint256 burnAmount) public returns(bool){
        _burn(msg.sender, burnAmount.mul(1e18));

        emit BurnEvent(msg.sender, burnAmount);
        return true;
    }

}
