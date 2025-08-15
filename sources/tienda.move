module tienda::tienda{
    //Importamos las librerias o funciones a utilizar
    use std::string::String;
    //Self: Se importa vec_map a si misma
    //También se puede utilizar empty
    //use sui::vec_map::{VecMap, empty};
    use sui::vec_map::{VecMap, Self};
    
    const ID_YA_EXISTE: u64 = 1;

    //Se utiliza key ya que este objeto se va a almacenar en una cuenta
    public struct Tienda has key{
        id: UID,
        //Uso VecMap para poder almacenar el id del prodcuto
        productos: VecMap<u64, Producto>
    }
    //Defino los objetos que utilizaré en esta tienda
    //Utilizan store ya que estos objetos se van a almacenar en el VecMap
    public struct Producto has store{
        nombreProducto: String,
        precioProducto: u16, 
        talleProducto: String,
        tipoProducto: String,
        cantidadProducto: u16,
        productoDisponible: bool,
    }


    //función para crear la tienda
    #[allow(lint(self_transfer))]
    public fun crear_tienda(ctx: &mut TxContext){
        let tienda = Tienda {
            //ID con el contexto de la transacción (Objeto que pasaremos a la blockchain)
            id: object::new(ctx),
            
            //Creamos el objeto de productos vacío ya que justamente se esta creando
            // Una forma: productos: empty(), utilizo Self (vec_map) para saber que estoy creando
            productos: vec_map::empty(),
        };

        //Transferir tienda (Que transfiero (tienda porque tiene key), A dónde lo transfiero (Persona que ejecuta la función))
        transfer::transfer(tienda, ctx.sender());
    }

    //Función para agregar productos a la tienda
    //Se manda Tienda ya que los productos se van a agregar allí
    //Se manda identificador ya que cuando definimos que la tienda utilizaría productos utilizamos VecMap
    //Si se agrega otro producto con el mismo ID se cancela la operación
    public fun agregar_producto(tienda: &mut Tienda, identificador: u64, nombreProducto: String, precioProducto: u16, talleProducto: String, tipoProducto: String, cantidadProducto: u16){
        //Validar que id no este en tienda, espero que no obtenga ese valor (!)
        assert!(!tienda.productos.contains(identificador), ID_YA_EXISTE);
        //Producto creado con sus datos
        let producto = Producto {
            //nombreProducto = nombreProducto
            nombreProducto,
            precioProducto, talleProducto, tipoProducto, cantidadProducto, productoDisponible: true
        };
        //Se pone productoDisponible  : true ya que cuando se agrega un producto nuevo va a estar disponible

        //Meter producto a la tienda
        tienda.productos.insert(identificador, producto);
    }

    //Hacer funcion por cada uno de los atributos
    //Identificador del producto
    public fun modificar_nombre_producto (tienda: &mut Tienda, identificador: u64, nombreProductoNuevo: String){
        //Validar que existe ID (SI EXISTE ESE ID, SI NO EXISTE ABORTAR LA FUNCIÓN (NO PUEDO EDITAR NOMBRE DE UN PRODUCTO QUE NO EXISTE))
        //assert!(!tienda.productos.contains(identificador), ID_YA_EXISTE);

        //Producto a editar
        //Get_mut ya que permite editar mutables(Pide referencia (&))
        let producto = tienda.productos.get_mut(&identificador);

        producto.nombreProducto = nombreProductoNuevo;
    }

    //Función eliminar producto
    //Identificador del producto
    public fun eliminar_producto(tienda: &mut Tienda, identificador: u64){
        tienda.productos.remove(identificador);
    }

    //Función eliminar tienda
    //No se pasa referencia porque se ocupa el objeto Tienda
    public fun eliminar_tienda(tienda: Tienda){
        //Desestructura Struct (objeto) y asigna a cada uno de los valores que tenia el Struct a una variable, _ = ignorar
       let Tienda {id, productos: _ } = tienda;
       id.delete();
    }
}

//sui client envs
//sui client switch --env testnet 
//sui client faucet
//sui client balance
//Función: sui client call --package 0x7329d7de534cdbe5282edfcc8c51a82cf38fea397d7648f2b3df8757bef91750(PackageID) --module tienda(Nombre del módulo) --function crear_tienda(Función a utilizar)
//Función: sui client call --package 0x7329d7de534cdbe5282edfcc8c51a82cf38fea397d7648f2b3df8757bef91750(PackageID) --module tienda(Nombre del módulo) --function agregar_producto(Función a utilizar) --args 0x391958acdd4cf3e1dab120024028291479f0cb9795a04fd4420d8595136f229d 123 "Zapatillas Adidas Samba" 150 "45" "Zapatillas" 10 (argumentos) 
