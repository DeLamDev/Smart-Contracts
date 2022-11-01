// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/ERC20Pausable.sol)

pragma solidity ^0.8.0;

import "../ERC20.sol";
import "../../../security/Pausable.sol";

/**
 * Se trata de una extensión que hace uso de los hooks para efecto de poder 
 * Limitar las operaciones de emisión, transferencia y destrucción.
 * 
 * Puede ser util por ejemplo para tener tiempo de evaluar algun error o
 * actualización o inclusopara proteger a los ususarios en caso de un evento
 * inesperado.
 */
abstract contract ERC20Pausable is ERC20, Pausable {
    /**
     * Aqui se implementa el hook, particularmente el que opera previo a 
     * transaccción del token. Aunque realmente solo agrega la verificación
     * de si han o no sido pausadas las operaciones del token.
     *
     * ADVERTENCIA: se sigue teniendo que implementar la función "paused()"
	 * en el contrato base, de lo contrario no tendrá efecto alguno.
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);

        require(!paused(), "ERC20Pausable: token transfer while paused");
    }
}
