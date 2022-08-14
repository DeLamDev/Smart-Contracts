// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.7.0) (token/ERC20/ERC20.sol)


// Un contrato siempre comienza indicando la versión de solidity que
// va a interpretar a nuestro contrato, en este caso la 0.8.0, lo más
// recomendable es usar la más reciente pero puedes elegir la que desees.

pragma solidity ^0.8.0;

// Aqui importamos la interfaz del contrato, puedes pensarlo como los
// "botones" de tu contrato, es decir con lo que va a interactuar el 
// usuario, mi recomendación siempre que quieras analizar un contrato
// es empezar por la interfaz si es que la tiene.

import "./IERC20.sol";

// Esta es otra interfaz pero solo para los botones que únicamente van
// a proveer al usuario de información del contrato, pero que no modifican
// ninguna situación.

import "./extensions/IERC20Metadata.sol";

// Este es un modulo enfocado en darle seguridad al contrato, específicamente
// para el maneja de direcciones a las cuales se transferirán fondos.

import "../../utils/Context.sol";

/**
 * Cuando veas este contrato, recuerda que lo que estás viendo
 * es el fundamento sobre el que vas a construir tu token, pero
 * no el token en sí mismo. En la carpeta de experimento podrás
 * encontrar una implementación del mismo, la cual si podrás modificar
 * para efecto de crear tu propio token.
 *
 * Este contrato cumple con un estandar llamado ERC20, la razón
 * por la que debes respetarlo es porque de esta forma otros  
 * desarrolladores pueden construir otros contratos que interactuen
 * con el tuyo y a si mismo con todos aquellos que respeten este 
 * estandar.
 * 
 * Recuerda que para entender la estructura y las acciones que realiza
 * en un esquema conceptual lo podrás encontrar en el README.md, el 
 * propósito de estos comentarios es que entiendas exactamente que hace
 * cada línea de código.
 *
 * Este contrato es la implementación del estandar ERC20 de OpenZeppelin, 
 * compañia que se dedica a realizar contratos inteligentes de código
 * abierto, así como a hacer auditorías de ciberseguridad. La razón por 
 * la que elegí hacer el análisis de estos en específico es porque son 
 * los más usados en la industria, además de contar con auditorías de 
 * seguridad por lo que podrás usarlos con un mayor grado de confianza.
 *
 *
 */

// Siempre comenzamos el programa con la palabra 'contract' seguido del
// nombre que le damos al contrato, en este caso 'ERC20', a continuación
// indicamos que va a heredar funcionalidades de otros contratos, particularmente
// de 'Context', IERC20 y IERC20Metadata. Fijate que son los mismos que importamos 
// arriba.

contract ERC20 is Context, IERC20, IERC20Metadata {
	/**
	 * Solidity exige que declaremos lo que vamos a usar, lo cual es similar a lo que
	 * hacemos en la exposición de un contrato, ya que presentamos toda la información
	 * que es necesaria para darle contexto, como lo son los hechos y los antecedentes.
	 * 
	 * En este caso declaramos que va a haber balances de nuestros usuarios y que estos van
	 * a ser manejados como un 'mapping', lo cual significa que serán almacenados como un 
	 * 'diccionario' solo que en lugar de tener palabras aparejadas de su definición, tendremos
	 * direcciones aparejadas de sus balances numéricos (esto es lo que significa address => uint256).
	 *
	 * Declaramos otro diccionario llamado allowances para almacenar autorizaciones para la
	 * transferencia del balance de un usuario por parte de otra dirección designada.
	 *
	 * Declaramos que tendremos un suministro total y que este será un valor numérico.
	 *
	 * Declaramos que el token tendrá un nombre y que este será una o más palabras.
	 *
	 * Declaramos que el token tendrá un símbolo que este será una o más palabras.
	 *
	 **/
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * Lo que ves a continuación es una función especial que se ejecuta antes que todas las
     * demás, aquí se realizan operaciones indispensables para efecto de que el contrato sea
     * utilizado. En este caso asigna el nombre y el símbolo del token que tú elijas. Ojo,
     * esto se realiza al momento del despliegue y después no es posible modificarlos.
     *
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * Función informativa que provee el nombre del token a quien lo solicite.
	 * Es 'public' para que cualquiera pueda llamarla.
	 * Es 'view' porque solo permite ver información pero no hace alteración alguna.
	 * Es 'virtual' y 'override' porque tiene una interfaz llamada IERC20 que tiene
	 * exactamente las mismas funciones solo que están vacias, por lo que le indicamos
	 * que esta es la que debe utilizar. La interfaz sirve para que veamos que podemos
	 * hacer con un contrato y qué resultado debemos esperar, pero aquí construimos la
	 * forma en lo que lo va a lograr. 1. declaramos el nombre, 2. exigimos que era un
	 * requisito esencial que se asignara desde el comienzo y 3. se lo mostramos al usuario.
	 *
	 * Nota como iniciamos dandole nombre a la función y terminamos diciendo cuál es el
	 * resultado (en este caso una palabra por eso 'string')
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * Aplican mismos comentarios a la función name() solo que en este caso la 
	 * función nos muestra el símbolo asignado al token.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * Los tokens no pueden fraccionarse de la misma forma en que lo hace el Ether,
     * razón por la cual debemos definir artificialmente cuanto es posible que sea
     * fraccionado, el estandar es 18 decimales, imitando la relación Ether/Wei. 
     *
     * Si deseas moficar los decimales, se puede hacer a su vez un override en el
     * contrato principal para que sea el número que desees, por ejemplo, definir
     * 5 decimales significa que para mandar 10 tokens ingresaríamos en el contrato
     * 1000000, puesto que 1000000/10**5 = 10. 
     * 
     * Esta función es informativa y nos muestra el estandar de 18 decimales.
     * Esto implica que hacemos la operación (tokens solicitados) * (10**18)
	 * y esa operación la hacemos en la interfaz (frontend).
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * Función informativa que nos muestra el suministro total del token.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * Función informativa, le indicamos una dirección y nos informa de su balance.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * Esta es la función que vamos a usar para transferir fondos, aunque como podrás darte
     * cuenta no lo hace por sí misma, sino que llama a otra función interna llamada _transfer
     * que en última instancia es la que verdaderamente hace la transferencia.
     * Nos solicita que le digamos la dirección y el monto que vamos a transferir, asignando
	 * automaticamente como propietario de los tokes a quien llama la función.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * Esta es una función informativa que nos muestra dado una dirección, que otras direcciones
	 * ha autorizado para que gasten su balance.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return_allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     */
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
            // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
            // decrementing then incrementing.
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        unchecked {
            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
            // Overflow not possible: amount <= accountBalance <= totalSupply.
            _totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `amount`.
     *
     * Does not update the allowance amount in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Might emit an {Approval} event.
     */
    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    /**
     * @dev Hook that is called after any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * has been transferred to `to`.
     * - when `from` is zero, `amount` tokens have been minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens have been burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
} 
