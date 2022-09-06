// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
 
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
 
contract Bitcoin_Replica is ERC20, ERC20Capped {
     
    uint256 private _block;
    uint64 private _genesis;  
    uint32 private _halving;      
    uint8 private _reward;        
                                   
    constructor() ERC20("Bitcoin-R", "BTCR") ERC20Capped(21000000*10**decimals()) {
        _block = 0;
        _genesis = uint64(block.timestamp);  
        _reward = 50;
        _halving = 210000;                
    }                             
                                   
    function mine(address to) public {
        require(to != address(0));                 
        require(block.timestamp >= miner_calculator());
        if(_block == _halving) {    
            _reward = (_reward / 2);                           
            _halving += 210000;                                                  
        }                                                                        
        _block += 1;                                               
        _mint(to, (_reward * 10** decimals()));       
    }                                 
 
    function miner_calculator() public view returns(uint256) {
        return (_genesis + (10 minutes * _block));
    }                                           

    function _mint(address to, uint256 amount)
        internal
        override(ERC20, ERC20Capped)
    {
        super._mint(to, amount);
    }
 }
