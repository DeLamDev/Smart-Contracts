// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC20/extensions/ERC20Burnable.sol)

pragma solidity ^0.8.0;

import "../ERC20.sol";
import "../../../utils/Context.sol";

/**
 * Esta extensión ayuda a destruir/quemar una cantidad determianda del token,
 * es posible utilizarla tanto por el propietario como por el autorizado.
 */
abstract contract ERC20Burnable is Context, ERC20 {
    /**
     * Implementa la función 'burn' la cual lo único que hace en realidad
     * es permitir el acceso a la función interna '_burn' programada en
     * el contrato base.
     */
    function burn(uint256 amount) public virtual {
        _burn(_msgSender(), amount);
    }

    /**
     * Misma función que la descrita anteriormente, solamente que en este
     * caso se detruyen los tokens de un tercero por parte de quien haya
     * autorizado para este propósito.
     * A su vez llama a otra función que se encarga primero de actualizar
	 * autorización que se le dió al usuario.
     */
    function burnFrom(address account, uint256 amount) public virtual {
        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);
    }
}

