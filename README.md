# 📦 Módulo `tienda`

Este módulo implementa la lógica para administrar una **tienda virtual** en la blockchain Sui utilizando el lenguaje **Move**.  
Permite manejar **productos** y **empleados** dentro de una tienda, con operaciones CRUD (Crear, Leer, Actualizar, Eliminar).

---

## 🛠 Requisitos previos

Para trabajar con este proyecto, se recomienda tener instalados:  

- **Sui CLI**: Herramienta oficial de línea de comandos de Sui.  
- **Move**: Incluido dentro de Sui CLI para compilar y probar módulos.  
- **Git**: Para clonar y gestionar el repositorio.  
- **Visual Studio Code** con la extensión de Move, para facilitar la escritura y depuración del contrato.  
- **Wallet compatible con Sui** (opcional, para interactuar con TestNet/MainNet).

---

## 📂 Estructuras

### `Tienda`
Representa la tienda principal.  
Campos:
- `id: UID` → Identificador único en la blockchain.
- `productos: VecMap<u64, Producto>` → Lista de productos almacenada como mapa.
- `empleados: VecMap<u64, Empleado>` → Lista de empleados almacenada como mapa.

### `Producto`
Representa un producto de la tienda.  
Campos:
- `nombreProducto: String` → Nombre del producto.
- `precioProducto: u16` → Precio en la moneda definida.
- `talleProducto: String` → Talle o tamaño.
- `tipoProducto: String` → Categoría o tipo.
- `cantidadProducto: u16` → Stock disponible.
- `disponibilidadProducto: bool` → Disponibilidad (true/false).

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

### Productos
- `agregar_producto(...)` → Agrega un nuevo producto.  
- `modificar_nombre_producto(...)` → Cambia el nombre.  
- `modificar_precio_producto(...)` → Cambia el precio.  
- `modificar_talle_producto(...)` → Cambia el talle.  
- `modificar_tipo_producto(...)` → Cambia el tipo.  
- `modificar_cantidad_producto(...)` → Cambia la cantidad.  
- `modificar_disponibilidad_producto(...)` → Cambia la disponibilidad.  
- `eliminar_producto(...)` → Elimina un producto.

### Empleados
- `agregar_empleado(...)` → Agrega un nuevo empleado.  
- `modificar_nombre_empleado(...)` → Cambia el nombre.  
- `modificar_cargo_empleado(...)` → Cambia el cargo.  
- `modificar_cuit_empleado(...)` → Cambia el CUIT.  
- `modificar_turno_empleado(...)` → Cambia el turno.  
- `modificar_estado_empleado(...)` → Cambia el estado.  
- `eliminar_empleado(...)` → Elimina un empleado.

---

## 🧪 Guía rápida para probar en la TestNet de Sui

### 1️⃣ Configurar entorno de TestNet
```bash
# Crear nueva variable de entorno
sui client new-env --alias testnet --rpc https://fullnode.testnet.sui.io:443

# Ver entornos configurados
sui client envs

# Cambiar al entorno TestNet
sui client switch --env testnet
````

### 2️⃣ Información de la cuenta
```bash
# Ver dirección activa
sui client active-address

# Pedir fondos en TestNet
sui client faucet

# Ver balance de la cuenta
sui client balance
````

### 3️⃣ Probar el proyecto
```bash
# Ejecutar pruebas
sui move test

# Compilar el paquete Move
sui move build
````

### 4️⃣ Subir el paquete a la blockchain
```bash
sui client publish
````
Una vez publicado, puedes buscar el Package ID en SuiScan o Sui Explorer seleccionando la red TestNet.

### 5️⃣ Llamar funciones del contrato
```bash
sui client call \
  --package <PackageID> \
  --module tienda \               # Nombre del módulo
  --function <Funcion> \          # Nombre de la función
  --args <Argumentos>             # Argumentos de la función
````

