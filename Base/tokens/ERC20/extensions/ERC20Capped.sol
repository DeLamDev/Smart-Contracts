// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/ERC20Capped.sol)

pragma solidity ^0.8.0;

import "../ERC20.sol";

/**
 * Se trata de una extensión que fija un límite al suministro total posible
 * del token.
 */
abstract contract ERC20Capped is ERC20 {
    uint256 private immutable _cap;

    /**
     * En el contrato base se debe fijar el límite, el cual es asignado a la
     * variable "_cap" al momento del despliegue y posteriormente ya no es
	 * posible modificarlo.
     */
    constructor(uint256 cap_) {
        require(cap_ > 0, "ERC20Capped: cap is 0");
        _cap = cap_;
    }

    /**
     * Incluye una función informativa que muestra el límite al usuario.
     */
    function cap() public view virtual returns (uint256) {
        return _cap;
    }

    /**
     * Hace un override de la función "_mint" de manera que agregue la verificación
	 * de que efectivamente no se exceda el límite al momento de emitir tokens.
     */
    function _mint(address account, uint256 amount) internal virtual override {
        require(ERC20.totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");
        super._mint(account, amount);
    }
}
