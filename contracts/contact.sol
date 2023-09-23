// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.21;

import "./IERC20.sol";
import "./Ownable.sol";

contract DynamicTaxToken is Ownable {
    IERC20 public token;
    uint256 public buyTaxRate; // Tax rate for buys in basis points (1 basis point = 0.01%)
    uint256 public sellTaxRate; // Tax rate for sells in basis points (1 basis point = 0.01%)

    constructor(address _tokenAddress, uint256 _initialBuyTaxRate, uint256 _initialSellTaxRate) {
        token = IERC20(_tokenAddress);
        buyTaxRate = _initialBuyTaxRate;
        sellTaxRate = _initialSellTaxRate;
    }

    function updateBuyTaxRate(uint256 _newBuyTaxRate) public onlyOwner {
        require(_newBuyTaxRate <= 10000, "Tax rate must be in basis points (0-10000)");
        buyTaxRate = _newBuyTaxRate;
    }

    function updateSellTaxRate(uint256 _newSellTaxRate) public onlyOwner {
        require(_newSellTaxRate <= 10000, "Tax rate must be in basis points (0-10000)");
        sellTaxRate = _newSellTaxRate;
    }

    function calculateBuyTax(uint256 amount) public view returns (uint256) {
        return (amount * buyTaxRate) / 10000;
    }

    function calculateSellTax(uint256 amount) public view returns (uint256) {
        return (amount * sellTaxRate) / 10000;
    }

    function collectTax(uint256 taxAmount) public onlyOwner {
        // Implement your logic to collect the tax here, e.g., transfer it to a designated address
        token.transfer(owner(), taxAmount);
    }
}
