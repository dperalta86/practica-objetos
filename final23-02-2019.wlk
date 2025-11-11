/*
Final 23/02/2019
https://docs.google.com/document/d/1kKkHs8ARJKfsRcp5J6_49DDhJR4gUFysBykFu7yTeQI/edit?tab=t.0

ejercicio 1
a_ FALSO. Empresa conoce "demasiado"
b_ DUDA...EL uso del polimorfismo sintácticamente está bien
  pero pierde sentido semántico para nuestra solución, sería
  conveniente manejar polimorfismo mediante composición.
c_ VERDADERO. Se asume que existe un atributo tipoPlan.
    var tipoPlan = (new PlanNormal) con un getter asociado, para cambiar de plan
    method cambiarPlan (nuevoPlan){
      tipoPlan = nuevoPlan
    }
d_ VERDADERO. Centrándonos en esta solución y su diseño (sin uso de excepciones)
*/

// ejercicio 2
class Empresa{
  var productos = []

  method productos() = productos
  
  method vendeProducto(producto, cliente){
    if (self.hayStock(producto)){
      cliente.pagaCompra(producto.costo())
      self.sacaDeStock(producto)
    }else{
      throw new Exception(message="No hay stock disponible del producto.")
    }
  }
  
  method hayStock(producto) = productos.contains(producto)
  
  method sacaDeStock(producto){
    try
      productos.remove(producto)
    catch e: Exception {
      console.println("Error al intentar sacar del stock producto:" + producto)
    }
  }
}

class Producto{
  const nombreProducto
  var precio

  method costo() = precio
}

class Cliente {
  var dineroDisponible = 0
  var tipoCliente = new TipoRegular(descuento = 0.1)

  method dineroDisponible() = dineroDisponible

  method cambiarTipoCliente(nuevoTipo){
    tipoCliente = nuevoTipo
  }
  
  method pagaCompra(costo){
    tipoCliente.pagar(costo, self) // Entiendo que no se rompe encapsulamiento por
                                               // por ya existir acoplamiento...
  }

  method disminuirDinero(cantidadADisminuir) {
    dineroDisponible -= cantidadADisminuir    
  }
}

class TipoCliente{
  var primerVenta = true
  const descuento // Obligo a inicializar en cada tipo de cliente
  var costoConDescuento = 0

  method pagar(costo, cliente) {
    costoConDescuento = costo
    self.aplicaDescuento()

    if(cliente.dineroDisponible() >= costoConDescuento){
      cliente.disminuirDinero(costoConDescuento)
    }else{
      throw new Exception(message = "El cliente no dispone de dinero disponible")
    }      
  }

  method aplicaDescuento() // método abstracto

}

class TipoRegular inherits TipoCliente{
  override method aplicaDescuento() {
    if(primerVenta)
      costoConDescuento -= costoConDescuento * descuento
      primerVenta = false
  }
}

class TipoVip inherits TipoCliente{
  override method aplicaDescuento() {
      costoConDescuento -= costoConDescuento * descuento
  }
}