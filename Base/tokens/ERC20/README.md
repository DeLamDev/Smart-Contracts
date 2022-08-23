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

![Estructura](/img/ERC20.pdf)


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

Habiendo entendido lo anterior, podemos empezar a explicar conceptualmente el funcionamiento del token. Toda la funcionalidad del token gira en torno a dos registros, los balances y las aprobaciones, por lo tanto siempre ten en mente que alguna de estos dos registros van a ser alterados cuando usamos las funciones del contrato. A su vez, la modificación de dichos registros actualiza los valores que contienen, por lo que las funciones informativas únicamente nos muestran los nuevos valores o en su caso aquellos que le dimos desde el comienzo.

En la siguiente imagen se puede observar un diagrama con el funcionamiento, nota como primero hay una fase (de un color azul oscuro) que precede a todo, llamada contructor, junto con las declaración de variables, esta sección va a existir por el mero despliegue del contrato. En esta fase indicamos la información que va a contener el contrato así como la asignación de dos de estos valores, el nombre y símbolo, los cuales son inmutables. Posteriormente encontramos las tres categorías que ya se mencionaban anteriormente.

![Función ERC20](/img/Funcionamiento_del_token.pdf)

## Mecanismos de emisión ##

## Hooks ##

## Extensiones ##

## Aplicaciones en el ámbito jurídico ##

## Experimentos ##

## Demostración de operación ##
