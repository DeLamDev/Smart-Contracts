// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.7.0) (token/ERC20/ERC20.sol)


// Un contrato siempre comienza indicando la versión de solidity que
// va a interpretar a nuestro contrato, en este caso la 0.8.0, lo más
// recomendable es usar la más reciente pero puedes elegir la que desees.

pragma solidity ^0.8.0;

// Aqui importamos la interfaz del contrato, puedes pensarlo como los
// "botones" de tu contrato, es decir con lo que va a interactuar el 
// usuario, mi recomendación siempre que quieras analizar un contrato
// es empezar estudiando la interfaz si es que la tiene.

import "./IERC20.sol";

// Esta es otra interfaz pero solo para los botones que únicamente van
// a proveer al usuario de información del contrato, pero que no modifican
// ninguna situación.

import "./extensions/IERC20Metadata.sol";

// Este es un modulo enfocado en darle seguridad al contrato, específicamente
// para el manejo de direcciones y de las datos enviados al contrato.

import "../../utils/Context.sol";

/**
 * Cuando veas este contrato, recuerda que lo que estás viendo
 * es el fundamento sobre el que vas a construir tu token, pero
 * no el token en sí mismo. En la carpeta de experimentos podrás
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
 * conceptualmente, podrás encontrar una explicación en el README.md, el 
 * propósito de estos comentarios es que entiendas exactamente que hace
 * cada línea de código.
 *
 * Este contrato es la implementación del estandar ERC20 de OpenZeppelin, 
 * compañia que se dedica a realizar contratos inteligentes de código
 * abierto, así como a hacer auditorías de ciberseguridad. La razón por 
 * la que elegí hacer el análisis de estos en específico es porque son 
 * los más usados en la industria, además de contar con auditorías de 
 * seguridad, por lo que podrás usarlos con un mayor grado de confianza.
 *
 *
 */

// Siempre comenzamos el programa con la palabra 'contract' seguido del
// nombre que le damos al contrato, en este caso 'ERC20', a continuación
// indicamos que va a heredar funcionalidades de otros contratos, particularmente
// de Context, IERC20 y IERC20Metadata. Notese, que son los mismos que se importan 
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
	 * que esta es la que debe utilizar. La interfaz sirve para que veamos qué podemos
	 * hacer con un contrato y qué resultado debemos esperar, pero aquí construimos la
	 * forma en lo que lo va a lograr. 1. declaramos el nombre, 2. exigimos que era un
	 * requisito esencial que se asignara desde el comienzo y 3. se lo mostramos al usuario.
	 *
	 * Nota como iniciamos dandole nombre a la función y terminamos (con 'returns') diciendo
	 * cuál es el resultado (en este caso una palabra por eso 'string').
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
     * 
     * Para esta función aplican los mismos comentarios a propósito de la función
     * 'transfer'. El propósito de esta función es que el usuario pueda aprobar a 
     * otra dirección para que gaste su balance, recordemos que podrá ser otro contrato
     * o usuario. Igualmente notese que la aprovación en realidad se lleva a cabo por
	 * otra función llamada _approve.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * 
     * Esta función se utiliza después de haber aprobado a otra dirección para efecto de que 
     * utilice nuestro balance. Es requisito indicar la dirección de la que gastaremos el balance,
     * la dirección a la que deseamos enviarlo y la cantidad de tokens. Nota como directamente 
     * asigna a la dirección que la llama como la autorizada a gastar el balance.
     * 
     * Nuevamente estamos ante un caso en el que la función no realiza el gasto sobre el balance
     * ajeno, ni la transferencia de los tokens, sino que delega dichas funciones a otras dos
     * funciones internas, una actualiza el balance de acuerdo a lo gastado y la otra transfiere.
     *
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
     * Esta función no forma parte del estandar ERC20. Los desarrolladores la incluyeron
     * como una de las potenciales soluciones a vulnerabilidades que se pueden dar a usar
     * la función de aprobación. Debido a esto es que es siempre recomendable usar esta
     * cuando se desee incrementar el monto autorizado, así como a su contraparte para
     * efecto de reducirlo.
     * 
     * En realidad la función lo único que hace es usar la función interna de _approve 
     * pero usando como argumentos al dueño (quer por defecto siempre es quien llama a
	 * a la función), la dirección autorizada y el monto (que se obtiene a través de la
	 * suma entre lo autorizado previamente y el monto indicado).
     * 
     * Favor de consultar el Readme.md para efecto de entender en qué consiste la
	 * vulnerabilidad que mitiga.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * 
     * En este caso aplican los mismos comentarios realizados a propósito de la función
	 * función anterior. Solamente que en este caso se obtiene el monto a partir de la resta
	 * de la autización anterior y el monto solicitado.
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
     * Aquí se encuentra el verdadero mecanismo para la transferencia de los tokens,
     * primero, vemos que se trata de una función de tipo internal, lo que implica
     * que solo la pueden llamar otras funciones dentro del contrato, pero no sujetos
     * externos. Para eso tenemos dos funciones que la llaman y le dan los argumentos
     * que solicita: Quién transfiere, a quién le transfiere y cuánto tranfiere. Se 
     * trata de 'transfer' y 'transferFrom'. En el primer caso asume que quien tranfiere
     * es quien llama la función, mientras que en el segundo nos permite elegir ambos,
	 * solo que antes tiene el control de otra función que se asegura de que esté facultado
	 * para hacerlo (_spendAllowance).
     * Después observamos que tiene dos requisitos, que tanto la dirección que transfiere
     * y la que recive no sean la dirección 0 (esta es una dirección que nadie tiene y 
	 * generalmente se ocupa para quemar tokens). 
	 * 
     * La función '_beforeTokenTransfer' se usa para añadir funcionalidades al token,
     * pero en este caso no hace nada puesto que se deja a discreción de quien crea un
     * token el innovar en las funcionalidades que quiere añadir.
	 *
	 * Posteriormente, se guarda en una variable llamada fromBalance, el balance de quien
	 * transfiere, para luego hacer la verificación de que cuenta con los fondos suficientes
	 * para hacer la transferencia del monto solicitado.
	 *
	 * La palabra 'unchecked' se usa para efectos de hacer más eficiente el contrato, puesto
	 * que Solidity deja de hacer la verificación de un posible over/underflow, y eso hace
	 * que utilice menos gas.
	 * 
	 * Las operaciones que se llevan a cabo son una resta, para actualizar el balance de la
	 * dirección que transmite y una suma para la dirección que recibe.
	 * 
	 * La palabra 'emit' se usa para activar un evento, su propósito es completamente informativo,
	 * de esta forma cada vez que haya una transferencia de produce esta notifiación, informando
	 * sobre la dirección desde la que se transfirió, el destinatario y el monto.
	 * 
	 * La función '_afterTokenTransfer' en este caso no hace nada pero igualmente puede añadir,
	 * funcionalidades al token.
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
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    /** 
     * Esta función establece un mecanismo básico para la emisión del token,
     * aunque dependiendo del tipo de proyecto tendrá una implementación  
     * diferente. Solo debemos darle la dirección a la que emitiremos y la
     * cantidad.
     * La única condición es que no se puede emitir a la dirección cero.
     * Nuevamente estamos en posibilidad de añadir funcionalidad a través
     * de la función '_beforeTokenTransfer' aunque de momento no hace nada.
	 * 
	 * Primero actualizamos el suministro total y después el balance de la
	 * dirección a la que emitimos.
	 *
	 * Emitimos la misma notificación de transferencia, solo nota como al ser
	 * tokens sin dueño previo, se utiliza la dirección cero la que hizo la
	 * transferencia, aunque recuerda que esto es meramente informativo.
	 *
	 * Misma situación de '_afterTokenTransfer', en este caso no hace nada.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        unchecked {
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * Esta sería la función inversa a _mint, puesto que 'quema' o destruye el
     * suministro. Nota como nos solicita exclusivamente la dirección de cuyo
     * balance destruiremos una determinada cantidad de tokens.
     * Nuevamente hay que considerar que no forma parte del estandar ERC20 y que
     * no tiene implementación, el creador del token debe definirlo.
     * 
     * El requisito es que no puede ser la dirección 0 y que tiene que tener suficiente
     * en su balance para satisfacer la cantidad que se desea destruir.
     * 
	 * La única diferencia con _mint es que en este caso solicitado el balance de la
	 * dirección para efecto de verificar que tenga menos o igual que la cantidad que 
	 * se desea destruir y posteriormente le resta dicha cantidad a su balance y al 
	 * suministro total.
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
     * - `owner` cannot sbe the zero address.
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
