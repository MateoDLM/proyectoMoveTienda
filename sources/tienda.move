module tienda::tienda{
    //Importamos las librerias o funciones a utilizar
    use std::string::String;
    use sui::vec_map::{VecMap, Self}; //Self: Se importa vec_map a si misma //También se puede utilizar empty //use sui::vec_map::{VecMap, empty};
    
    //Códigos de error
    const ID_YA_EXISTE: u64 = 1;
    const ID_NO_EXISTE: u64 = 0;

    //Estructuras 
    public struct Tienda has key{  //Se utiliza key ya que este objeto se va a almacenar en una cuenta
        id: UID,
        productos: VecMap<u64, Producto>, //Uso VecMap para poder almacenar el id del prodcuto
        empleados: VecMap<u64, Empleado>
    }
    
    //Defino los objetos que utilizaré en esta tienda
    public struct Producto has store, drop{ //Utilizan store ya que estos objetos se van a almacenar en el VecMap
        nombreProducto: String,
        precioProducto: u16, 
        talleProducto: String,
        tipoProducto: String,
        cantidadProducto: u16,
        disponibilidadProducto: bool,
    }

    //Defino los empleados que trabajan en esta tienda
     public struct Empleado has store, drop{
        nombreEmpleado: String,
        cargoEmpleado: String,
        cuitEmpleado: u32,
        turnoEmpleado: String,
        estadoEmpleado: bool,
    }

    //Funciones

    #[allow(lint(self_transfer))]
    public fun crear_tienda(ctx: &mut TxContext){  
        let tienda = Tienda {
            id: object::new(ctx), //ID con el contexto de la transacción (Objeto que pasaremos a la blockchain)
            productos: vec_map::empty(), //Creamos el objeto de productos vacío ya que justamente se esta creando
            //Una forma: productos: empty(), utilizo Self (vec_map) para saber que estoy creando
            empleados: vec_map::empty(),
        };

        transfer::transfer(tienda, ctx.sender()); //Transferir tienda (Que transfiero (tienda porque tiene key), A dónde lo transfiero (Persona que ejecuta la función))
    }

    //Funciones producto

    public fun agregar_producto(tienda: &mut Tienda, identificador: u64, nombreProducto: String, precioProducto: u16, talleProducto: String, tipoProducto: String, cantidadProducto: u16){ //Se manda Tienda ya que los productos se van a agregar allí //Se manda identificador ya que cuando definimos que la tienda utilizaría productos utilizamos VecMap
        assert!(!tienda.productos.contains(&identificador), ID_YA_EXISTE); //Si se agrega otro producto con el mismo ID se cancela la operación //Validar que id no este en tienda, espero que no obtenga ese valor (!)

        let producto = Producto { //Producto creado con sus datos
            nombreProducto, //nombreProducto = nombreProducto
            precioProducto, talleProducto, tipoProducto, cantidadProducto, disponibilidadProducto: true
        }; //Se pone disponibilidadProducto: true ya que cuando se agrega un producto nuevo va a estar disponible

        tienda.productos.insert(identificador, producto)  //Meter producto a la tienda
    }

    public fun modificar_nombre_producto (tienda: &mut Tienda, identificador: u64, nuevoNombreProducto: String){
        assert!(tienda.productos.contains(&identificador), ID_NO_EXISTE);     //Identificador del producto

        let producto = tienda.productos.get_mut(&identificador); //Producto a editar
        //Get_mut ya que permite editar mutables(Pide referencia (&))

        producto.nombreProducto = nuevoNombreProducto;
    }

    public fun modificar_precio_producto (tienda: &mut Tienda, identificador: u64, nuevoPrecioProducto: u16){
        assert!(tienda.productos.contains(&identificador), ID_NO_EXISTE);

        let producto = tienda.productos.get_mut(&identificador);

        producto.precioProducto = nuevoPrecioProducto;
    }

    public fun modificar_talle_producto (tienda: &mut Tienda, identificador: u64, nuevoTalleProducto: String){
        assert!(tienda.productos.contains(&identificador), ID_NO_EXISTE);

        let producto = tienda.productos.get_mut(&identificador);

        producto.talleProducto = nuevoTalleProducto;
    }

    public fun modificar_tipo_producto (tienda: &mut Tienda, identificador: u64, nuevoTipoProducto: String){
        assert!(tienda.productos.contains(&identificador), ID_NO_EXISTE);

        let producto = tienda.productos.get_mut(&identificador);

        producto.tipoProducto = nuevoTipoProducto;
    }

    public fun modificar_cantidad_producto (tienda: &mut Tienda, identificador: u64, nuevaCantidadProducto: u16){
        assert!(tienda.productos.contains(&identificador), ID_NO_EXISTE);

        let producto = tienda.productos.get_mut(&identificador);

        producto.cantidadProducto = nuevaCantidadProducto;
    }

    public fun modificar_disponibilidad_producto (tienda: &mut Tienda, identificador: u64, nuevaDisponibilidadProducto: bool){
        assert!(tienda.productos.contains(&identificador), ID_NO_EXISTE);

        let producto = tienda.productos.get_mut(&identificador);

        producto.disponibilidadProducto = nuevaDisponibilidadProducto;
    }

    public fun eliminar_producto(tienda: &mut Tienda, identificador: u64){  //Identificador del producto
        assert!(tienda.productos.contains(&identificador), ID_NO_EXISTE);
        tienda.productos.remove(&identificador);
    }

    //Funciones empleado

    public fun agregar_empleado(tienda: &mut Tienda, identificador: u64, nombreEmpleado: String, cargoEmpleado: String, cuitEmpleado: u32, turnoEmpleado: String, estadoEmpleado: bool){ 
        assert!(!tienda.productos.contains(&identificador), ID_YA_EXISTE); 

        let empleado = Empleado { nombreEmpleado, cargoEmpleado, cuitEmpleado, turnoEmpleado, estadoEmpleado }; 

        tienda.empleados.insert(identificador, empleado)  
    }

    public fun modificar_nombre_empleado (tienda: &mut Tienda, identificador: u64, nuevoNombreEmpleado: String){
        assert!(tienda.empleados.contains(&identificador), ID_NO_EXISTE);

        let empleado = tienda.empleados.get_mut(&identificador);

        empleado.nombreEmpleado = nuevoNombreEmpleado;
    }

    public fun modificar_cargo_empleado (tienda: &mut Tienda, identificador: u64, nuevoCargoEmpleado: String){
        assert!(tienda.empleados.contains(&identificador), ID_NO_EXISTE);

        let empleado = tienda.empleados.get_mut(&identificador);

        empleado.cargoEmpleado = nuevoCargoEmpleado;
    }

    public fun modificar_cuit_empleado (tienda: &mut Tienda, identificador: u64, nuevoCuitEmpleado: u32){
        assert!(tienda.empleados.contains(&identificador), ID_NO_EXISTE);

        let empleado = tienda.empleados.get_mut(&identificador);

        empleado.cuitEmpleado = nuevoCuitEmpleado;
    }

    public fun modificar_turno_empleado (tienda: &mut Tienda, identificador: u64, nuevoTurnoEmpleado: String){
        assert!(tienda.empleados.contains(&identificador), ID_NO_EXISTE);

        let empleado = tienda.empleados.get_mut(&identificador);

        empleado.turnoEmpleado = nuevoTurnoEmpleado;
    }

    public fun modificar_estado_empleado (tienda: &mut Tienda, identificador: u64, nuevoEstadoEmpleado: bool){
        assert!(tienda.empleados.contains(&identificador), ID_NO_EXISTE);

        let empleado = tienda.empleados.get_mut(&identificador);

        empleado.estadoEmpleado = nuevoEstadoEmpleado;
    }


    public fun eliminar_empleado(tienda: &mut Tienda, identificador: u64){
        assert!(tienda.empleados.contains(&identificador), ID_NO_EXISTE);
        tienda.empleados.remove(&identificador);
    }

    //Función eliminar tienda
    
    public fun eliminar_tienda(tienda: Tienda){ //No se pasa referencia porque se ocupa el objeto Tienda
        //Desestructura Struct (objeto) y asigna a cada uno de los valores que tenia el Struct a una variable, _ = ignorar
       let Tienda {id, productos: _ , empleados: _ } = tienda;
       id.delete();
    }
}


