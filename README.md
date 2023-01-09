# Guía para abogados sobre Contratos Inteligentes

## Introducción

En este trabajo encontrarás un esfuerzo por explicar con el mayor detalle y simpleza posible el funcionamiento de los contratos inteligentes, no obstante esto presupone
el tener un entendimiento básico de la tecnología blockchain, razón por la cual recomiendo ver el siguiente video del canal de Youtube "Simply Explained" (no es de mi autoría),
ya que me parece que hace un gran trabajo explicando este concepto.

[![Video Blockchain](https://img.youtube.com/vi/SSo_EIwHSd4/maxresdefault.jpg)](https://www.youtube.com/watch?v=SSo_EIwHSd4)

Asimismo dejo otro video del mismo canal pero enfocado en los contratos inteligentes como tal, creo que será muy beneficioso el verlo antes de continuar con la lectura del respecto
de esta página, de manera que se tengan nociones del tema a tratar.

[![Video Smart Contracts](https://img.youtube.com/vi/ZE2HxTmxfrI/maxresdefault.jpg)](https://www.youtube.com/watch?v=ZE2HxTmxfrI)

## Sobre este proyecto

**Propósito**

El objetivo de este proyecto es introducir al mundo de los 'Smart Contracts' o contratos inteligentes a quien se interese por este tema, desde la perspectiva de alguien que realiza sus estudios en el ámbito jurídico y que desea transmitir aquello que ha aprendido a través de la experimentación y análisis del código que los conforma. 

Mi deseo es aportar valor mediante la abstracción del funcionamiento técnico de los distintos tipos de contratos inteligentes a un nivel general de entendimiento, que permita a partir de esto iniciar discusiones respecto a los efectos, beneficios, potenciales o incluso riesgos que pueden representar tanto en el mundo jurídico como en otras áreas. No obstante, espero que también inspire y ocasione curiosidad por esta tecnología, especialmente para aquellos que no tienen concocimientos de informatica, tanto en el sentido de que haya el deseo por profundizar más en estos temas o de aprender a programar, creciendo así la comunidad de desarrolladores de esta tecnología, o simplemente que cause el efecto de querer incorporarla en sus respectivos trabajos, negocios o incluso en el día a día.

Este proyecto esta compuesto de dos partes principales, por una parte están los contratos que podríamos denominar como base, puesto que son estándares que se usan en la industria, esto implica que para analizar proyectos complejos es necesario entender estos, puesto que de una u otra forma los incorporan, a su vez esto tiene otra razón de ser, ya que al estandarizar ciertos contratos esto crea compatibilidad entre las distintas aplicaciones, protocolos o proyectos que los utilizan. Por otra parte, está la sección de proyectos, la llamo así porque aqui mi objetivo es analizar las inovaciones específicas que están haciendo distitos agentes en este espacio.

Al ingresar a cada uno de los contratos se encontrará una explicación y esquemas que permitan visualizar el funcionamiento del contrato, así como el análisis que en cada caso realice de ellos. Si bien esto sería suficiente, los invito a revisar el código de cada uno de ellos, dado que a través de comentarios en el código explicaré exactamente que hace cada uno de sus componentes. 

Finalmente, cabe destacar que en cada uno de los contratos desplegaré un sitio web en el que se puedan utilizar, de manera que otra forma de aprender acerca de su funcionamiento pueda ser mediante la experimentación.


**Contenidos**

- Contratos Básicos
	- Tokens
		- [ERC 20](Base/tokens/ERC20)
		- [ERC 721](Base/tokens/ERC721) (en desarrollo)
		- [ERC 777](Base/tokens/ERC777) (en desarrollo)
		- [ERC 1155](Base/tokens/ERC1155) (en desarrollo)
	- Control (en desarrollo)
	- Governanza (en desarrollo)

- Proyectos (Proximamente)
	- Decentralized Autonomous Organization (DAO)
	- Prestamos
	- Exchange


## Contratos Inteligentes

**¿Qué son?**

A pesar del nombre que se les ha dado y que incluso en aquellos programados con el lenguaje Solidity tengan la mención expresa de llamarse contratos, la realidad es que la gran mayoría de estos no podrían considerarse como tales desde el punto de vista jurídico, puesto que carecen de los elementos esenciales de un contrato, ya sea el consentimiento o el objeto. En realidad se trata simplemente de programas informaticos que son desplegados en una "blockchain" o cadena de bloques y que se ejecutan a solicitud de los usuarios, ya sea al momento de su despliegue o posterior a este. 

El término "Smart Contract" es acuñado por Nick Szabo al definirlo como "una serie de promesas, establecidas de forma digital, que incluyen protocolos que permiten la ejecución de las mismas". El hecho de que no podamos considerarlos como contratos en la mayoría de los casos no es algo que se debería de considerar como negativo, sino que por el contrario extiende las aplicaciones que se le pueden dar a estos programas y por lo tanto no se debe por esta razón pormenorizar su importancia para el mundo jurídico, puesto que al tener la capacidad de transferir valor económico, abren una enorme cantidad de discusiones respecto a la naturaleza jurídica que en cada caso tienen y por supuesto las consecuencias que devienen de los mismos.

Los Smart Contracts tienen una serie de características que es importante tomar en consideración:

- Inmutabilidad del código: Esto es de suma importancia entenderlo de forma correcta, porque usualmente estamos acostumbrados a un modelo de desarrollo de software que se basa en actualizaciones, es decir, que se va modificando el código conforme pasa el tiempo entregando cada vez un mejor producto y libre de errores. No obstante, esto es algo que no ocurre en el caso de los Smart Contracts ya que una vez que se despligan ya no se pueden realizar actualizaciones al código. Esto genera seguridad en el sentido de que todas las personas que deseen hacer uso de ese contrato lo pueden hacer con total certeza de que no pueden ser modificadas las condiciones establecidas en este, también hace que en principio persistan a través del tiempo y que sean resistentes a cualquier tipo de censura o alteración. Ahora, esto a su vez debe ser tratado con mucha precaución puesto que existen mecanismos que ocasionan que esta inmutabilidad no sea del todo cierta. Existe la instrucción `selfdestruct()` que como su nombre lo indica permite la destrucción de un determinado contrato y transfiere cualquier balance que haya tenido el contrato a la dirección especificada entre parentesis, sin embargo hay que recordar que esta debe ser expresamente programada dentro del contrato, ya que de lo contrario no habrá forma de remover el contrato y este persistirá en el tiempo. Otra cuestión a considerar es que hay ciertos mecanismos que permiten hacer una relativa actualización haciendo uso de contratos proxy, aunque te adelanto que si bien es una solución astuta termina respetando la regla de la inmutabilidad en un sentido técnico (el efecto práctico si sería una actualización).

	Habra quien se esté cuestionando en este punto como es que pueden operar quienes usan esta tecnología sin poder dar actualizaciones a sus usuarios, la respuesta se encuentra en el despliegue de un nuevo Smart Contract junto con la indicación a sus usuarios de usar la nueva versión, dejando la anterior en desuso o permitiendo que coexistan. Esta es la razón por que muchas veces en aplicaciones que utilizan Smart Contracts te indican la posibilidad de usar por ejemplo la versión 1, 2 o las que estén diponibles. El metodo que mencioné anteriormente para tener contratos que puedan tener una relativa actualización a través del uso de proxys debe también ser programado de origen, es decir que si no se construyó esta funcionalidad al inicio persisten integralmente a través del tiempo.

- Ejecución debe ser a petición del usuario: En múltiples foros se habla de que los Smart Contracts se ejecutan de forma automática, no obstante esta es una noción erronea, solo se ejecutan aquellas funciones que solicite el usuario. En este sentido, sí existe una gran similitud con la forma en la que funcionan los contratos en el mundo real, puesto que aún después de la celebración de un contrato lo que tenemos del otro lado son personas y estas pueden decidir sobre la ejecución de lo establecido en las clausulas. Por ejemplo, pensemos en un contrato de mutuo (coloquialmente conocido como préstamo) sobre una cantidad de dinero determinada con un plazo para la restitución del mismo, podría darse el supuesto de que el deudor (mutuario) caiga en incumplimiento al nunca restituir la cantidad pactada y a pesar de tener el acreedor (mutuante) derecho a exigir el cumplimiento por la vía judicial, nunca lo haga. Lo mismo ocurre con los Smart Contracts, puede darse el supuesto de que se haga uso de ellos y que obtengan determinados rendimientos que no serán trasladados al usuario hasta que este expresamente lo solicite o que el creador del contrato utilice algun mecanismo preprogramado para transmitirselos, no obstante notese como siempre hay algun ejecutor del Smart Contract. Esto destruye la noción de que en relidad sean "Smart" o inteligentes puesto que el código por si mismo no toma decisiónes, pero en todos los casos respeta lo establecido en su código, por lo tanto si se tiene derecho por ejemplo a reclamar determinados rendimientos el codigo lo permitirá. La idea que quiero transmitir es que así como los derechos se tienen que ejercer o exigir su cumplimiento, lo mismo ocurre con las funciones de un Smart Contract.

	Habiendo mencionado lo anterior, me gustaría recalcar que no tiene sentido que fueran inteligentes en el sentido de estarse autoejecutando y tomando decisiones, puesto que al estar desplegados en una blockchain permiten el uso de mecanismos externos que incorporen esta misma funcionalidad. Es otras palabras, se puede crear un algoritmo que de acuerdo a una determinada estrategia interactue de forma automatizada con distintos contratos, misma situación podría plantearse respecto al uso de algoritmos de inteligencia artificial que tomen decisiones respecto a la interacción que tengan que realizar con determiandos contratos.

- Los Smart Contracts pueden interactuar con otros Smart Contracts: Esta característica es sumamente poderosa puesto que abre la posibilidad de hacer transacciones sumamente complejas. Pensemos en una DAO que básicamente es un Smart Contract equiparable al contrato de sociedad, o en terminos más sencillos estamos creando una empresa completamente digital, cuyos mecanismo de control y gobierno están incorporados como código, teniendo la posibilidad de administrar un patrimonio de activos digitales, combinando esto con la posibilidad de interactuar con otros contratos inteligentes tenemos como resultado que se ve habilitada para participar en el ecosistema de finanzas decentralizadas o en cualquier otro protocolo "por si misma". En este sentido los miembros de la DAO unicamente tendrían que respetar los mecanismos de toma de decisiones que se fijaron en la DAO, así como aquellos que se establezcan para la administración de su patrimonio de manera que sea la propia DAO la que "contrate" en última instancia. Este contrato inteligente en particular, la DAO (Decentralized Autonomous Organization), me parece que nos provee de uno de los mejores casos de estudio respecto a un tipo de Smart Contract que podríamos considerar como contrato desde el punto de vista jurídico y le dedico una sección específica para su estudio.

	Dejando de lado ese particular ejemplo que mencioné antes, recordemos que en general solo lidiamos con programas computacionales que en su mayoría no podrían considerarse como contratos desde el punto de vista jurídico y ya anticipaba que esto más que ser limitante era aún más benéfico puesto que extendía las posibilidades de los usos que se les podrían dar. En este punto podemos entender con mucha más claridad el significado de esto, por ejemplo, pensemos en un contrato como el ERC4626 que básicamente funciona como una bóveda que permite recibir las recompensas o fondos enviados por otros protocolos o apliciones y emitir "acciones" o tokens representativos del porcentaje que correspondería respecto a los activos que están siendo almacenados en la bóveda. Como se puede observar esto es simplemente una aplicación que permite almacenar recompensas o activos hasta que el usuario desee que estas le sean repartidas, lo que observamos en este caso es simplemente una funcionalidad adicional que nos permite este programa y dado que los tokens son contratos en sí mismos hay una interacción entre la boveda y estos.

- Los contratos a su vez pueden actuar como cuentas: Lo que esto implica es que los Smart Contracts pueden tener balances de la misma forma en que lo hacen las wallets, por lo tanto, son suceptibles de recibir la criptomoneda nativa de la blockchain correspondiente u otros tokens. Esto a pesar de no ser una sorpresa, dado todo lo que se ha discutido hasta ahora, es de la mayor relevancia comprenderlo, debido a que debemos construir los mecanismos adecuados para manejar dichos balances, existe un riesgo real de que en caso de no saber manejarlos apropiadamente se queden bloqueados de forma permanente y sin posibilidad de recuperarlos. Imaginemos el supuesto de que se establece una condición de imposible cumplimiento para efecto de poder reclamar el balance de un contrato, esto tendría el efecto práctico de perderlos debido a que la inmutabilidad del código impediría la modificación de dicha condición.

- Transparencia: Todos los Smart Contracts son públicos y por lo tanto cada una de las operaciones que se llevan a cabo a través de estos también lo son. Esto se traduce en la posibilidad de auditarlos y por supuesto de interactuar con ellos. Cuando en algún punto se hable de los hackeos de Smart Contracts esta es una característica muy interesante a tomar en cuenta, ya que no debemos esperar a que las autoridades realicen su investigación, sino que cualquiera es capaz de darle un estudio y seguimientos inmediatos a los hechos ocurridos. Lo mismo ocurre cuando querramos analizar, por ejemplo, si un determinado protocolo o aplicación está siendo rentable y por supuesto cómo está generando sus ingresos, ya que tendremos un acceso total a sus operaciones que se den en la blockchain.


**¿Qué utilidad tienen para el ámbito jurídico?**

- Oferta inicial pública: En lugar de llevar a cabo todos los procedimientos legales requeridos para efecto de poder cotizar por primera vez en el mercado bursatil, se podría en su lugar emitir un token representativo de las acciones de una sociedad, a su vez, podría programarse los mecanismos para efecto de posteriormente tener la capacidad de emitir más acciones, o por el contrario reducirlas, incluso sería posible incorporar las opciones que en ocasiones se le otorgan a los empleados para efecto de que eventualmente obtengan determinado número de acciones.

- Reparto de utilidades: En este sentido existe la posibilidad de contruir protocolos que permitan la distribución de recompensas obtenidas como resultado de alguna actividad económica. Podríamos pensar en la forma en la que un fondo de inversión distribuye los rendimientos obtenidos a sus inversionistas, la diferencia entre hacer esto a través del sistema bancario es que las reglas establecidas para la distribución de dichas recompensas se vuelve transparente, calculable, potencialmente administrada de forma algoritmica y por encima de todo, con reglas preestablecidas que den seguridad a las partes involucradas.

- Finanzas decentralizadas: Existen múltiples "contratos" correspondientes al "mundo financiero" que ahora son suceptibles de ser replicados a través de esta tecnología, pensemos en préstamos, seguros, fianzas, apalancamiento financiero, arbitraje, trading, autofinanciamiento, entre otros. La gran cuestión a tomar en consideración es que como ya mencioné, en muchos casos la forma en la que funcionan impide que se consideren como contratos jurídicamente, no obstante tienen los mismos efectos prácticos, adicionalmente es necesario prestar atención al hecho de que muchas de las actividades del sector financiero contienen regulaciones especiales para efecto de poderse llevar a cabo y cuentan con obligaciones durante su operación. En mi opinión no deberíamos tratar de aplicarles la misma regulación, puesto que esta tecnología cuenta con mecanismos propios de protección que hacen que no sea necesaria una intervención de ninguna autoridad, sumado a la transparencia en la operación que permite la tecnología Blockchain.

- Sociedades digitales: Anteriormente se había hablado al respecto de este tipo de contrato que permite una organización y adminitración patrimonial que se vuelve por si misma capaz de interactuar con otros contratos. El beneficio se encuentra en las reglas de operación, puesto que cuentan con mecanismos de control que impiden que se les cause daño a los socios, así como la posibilidad de recuperar la inversión realizada en estas. Cuentan con la ventaja de ser capaces de acceder a todo el ecosistema de finanzas decentralizadas, así como la posibilidad de servir como medios de administración de aplicaciones decentralizadas, o como esquemas para alzar fondos o administrar recursos para alcanzar determinados fines.

- Medios alternativos de solución de controversias: Existe la posibilidad de crear mecanismos de solución de controversias digitales para aquellos casos que requieran soluciones o interpretaciones que vayan más allá del código, permitiendo de esta forma una capa de seguridad adicional que hace aún más atractivo el uso de esta tecnología y que provee de herramientas fehacientes en cuanto a plazos, presentación de pruebas, votaciones y toma de decisiones.

- Protección de datos personales: Una de las características más interesantes, puesto que desafía el paradigma existente en la web hoy en día, en el cual tenemos proveedores de servicios digitales que monetizan los datos personales, es que se puede separar el contrato que en última instacia es el que va a "prestar el servicio" o mejor dicho con el que va a interactuar el usuario, de la interfaz con la que lo hace. Es decir imaginemos que pudieramos usar directamente los servicios de nuestro banco sin tener que ingresar a su página de internet o aplicación movil, incluso podría irse más allá y construir plataformas alternativas para accesar a un mismo servicio. Lo que esto garantiza es que haya fuertes incentivos para ofrecer la mejor experiencia en cuanto a la plataforma, así como a recabar la menor cantidad de datos posibles, dado que en su caso podrían surgir alternativas que recolecten menos datos o incluso ningún tipo de información personal, factores harían más atractivo su uso.

- Transmisión de la propiedad: Este es un tema que está aún en desarrollo, pero se podría utilizar los token no fungibles ("NFT") para efecto de representar activos físicos y de esta forma poder transmitir la propiedad de estos. Esto tiene beneficios muy claros en cuanto a transparencia y tener un medio fehaciente, puesto que la transacción quedaría registrada de forma permanente e inmutable.   

**Ejemplo de contrato**

A continuación voy a mostrar un ejemplo de un contrato inteligente. En este caso se trata de un contrato que resguarda determinados fondos hasta que se cumpla un término, tiene las siguientes carcaterísticas:

- Permite al usuario depositar la criptomeda nativa, así como cualquier token ERC20 (tantos tokens como se desee).
- Permite establecer una fecha exacta para la liberación de los fondos depositados.
- Previo a la fecha establecida es imposible recuperar los fondos.
- Permite definir quien será el beneficiario de los fondos depositados, es decir que no solo sirve para autocustodia.
- Una vez llegado el término continua operando bajo la condición original, es decir que llegado el término se liberen los fondos al beneficiario, por lo que en caso de que se deposite después de cumplido el término estos serán inmediatamente liberables, pero unicamente serán recibidos por el beneficiario.
- Solamente se puede definir al momento de creación al beneficiario y al término, una vez desplegado el contrato ya no es posible modificarlos.
- El contrato no cuenta con un mecanismo de aceptación para el beneficiario, es decir que unilateralmente le serán enviados con independencia de su voluntad.
- El contrato no cuenta con ningún mecanismo para que sea deshabilitado, una vez desplegado estará disponible de forma indefinida.
- El contrato no tiene restricción respecto a quien pueda interactuar con él, es decir que aceptará depósitos de cualquier cuenta, tampoco hay restricción alguna en cuanto al monto o la cantidad de veces que se puede depositar.
- De igual forma dado que no hay restricción respecto a quien pueda interactuar con el contrato, cualquier cuenta podrá solicitar la liberación de los fondos, no solo el beneficiario (aunque este es el único que los recibirá).

Ahora hay que entender la estructura del código:

1. Al momento de creación.
	- `carteraBeneficiario` requerimos dar la dirección del beneficiario, por ejemplo "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2".
	- `tiempoInicio` quizas ya te estarás preguntando si existe una vulnerabilidad en este contrato dado que hay distintas zonas horarias, por lo que definir una fecha y hora determinada podrían causar que en realidad se liberen los fondos antes o después del tiempo deseado, justamente para evitar esto es que la fecha deseada se da en forma de una "timestamp" esta utiliza la fecha y hora Unix que está basada en el UTC (Universal Time Coordinated), lo único que debes hacer es buscar un conversor a tiempo Unix en internet, por ejemplo, el número "1706736605" representa el 31 de enero de 2024 a las 15:30 con 5 segundos. 

2. Funciones que nos muestran información del contrato.
	- `function beneficiario` nos muestra quien es el beneficiario, lo hace dandonos su dirección.
	- `function inicio` nos muestra el término a partir del cual será posible retirar los fondos, lo hace dándonos el timestamp.
	- `function liberados` nos muestra los fondos (en forma de la criptomeda nativa) que han sido liberados hasta el momento, por liberados me refiero a que han sido entregados al beneficiario.
	- `function erc20Liberados` debemos indicarle la dirección del token, para que nos muestre la cantidad de dichos tokens que han sido liberados.
	- `function cantidadBloqueada` nos muestra la cantidad bloqueada (en forma de la criptomeda nativa) en un determinado momento (hay que darle un timestamp). Siempre debemos darle a esta función la fecha de liberación o posterior a esta, puesto que recordemos que antes de dicho termino no habría fondos disponibles.
	- `function cantidadERC20Bloqueada` nos muestra la cantidad bloqueada (en forma de un token en particular por lo que hay que darle su dirección) en un determinado momento (hay que darle un timestamp). Siempre debemos darle a esta función la fecha de liberación o posterior a esta, puesto que recordemos que antes de dicho termino no habría fondos disponibles.

3. Funciones que modifican un estado o situación.
	- `function liberar` transfiere la totalidad de los fondos del contrato (en forma de la criptomoneda nativa) siempre y cuando haya llegado el término fijado.
	- `function liberarToken` transfiere la totalidad de los fondos del contrato (en forma de un token en específico por lo que hay que darle dicha dirección) siempre y cuando haya llegado el término fijado. 
A continuación el código:

```solidity
pragma solidity ^0.8.0;

import "@openzeppelin/contracts@4.6.0/token/ERC20/utils/SafeERC20.sol";

contract resguardoFondos {
 
    uint256 private _liberados;
    mapping(address => uint256) private _erc20Liberados;
    address private immutable _beneficiario;
    uint64 private immutable _inicio;

    constructor(
        address carteraBeneficiario,
        uint64 tiempoInicio
    ) {
        require(carteraBeneficiario != address(0), "resguardoFondos: beneficiario no puede ser la direccion cero");
        _beneficiario = carteraBeneficiario;
        _inicio = tiempoInicio;
    }

    receive() external payable virtual {}

    function beneficiario() public view virtual returns (address) {
        return _beneficiario;
    }

    function inicio() public view virtual returns (uint256) {
        return _inicio;
    }

    function liberados() public view virtual returns (uint256) {
        return _liberados;
    }

    function erc20Liberados(address token) public view virtual returns (uint256) {
        return _erc20Liberados[token];
    }

    function liberar() public virtual {
        uint256 liberable = cantidadBloqueada(uint64(block.timestamp));
        _liberados += liberable;
        Address.sendValue(payable(beneficiario()), liberable);
    }

    function liberarToken(address token) public virtual {
        uint256 liberable = cantidadERC20Bloqueada(token, uint64(block.timestamp));
        _erc20Liberados[token] += liberable;
        SafeERC20.safeTransfer(IERC20(token), beneficiario(), liberable);
    }

    function cantidadBloqueada(uint64 tiempo) public view virtual returns (uint256) {
        return _calculoLiberacion(address(this).balance, tiempo);
    }

    function cantidadERC20Bloqueada(address token, uint64 tiempo) public view virtual returns (uint256) {
        return _calculoLiberacion(IERC20(token).balanceOf(address(this)), tiempo);
    }


    function _calculoLiberacion(uint256 totalDisponible, uint64 tiempo) internal view virtual returns (uint256) {
        if (tiempo < inicio()) {
            return 0;
        } else if (tiempo >= inicio()) {
            return totalDisponible;
        } else {
            return 0;
        }
    }
}
```

Piensa en lo simple pero poderoso que es este contrato, al ser capaz de recibir tokens podría resguardar todo tipo de activos, un ejemplo interesante sería que recibiera el token PAX Gold (PAXG), puesto que este es un token que está respaldado 1:1 por oro, específicamente 1 PAXG esta respaldado por una onza troy de oro, siendo incluso posible redimir dichos tokens por oro físico bajo las condiciones establecidas por la empresa que maneja dicho token (Paxos Trust Company LLC). En este supuesto tendríamos un contrato digital que prácticamente estaría custodiando oro. Misma situación si pensamos en que sea un contrato que reciba tokens respaldados por determinadas monedas ("Stable Coins") como podría ser USDT para dolares o incluso para pesos mexicanos MXNT.

Más allá de todas las posibilidades de tokens que podrían ser almacenados pensemos en los usos que le podríamos dar, siendo los más obvios el de autocustodia, es decir alguien que se autodesigna como beneficiario puesto que por alguna razón desea que le sea imposible recuperar los fondos hasta llegada una fecha determinada (podría ser simplemente por ahorro) o aquel en el que se usa para beneficiar a un tercero, quizas podríamos pensar en una especie de "herencia" destinada a ser entregada en un futuro, o dado que un token puede representar las acciones de una sociedad se podría utilizar como un mecanismo de transición para la cesión de acciones, puesto que le garantizarían al beneficiario que le serían cedidas al estar bloqueadas en el contrato, pero estaría imposibilitado para liberarlas hasta pasado el término y consecuentemente le sería imposible hacer valer sus derechos de gobernanza que le otorgan dichos tokens.

¿Qué ocurriría con alguien que transfiere sus activos a un contrato como este para colocarse en un estado de insolvencia? Tanto el propio sujeto como la autoridad estarían completamente imposibilitados para recuperar los fondos previo a la conclusión del término. La autoridad tendría que hacerse con las llaves privadas de la cartera del beneficiario para que transcurrido el tiempo necesario pudieran recuperar los fondos bloqueados.

## Precisiones técnicas

En esta sección me gustaría aclarar cuestiones que creo que pueden ocasionar dudas para alguien que recien se involucra con esta tecnología.

<ins>¿En qué lenguage de programación se hace un contrato inteligente?</ins>

Depende de la Blockchain, en esta guía todos los contratos están programados con Solidity, lenguage de programación originalmente creado para la red de Ethereum, la cual es la plataforma más grande de contratos inteligentes al momento en que escribo esto. No obstante cabe destacar que múltiples blockchains han adoptado el mismo lenguage de programación, por lo que si así lo deseas podrás usar estos mismos contratos en las blockchains que sean compatibles. Algunos ejemplos de estas son:
- Polygon
- Binance Smart Chain
- Hedera
- Tron
- Avalanche
- Fantom
- xDAI
- Optimism

<ins>¿Cómo se usan?</ins>

El proceso funciona primero a través de su despliegue en la blockchain correspondiente, si ya haz hecho transacciones con criptomonedas en realidad es muy similar a hacer una transacción solo que en este caso tendrás que pagar un costo por su despliegue. A este costo se le denomina "gas", esto es debido a una analogía que puedes hacer con la gasolina que utilizas para tu vehículo, solo llegarás tan lejos como la cantidad de gasolina que hayas cargado te lo permita. En este caso el "gas" es para las computaciones que se tienen que realizar para efecto de ejecutar el código de tu contrato, entre más complejo e intensivo sea el código mayor será la cantidad de gas requerida. Una vez desplegado podrás interactuar con el contrato de la forma en que tu lo desees, ya que recordemos que eres libre de construir la interfaz que desees para interactuar con este (una página web, aplicación o usarlo directamente a través de programación).

<ins>¿Cómo se prueban?</ins>

Recordemos que dada la inmutabilidad del código es necesario que se realicen pruebas previo a su despliegue. La forma más sencilla de hacerlo es a través de Remix IDE, el cual es un editor de código en línea que permite compilar y desplegar localmente los contratos, a su vez, nos da cuentas de prueba con un balance precargado de "ether" para efecto de cubrir los costos del gas. El problema del método anterior es que es totalmente local, no estas deplegando el contrato en ninguna blockchain. Esta es la razón por la que existen blockchains para desarrolladores, cuyo único propósito es puedas probar tus contratos e interactuar con ellos, pero no hay que confundirse y desestimarlas por esto, dado que tienen todas las características de una blockchain en forma, por lo que todos tus prototipos que despliegues en estas, así como las transacciones e interacciones que realices con el contrato persistirán y serán publicamente auditables.

Existen las siguientes blockchains de prueba o tambien denominadas "testnets"(a la blockchain principal se le denomina "Mainnet"):
- Kovan
- Rinkeby
- Sokol
- Görli
- Ropsten

Este método tiene un gran inconveniente, las blockchains de prueba no son iguales a la principal (Ethereum), por ejemplo en el listado anterior, a excepción de Ropstein, todas usan un mecanismo de consenso distinto llamado "Proof of Authority" mientras que Ethereum utiliza Proof of Work (estamos muy próximos a que cambie a Proof of Stake). En la práctica esto se manifiesta en que las criptomonedas de estas blockchains solo se distribuyen a determinados agentes, por lo que la única forma de obtenerlo es a traves de un faucet, esto es un programa que basicamente envía la criptomeda a quien se lo solicite. Lo que me molesta particularmente es que generalmente te solicitan algún mecanismo externo de indentificación, ya sean redes sociales o la creación de cuentas. Si bien existen algunos que no requieren ningun tipo de identificación generalmente te dan montos muy pequeños y tienen grandes limitaciones de tiempo para volver a solicitar. Esto tiene su razón de ser, puesto que de lo contrario podría haber agentes que se hicieran con todo el suministro y por lo tanto impidieran que otros desarrolladores usaran las testnets, de forma que requieres identificar a los solicitantes para impedir que concentren demasiado. Mi queja es que una práctica poco amigable en materia de protección de datos personales, aunque también debo admitir que para el caso de Ropstein al ser un mecanismo de consenso de Proof of Work podría minarse y de esta forma eliminar dicha restricción, aunque quizas sea un poco excesivo dedicar poder computacional a minar una testnet, sin contar que tomaría más tiempo.

La última forma para probarlos es mediante la construcción de un ambiente local de desarrollo, para lo cual requerimos poder compilar los contratos desde nuestra computadora, la habilidad de escribir programas para interactuar con estos y una blockchain que esté bajo nuestro control y que nos permita desplegar los contratos. Las herramientas más populares para lograr esto son Truffle y Ganache, la primera te permitirá compilar tus contratos y probarlos, mientras que la segunda te permite crear tu propia copia de Ethereum, para efecto de que despliegues e interactues con tus contratos. Este es el método más recomendable en mi opinión, sin embargo no lo recomendaría para alguien que apenas está comenzando, en dicho caso, sin lugar a dudas Remix es la mejor opción.

<ins>¿Que debemos tomar en consideración al diseñar un contrato inteligente?</ins>

Hay dos puntos primordiales a tomar en consideración, uno es la eficiencia y el otro es la seguridad.

Con eficiencia me refiero a que el contrato utilice la menor cantidad de gas posible, por una parte porque como desarrollador tu eres quien deberá absorver el costo del despliegue de tu contrato, pero aún más importante es el costo de gas en que incurrirán los usuarios de este. El contrato debe estar cuidadosamente diseñado para efecto de mitigar costos que se trasladarían al usuario, algunas formas de lograr esto es reduciendo al mínimo indispensable la cantidad de información que almacenamos en la blockchain, un ejemplo de esto lo podemos encontrar en el primer contrato que les presenté más arriba. Si lo analizas detalladamente nunca almacena un listado de los tokens que se le transfieren a pesar de que puede recibir tantos como el usuario desee, la razón de esto es que simplemente sería redundante hacerlo, puesto que los tokens al ser contratos guardan un listado de todos aquellos poseedores de estos, razón por la cual en lugar de almacenar esta información doblemente, aprovechamos la información que ya está guardada en otros contratos. Otra solución ingeniosa es que solamente hasta el momento en que se da la liberación de los fondos de un token es que estos quedan registrados en el contrato, puesto que necesitamos llevar un registro de la cantidad entregada, pero previo a la liberación no se almacena absolutamente ninguna información de estos, es ingenioso porque 1.el contrato puede recibir sin límites, 2. el contrato permite consultar las cantidades bloqueadas de cualquier token entregado y 3. hace todo lo anterior sin guardar ninguna información de estos sino hasta que el usuario libera los fondos. 

Existen múltiples formas de eficientar, no obstante es un tema bastante complejo, en ocasiones bastante contraintuitivo y sin lugar a dudas puede llegar a conflictuar con el aspecto de la seguridad, es decir que en un intento de hacerlo eficiente creemos vulnerabilidades. Un ejemplo de esto lo podemos encontrar en el "overflow" un tipo de vulnerabilidad consistente en exceder el almacenamiento destinado. Si revisas nuevamente el contrato anterior encontrarás que siempre que se define una variable numérica se define algo como lo siguiente: `uint64`, esto significa que estamos declarando un "unsigned integer" de 64 bits, sé que suena muy complicado, pero simplemente le estamos diciendo a la computadora que vamos a almacenar un número positivo (por eso es unsigned contrario a signed) y que este no podrá exceder de 64 bits, lo que se traduce a que no podrá ser un número superior a 18,446,744,073,709,551,615. Lo que debes preguntarte es que ocurre si intentamos almacenar un número más grande, por ejemplo 18,446,744,073,709,551,616 (solo le sume +1) es justamente esto lo que ocasionaría un "overflow", anteriormente lo que esto provocaba es que se reseteaba la contabilidad, por lo que el valor de dicha variable volvía a ser 0. Imagina por ejemplo que ocurriría si esa varible almacenara el suministro total de tu token y se le hiciera un overflow, pasarías a tener 0 (repito que este ya no es comportamiento que tiene un overflow actualmente, ahora simplemente se reportaría un error y no permitiría ejecutar dicha acción). Pudimos haber asignado un mayor límite, no obstante era inecesario para los valores que se los dimos, con esto quiero ilustrar como debemos ponderar en el diseño del contrato tanto la eficiencia como la seguridad.

La seguridad es un aspecto fundamental a tomar en consideración al momento de diseñarlos, siempre debemos auditarlos frente a las vulnerabilidades más comunes y de ser posible solicitar una auditoría externa. Algunas recomendaciones que se pueden hacer es siempre tratar de utilizar "librerias" o módulos que estén diseñas específicamente para este propósito, así como en la medida de lo posible construir sobre la base de otros contratos que ya hayan sido auditados.

<ins>¿Tienes otras preguntas o te gustaría contribuir a este proyecto?</ins>

!Me encantaría escuchar tus comentarios!
Puedes escribirme al siguiente correo: delamdev@proton.me. Las contribuciones y cambios los puedes proponer directamente a través de un "pull request" dado que este es un repositorio público. 

