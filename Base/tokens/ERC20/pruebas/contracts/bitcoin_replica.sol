// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
 
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
 
contract Bitcoin_Replica is ERC20, ERC20Capped {
     
    uint256 private _block;
    uint64 private _genesis;  
    uint32 private _halving;      
    uint64 private _reward;
	uint32 private precision;
                                   
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
            _reward = halving_calculator(_reward);                           
            _halving += 210000;                                                  
        }                                                                        
        _block += 1;                                               
        _mint(to, (_reward * 10** (decimals() - precision)));       
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
	
	function next_block() public view returns(uint256) {
        return _block;
    }

    function halving_calculator(uint64 reward) internal returns(uint64) {
        if(_reward >= 25 && _reward != 50 && precision < 18) {
            precision += 1;
            return reward*(uint64(10))/2;
        } else {
            return (_reward / 2);
        }
    }
	
	function current_reward() public view returns(uint64) {
        return _reward;
    }

    function halving() public view returns(uint32) {
        return _halving;
    }

    function genesis() public view returns(uint64) {
        return _genesis;
    }
 }
