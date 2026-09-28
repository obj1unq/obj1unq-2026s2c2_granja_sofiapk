import wollok.game.*
import granja.*
import cultivos.*

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
	
}