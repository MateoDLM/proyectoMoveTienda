# 📦 Módulo `tienda`

Este módulo implementa la lógica para administrar una **tienda virtual** en la blockchain Sui utilizando el lenguaje **Move**.  
Permite manejar **productos** y **empleados** dentro de una tienda, con operaciones CRUD (Crear, Leer, Actualizar, Eliminar).

---

## 📂 Estructuras

### `Tienda`
Representa la tienda principal.  
Campos:
- `id: UID` → Identificador único en la blockchain.
- `productos: VecMap<u64, Producto>` → Lista de productos almacenada como mapa.
- `empleados: VecMap<u64, Empleado>` → Lista de empleados almacenada como mapa.

---

### `Producto`
Representa un producto de la tienda.  
Campos:
- `nombreProducto: String` → Nombre del producto.
- `precioProducto: u16` → Precio en la moneda definida.
- `talleProducto: String` → Talle o tamaño.
- `tipoProducto: String` → Categoría o tipo.
- `cantidadProducto: u16` → Stock disponible.
- `disponibilidadProducto: bool` → Disponibilidad (true/false).

---

### `Empleado`
Representa un empleado de la tienda.  
Campos:
- `nombreEmpleado: String` → Nombre completo.
- `cargoEmpleado: String` → Cargo o rol.
- `cuitEmpleado: u32` → Identificador fiscal.
- `turnoEmpleado: String` → Turno laboral.
- `estadoEmpleado: bool` → Estado activo/inactivo.

---

## ⚠️ Códigos de Error
- `ID_YA_EXISTE (1)` → El identificador ya está en uso.
- `ID_NO_EXISTE (0)` → El identificador no se encuentra.

---

## 🔹 Funciones

### Tienda
- `crear_tienda(ctx: &mut TxContext)` → Crea una nueva tienda vacía.
- `eliminar_tienda(tienda: Tienda)` → Elimina una tienda de la blockchain.

---

### Productos
- `agregar_producto(...)` → Agrega un nuevo producto.
- `modificar_nombre_producto(...)` → Cambia el nombre.
- `modificar_precio_producto(...)` → Cambia el precio.
- `modificar_talle_producto(...)` → Cambia el talle.
- `modificar_tipo_producto(...)` → Cambia el tipo.
- `modificar_cantidad_producto(...)` → Cambia la cantidad.
- `modificar_disponibilidad_producto(...)` → Cambia la disponibilidad.
- `eliminar_producto(...)` → Elimina un producto

---

Para poder trabajar con este proyecto en la blockchain Sui, es necesario tener instalado Sui CLI (herramienta de línea de comandos oficial de Sui), así como Move (incluido dentro de Sui CLI para compilar y probar módulos). También se recomienda tener Git para clonar y gestionar el repositorio, y un editor de código como Visual Studio Code con la extensión de Move para facilitar la escritura y depuración del contrato.

Guía rápida para probar en la TestNet de Sui

1️⃣ Configurar entorno de TestNet

# Crear nueva variable de entorno
sui client new-env --alias testnet --rpc https://fullnode.testnet.sui.io:443

# Ver entornos configurados
sui client envs

# Cambiar al entorno TestNet
sui client switch --env testnet

2️⃣ Información de la cuenta

# Ver dirección activa
sui client active-address

# Pedir fondos en TestNet
sui client faucet

# Ver balance de la cuenta
sui client balance

3️⃣ Probar el proyecto

# Ejecutar pruebas
sui move test

# Compilar el paquete Move
sui move build

4️⃣ Subir el paquete a la blockchain

sui client publish

Una vez publicado, puedes buscar el Package ID en SuiScan o Sui Explorer seleccionando la red TestNet.

5️⃣ Llamar funciones del contrato

sui client call \
  --package <PackageID> \
  --module tienda \               # Nombre del módulo
  --function <Funcion> \          # Nombre de la función
  --args <Argumentos>             # Argumentos de la función


