import wollok.game.*
import granja.*
import cultivos.*
import direcciones.*

object femenino{
	method prefijo() {
		return "f"
	}
	method otro() {
		return masculino
	}
}
object masculino{
	method prefijo() {
		return "m"
	}
	method otro() {
		return femenino
	}
}

object personaje {
	var property genero = femenino
	var property position = game.center()
	const propiedad = granja

	
	method image() {
		return genero.prefijo() + "-player-" + self.estado() + ".png"
	} 
	method estado() {
		return if ( self.estaSobreAlgo() ) "abajo" else "normal" 
	}
	method estaSobreAlgo() {
		return not game.colliders(self).isEmpty()
	}

	method cambiarGenero() {
		genero = genero.otro()
	}

	method plantar(cultivo) {
	    propiedad.plantar( cultivo, self.position() )
	} 

    method regar() {
        propiedad.regarEn( self.position() )
    }
	
	method cosechar() {
		propiedad.cosecharEn( self.position() )
	}

	method vender() {
		propiedad.venderCosecha()
	}

	method mencionarInfoSobreVenta() {
		game.say( self, self.mensaje() )
	}

	method mensaje() {
		return "Tengo " + self.cantPlantasCosechadasParaVender().toString() + " plantas para vender por " + self.valorAObtenerPorVenta().toString() + " monedas"
	}

	method cantPlantasCosechadasParaVender() {
		return propiedad.cantidadDePlantasCosechadas()
	}

	method valorAObtenerPorVenta() {
		return propiedad.valorTotalPlantasCosechadas()
	}

	method text() {
		return "Tengo " + propiedad.oroAcumulado().toString() + " de oro acumulado"
	}

	method mover(direccion) {
        position = direccion.siguiente(position)
    }

 	method interactuar() {
   		game.colliders(self).forEach( { algo => algo.interactuar(self) } )
 	}
}