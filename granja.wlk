import wollok.game.*
import cultivos.*
import personaje.*

object mercado {
	const property position = game.at(3,2)
	const property image = "mercado.png"

	method interactuar(personaje) {
        personaje.vender()
    }
}

object granja {
	const property cultivos = #{}
	const property plantasCosechadas = #{}
	var property oroAcumulado = 0

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
		return not cultivos.contains(cultivo) and self.parcelaDisponible(position)
	}

	method parcelaDisponible(position) {
		return not self.hayCultivo(position) and position != mercado.position()
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
			self.error("No hay nada para regar")
		}
	}

	method regarCultivoEn(posicionActual) {
		self.cultivoEn(posicionActual).serRegado()
	}

	method cultivoEn(position) { // me da el cultivo que este en la position
		return cultivos.find( { cultivo => cultivo.position() == position } )
	}

	method cosecharEn(position) {
		self.validarCosechar(position)
		self.cosecharCultivo( self.cultivoEn(position) )
	}

	method validarCosechar(position) {
		if ( not self.hayCultivo(position) || not self.cultivoEstáListoParaCosechar(position) ){
			self.error("Aún no se puede cosechar")
		}
	}

	method cultivoEstáListoParaCosechar(position) {
		return self.cultivoEn(position).estáListoParaSerCosechado()
	}

	method cosecharCultivo(cultivoACosechar) {
		plantasCosechadas.add(cultivoACosechar)
		cultivos.remove(cultivoACosechar)
		game.removeVisual(cultivoACosechar)
	}

	method cantidadDePlantasCosechadas() {
		return plantasCosechadas.size()
	}

	method valorTotalPlantasCosechadas() {
		return plantasCosechadas.sum( { planta => planta.valor() } )
	}

	method venderCosecha() {
		self.validarVenta()
		oroAcumulado += self.valorTotalPlantasCosechadas()
		plantasCosechadas.clear()
	}

	method validarVenta() {
		if ( plantasCosechadas.isEmpty() ){
			self.error("No hay cultivo para vender")
		}
	}
}