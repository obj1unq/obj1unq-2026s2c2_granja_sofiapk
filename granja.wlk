import wollok.game.*
import cultivos.*

object mercado {
	const property position = game.at(5,5)
	const property image = "mercado.png"
}

object granja {
	const property cultivos = #{}

	method plantar(cultivo, position) {
		self.validarPlantar(cultivo, position)
		cultivo.position(position)
		cultivos.add(cultivo)
		game.addVisual(cultivo)
	}
	method validarPlantar(cultivo, position) {
		if ( not self.puedePlantar(cultivo, position) ) {
			self.error("No se puede plantar")
		}
	}
	method puedePlantar(cultivo, position) {
		return not cultivos.contains(cultivo) and not self.hayCultivo(position)
	}
	method hayCultivo(position) {
		return cultivos.any( {cultivo => cultivo.position() == position} )
	}

	method regarEn(posicionActual) {
		self.validarRegar(posicionActual)
        self.regarCultivoEn(posicionActual)
    }
	
	method validarRegar(posicionActual) {
		if ( not self.hayCultivo(posicionActual) ){
			self.error("No tengo nada para regar")
		}
	}

	method regarCultivoEn(posicionActual) {
		self.cultivoEn(posicionActual).serRegado()
	}

	method cultivoEn(position) { // me da el cultivo que este en la position
		return cultivos.find( { cultivo => cultivo.position() == position } )
	}
}