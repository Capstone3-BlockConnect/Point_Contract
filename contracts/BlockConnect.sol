// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract BlockConnect is ERC20, Ownable {
    using SafeMath for uint256;

    mapping(string => uint256) private userIdToBalance;

    event DepositEvent(string userId, uint256 amount);
    event WithdrawEvent(string userId, address to, uint256 amount);

    constructor() ERC20("Soong", "SBC") Ownable(msg.sender) {
     
    }

    // 사용자 자산 민팅
    function deposit(string memory userId, uint256 amount) public {
        _mint(address(this), amount.mul(1e18));
        userIdToBalance[userId] = userIdToBalance[userId].add(amount.mul(1e18));
        emit DepositEvent(userId, amount);
    }

    // 사용자 자산 출금
    function withdraw(string memory userId, address to, uint256 amount) public onlyOwner {
        require(userIdToBalance[userId] >= amount.mul(1e18), "Insufficient balance");
        userIdToBalance[userId] = userIdToBalance[userId].sub(amount.mul(1e18));
        _transfer(address(this), to, amount.mul(1e18));
        emit WithdrawEvent(userId, to, amount);
    }

    // 잔액 조회
    function getBalance(string memory userId) public view returns (uint256) {
        return userIdToBalance[userId];
    }

 
}
