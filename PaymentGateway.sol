// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title PaymentGateway
 * @dev Secure non-custodial processor for decentralized payments.
 */
contract PaymentGateway is Ownable, ReentrancyGuard {
    
    event PaymentReceived(
        address indexed payer, 
        address indexed token, 
        uint256 amount, 
        bytes32 paymentId
    );

    event FundsWithdrawn(address indexed merchant, uint256 amount);

    constructor() Ownable(msg.sender) {}

    /**
     * @dev Process payment in Native ETH.
     * @param _paymentId Unique identifier from the merchant's system.
     */
    function payWithEth(bytes32 _paymentId) external payable nonReentrant {
        require(msg.value > 0, "Payment must be greater than zero");
        emit PaymentReceived(msg.sender, address(0), msg.value, _paymentId);
    }

    /**
     * @dev Process payment in ERC-20 tokens.
     * @param _token Address of the ERC-20 token contract.
     * @param _amount Amount of tokens to pay.
     * @param _paymentId Unique identifier from the merchant's system.
     */
    function payWithToken(address _token, uint256 _amount, bytes32 _paymentId) external nonReentrant {
        require(_amount > 0, "Amount must be greater than zero");
        IERC20 token = IERC20(_token);
        
        bool success = token.transferFrom(msg.sender, address(this), _amount);
        require(success, "Token transfer failed");

        emit PaymentReceived(msg.sender, _token, _amount, _paymentId);
    }

    /**
     * @dev Withdraw native ETH from the contract.
     */
    function withdrawEth() external onlyOwner {
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
        emit FundsWithdrawn(owner(), balance);
    }

    /**
     * @dev Withdraw ERC-20 tokens from the contract.
     */
    function withdrawToken(address _token) external onlyOwner {
        IERC20 token = IERC20(_token);
        uint256 balance = token.balanceOf(address(this));
        token.transfer(owner(), balance);
    }
}
