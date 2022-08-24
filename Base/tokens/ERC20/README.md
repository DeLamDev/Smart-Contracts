# Tokens ERC20 #

## ¿Qué es un token? ##

Un token es un tipo de contrato inteligente cuyo propósito es la creación de medios de intercambio no distingibles entre sí y que estén dotados de una transmisibilidad, pudiendo ser representativos de activos virtuales o físicos, así como incorporar mecanismos que le otorguen determinadas funcionalidades por medio de algoritmos, especialmente en lo relativo a su emisión y suministro.

En el día a día se suelen confundir con las criptomonedas, por lo que en ocasiones hay quienes suelen usar ambos términos indistintamente, no obstante, dado que este es un proyecto de contratos inteligentes es necesario distinguir y entender cual es la diferencia.

Recordemos que la tecnología que habilita a los contratos inteligentes es Blockchain. Esta tecnología, en términos generales, va a tener los siguientes componentes:
- La cadena de bloques (esta es la esencia).
- Un mecanismo de consenso.
- Una máquina virtual.
- Una criptomoneda nativa.

Si tuviera que simplificar como interactuan estos componentes lo haría en respuesta a una pregunta:

- ¿Cómo resuelve una blockchain el problema de transmitir valor entre las partes?
- R: Blockchain X crea un registro digital para efecto de mantener un control de todas las trasacciones que se den entre las partes usando una criptomoneda nativa. Este registro se materializa en la forma de un bloque de información (como monto, fecha, propietario, destinatario, etc), que se concatena con la siguiente transacción, creando así un historial que denominamos como cadena de bloques. Esta cadena se ve dotada de seguridad cuando definimos cómo nos aseguramos de la veracidad de la información y la forma en que se incorpora a la cadena, por lo que existen distintos algoritmos que podemos usar para efecto de resolver estas cuestiones, al ser el componente que sustenta la integridad de una blockchain, se le denomina como mecanismo de consenso. Finalmente, se incorpora un elemento adicional a algunas blockchains que les da la posibilidad de tener contratos inteligentes y este es una máquina virtual. La idea es que al bloque le agregamos una pieza más de información, que en este caso va a ser código (nuestros contratos inteligentes), usamos a las computadoras que ya están verificando las transacciones e integrandolas en la cadena usando el mecanismo de consenso correspondiente y adicionalmente les pedimos que ejecuten el código que enviamos, siendo indispensable para esto que incorporen una computadora virtual, que nos garantice que el resultado de la ejecucción del código sea igual.

Estoy muy consciente de que faltan muchos elementos que discutir en esta pequeña definición, pero lo que me interesa que distingamos es porqué podemos tener una criptomoneda nativa y a su vez una gran variedad de tokens que coexistan en una misma blockchain. Esto es sencillo de entender una vez que separamos el elemento de los contratos inteligentes de las transacciones que se dan con la criptomoneda.

A su vez, quisiera dejar algo sumamente claro, especialmente para otros abogados. Me parece que los tokens son muy intuitivos para nosotros porque las transacciones con valor económico son parte esencial de la vida contractual, lo mismo ocurre cuando las usamos para representar toda clase de activos como materias primas o incluso las acciones de una sociedad. No obstante hay que ser muy cuidadosos al discutir este tipo de contratos inteligentes en foros o al pensar en la regulación que deben tener, porque no hay límite desde la óptica de los desarrolladores en cuanto a la función que quieran darle a sus tokens. Para clarificar este punto pensemos en que puede haber un token diseñado para representar las fichas de un casino digital, o un token representativo de un boleto de loteria o rifa, o uno para los programas de recompensas aparejados a las tarjetas de crédito, o para representar el progreso de un personaje en un videojuego. Notese como cada una de estas funciones tiene en principio una óptica y regulación completamente distintas, en el caso del casino y la rifa inmediatamente señalaría a la regulación de los juegos y sorteos, mientras que en lo relativo a programas de recompensas de las tarjetas de crédito prodriamos señalar la materia de derecho bancario o para el caso de que el token mismo fuera representativo de una emisión de deuda, la materia de títulos y operaciones de crédito. Lo que podemos observar es que el token en sí mismo es todo y nada, siempre tendremos que estar al caso concreto en cuanto a la función que tenga, y como vimos en el caso del videojuego, también podrían ser usado para fines completamente técnicos sin mayor relevancia jurídica.

## ¿En qué consiste el estandar ERC20? ##

Primero tenemos que entender qué es una EIP (Ethereum Improvement Proposal), para esto debemos de tener claro que Ethereum es completamente de código abrierto, cualquiera puede revisarlo, utilizarlo o modificarlo. Debido a esto se decidió establecer lineamientos para efecto de que cualquier desarrollador pudiera proponer modificaciones, mejoras o incluso innovaciones. Existen distintos tipos de EIPs, siendo uno de ellos las ERC (Ethereum request for comment), las cuales se enfocan en proponer estándares para las aplicaciones y contratos con la finalidad de promover interoperabilidad dentro del ecosistema. 

Una vez aclarado el punto anterior, es sencillo comprender que ERC20 (la numeración los identifica) se trata de una propuesta de estandar para los tokens, la cual está disponible para consulta en https://eips.ethereum.org/EIPS/eip-20.

El estandar nos pide que tengamos ciertas funciones y que tengan un comportamiento, requisitos y resultado determinados.

## Estructura de un token ERC20 ##

En cuanto a las funciones que nos pide el estandar podríamos dividirlas en funciones informativas, que alteran estado y eventos. En la siguiente imagen podemos ver exactamente los nombres que deben tener de acuerdo al estandar ERC20, así como la categoría en la que se encuentran.

![Estructura](img/ERC20.png)


## Funcionamiento ##

Este contrato permite:
- Transferir tokens a cualquier cartera u otros contratos.
- Aprobar a otras carteras o contratos para que utilicen el balance de un usuario.
- Emitir tokens a una cartera o contrato determinado.
- Destruir tokens de una cartera o contrato determinado.

Características:
- Se puede emitir practicamente una cantidad ilimitada de tokens (el límite sería 2²⁵⁶-1).
- No hay restricción en cuanto al monto que puede ser transferido o aprobado para efecto de que otra dirección lo utilice.
- Quien haya sido aprobado puede disponer de fondos ajenos como si fueran suyos.
- No tiene contruida ningún mecanismo que accione la emisión ni la destrucción de tokens, por lo que estas deberán ser programados para efecto de usar los mecanismos internos del contrato o en su caso modificarlos.
- Cuenta con dos funciones adicionales que son `increaseApproval` y `decreaseApproval`, estas no forman parte del estandar pero son incluidas en la implementación de OpenZeppelin para mitigar problemas asociados a la función `approve`.

Habiendo entendido lo anterior, podemos empezar a explicar conceptualmente el funcionamiento del token. Toda la funcionalidad del token gira en torno a dos registros, los balances y las aprobaciones, por lo tanto siempre hay que tener en mente que alguna de estos dos registros van a ser alterados cuando usamos las funciones del contrato. A su vez, la modificación de dichos registros actualiza los valores que contienen, por lo que las funciones informativas únicamente nos muestran los nuevos valores o en su caso aquellos que les dimos desde el comienzo.

En la siguiente imagen se puede observar un diagrama con el funcionamiento, nota como primero hay una fase (de un color azul oscuro) que precede a todo, llamada contructor, junto con las declaración de variables, esta sección va a existir por el mero despliegue del contrato. En esta fase indicamos la información que va a contener el contrato así como la asignación de dos de estos valores, el nombre y símbolo, los cuales son inmutables. Posteriormente encontramos las tres categorías que ya se mencionaban anteriormente.

Hay que notar la distinción que se hace en lo referente a las funciones informativas al estar algunas asignadas desde el contructor, mientras que otras solo proveen información que es actualizada a partir de la activación de dos funciones internas, `_approve` y `_transfer`. Estas últimas son el núcleo del contrato, tienen un `_` al comienzo para indicar que son funciones internas, lo que significa que nadie puede accesarlas o modificarlas directamente sino que solo pueden ser activadas a través de otras funciones que hayamos designado para este propósito. Las funciones que activan a las internas son aquellas que las preceden en el diagrama, estas son las que el usuario va a llamar para interactuar con el contrato, aquellas a las que deberas asignarles botones en la interfaz que dedcidas construir.

Los hooks así como las funciones internas `_mint` y `_burn`, no están conectadas directamente en el diagrama a nada, la razón de esto es justamente que no tienen absolutamente ninguna funcionalidad en el modelo básico de un token, sino que aquí es donde un desarrollador puede implementar cualquier mecanismo que desee para hacer a este token único o funcional. En la siguiente sección vamos a hacer la implementación real de un token con distintos mecanismo de emisión que si ocupen dichas funciones, asi mismo hay una sección más adelante dedicada al uso de los hooks.

Quiero recalcar la necesidad de consultar el archivo [ERC20.sol](Base/tokens/ERC20/ERC20.sol), dado que este contiene el código con mis comentarios en cada una de sus líneas para entender exactamente como se dan estos procesos, por supuesto que mis recomendación sería tener el diagrama que diseñe ya que te servira para siempre entender las relaciones que se están formando.

![Función ERC20](img/Funcionamiento_token.png)

## Mecanismos de emisión ##

Existen básicamente tres formas de emitir el token:

1. Suministro predefinido: En este caso lo que se hace es emitir al momento de la creación del contrato a una dirección predefinida (generalmente aquella que despliega el contrato).
	
	Ejemplo:
	```solidity
	pragma solidity ^0.8.4;

	import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

	contract MiToken is ERC20 {
		constructor() ERC20("MiPrimerToken", "MPTK") {
			_mint(msg.sender, 1000 * 10 ** decimals());
		}
	}
	```

	Felicitaciones, con este código puedes crear tu token ERC20, solo debes modificar el nombre y símbolo (en este caso "MiPrimerToken" y "MPTK"), así como la cantidad que será emitida (en este caso son 1000 tokens).
	Esta es la forma más básica de un token, todo lo que hemos analizado hasta ahora del contrato ERC20 es automaticamente trasladado a esta pequeña implementación tan solo con importar el estandar e indicar que hereda sus métodos con la declaración 'contract MiToken is ERC20'. Debo recalcar que lo que esto ocasiona es una emisión única, en la que quien despliegue el contrato automáticamnete tendrá todo el suminsitro y sin posibilidad de emitir tokens adicionales. 

2. Implementar una función de emisión: Basicamente vamos a contruir esa función faltante para efecto de utilizar `_mint`.

	Ejemplo:
	```solidity
	pragma solidity^0.8.0;

	import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
	import "@openzeppelin/contracts/access/Ownable.sol";
	
	contract MiToken is ERC20, Ownable {
		constructor() ERC20("MiPrimerToken", "MPTK") {}

		function mint(address to, uint256 amount) public onlyOwner {
			_mint(to, amount);
		}
	}
	```
	Este mecanismo es distinto al anterior dado que comenzaría el token teniendo 0 en circulación y solamente el propietario podría decidir a quien emite tokens, lo que iría aumentando el límite progresivamente. Hay en este caso una nueva importación de un contrato llamado `Ownable.sol`, este es una extensión que agrega la posibilidad de limitar funciones para que solo puedan ser llamadas por la dirección que desplegó el contrato, en la sección de extensiones explico a profundidad como funciona esta y otras disponibles.

3. Modularizar el mecanismo de emisión: Esta opción es una tanto más complicada, consiste en separar el mecanismo de emisión del contrato principal, una forma de lograrlo es a través de una serie de modificaciones al token. Hay que tomar en consideración que para fines prácticos ambos contratos deben estar juntos para efecto de que se pueda crear una instancia del token, pero técnicamente lo que ocurre es que se crean dos contratos distintos.

	Ejemplo:
	```solidity
	contract FondeoProyecto {
		ERC20PresetMinterPauser _token;
		address propietario;

		constructor(ERC20PresetMinterPauser token) public {
			_token = token;
			propietario = msg.sender;
		}

		function emitirParaRecaudar() public {
			require(msg.sender == propietario);
			_token.mint(propietario, 1000);
		}
	}
```

Debo aclar que este es una modificación del ejemplo que provee OpenZeppelin para efecto de demostrar la modularización del mecanismo de emisión, solo que originalmente estaba programado de tal forma que emitiera los tokens a quien hubiera minado el último bloque al momento de llamarla. El problema que yo identifico con esa implementación es que me parece que no tiene utilidad alguna, especialmente cuando lo ponemos en contexto, ya que como podrás darte cuenta utiliza una instancia de un contrato llamado `ERC20PresetMinterPauser` que está especialmente adaptado para efecto de crear un protocolo alrededor del token que permita distribuir autorizaciones para efecto de manejar las distintas funciones del token (emitir, destruir, pausar y reanudar), es decir que se designe a una dirección para emitir o alguna otra de las funciones. En este caso este contrato es inutil a menos que se le conceda la autorización de emisión, momento a partir del cual cualquiera podría llamarla y empezar a otorgar los tokens a los mineros, solo que no hay límite en cuanto al numero de veces que se podría llamar, lo que podría ocasionar que se devaluara significativamente el token. En realidad entiendo que se trata de un ejemplo y que no hay la finalidad de pensar en las implicaciones sino de demostrar un mecanismo, soloq ue me pareción que tenía más sentido modificar el ejemplo para efecto de que se usara como un mecanismo de recaudación de fondos en el que se le concede la posibilidad al creador la posibilidad de emitir tokens cuando requiera financiación y que dicha emisión tuviera que ser aprobada por quien esté facultado para concederlas, pero sinq ue esto se tradujera en un riesgo, puesto que como puedes ver limité la posibilidad de emitir a que exclusivamente el propietario pudiera llamarla, pero dejando abierta la cantidad para efecto de que no tuviera que llamarla múltiples veces. 


## Hooks ##



## Extensiones ##

## Aplicaciones en el ámbito jurídico ##

## Experimentos ##

## Demostración de operación ##
