Proyecto de una tienda sencilla y básica programada en MOVE, subida a Blockchain SUI.

Para probar en la TestNet:

Crear nueva variable de entorno:
sui client new-env --alias testnet --rpc https://fullnode.testnet.sui.io:443
Ver variables de entorno:
sui client envs
Cambiar entre variables de entorno:
sui client switch --env testnet 

Dirección activa:
sui client active-address

Pedir fondos:
sui client faucet
Ver fondos:
sui client balance
Probar que funcione:
sui move test
Compilar:
//sui move build 
Subir la Blockchain:
sui client publish

Buscar en SuiScan

Funciones: 

sui client call --package (PackageID) --module tienda(Nombre del módulo) --function (Función a utilizar) --args (Argumentos) 


//Mainnet
//sui client envs
//sui client switch --env mainnet


