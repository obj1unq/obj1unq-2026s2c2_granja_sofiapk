import wollok.game.*
import granja.*

// TOMACO
object tomaco {
    var property position = game.origin()

    method image() {
        return "tomaco.png"
    }

    method serRegado() { 
        if ( not granja.hayCultivo( self.posicionCeldaObjetivo() ) ){
            position = self.posicionCeldaObjetivo()
        }
    }

    method posicionCeldaObjetivo() {
        return if ( self.y() == self.filaMásAlta() ){
            self.pasarAFilaMásBaja()
        } else {
            self.position().up(1) // se mueve a la celda superior
        }
    }

    method pasarAFilaMásBaja() {
        return game.at( self.x(), 0 )
    }

    method filaMásAlta() {
        return game.height() - 1
    }

    method x() {
        return self.position().x()
    }

    method y() {
        return self.position().y()
    }

    method estáListoParaSerCosechado() {
        return true
    }

    method valor() {
        return 80
    }
}

// TRIGO
object trigo {
    var property position = game.origin()
    var property etapa = trigoEv0
    
    method image() {
        return "trigo_" + etapa.cuerpo() + ".png"
    }

    method serRegado() {
        etapa = etapa.siguienteEtapa()
    }

    method estáListoParaSerCosechado() {
        return etapa.estáListoParaSerCosechado()
    }

    method valor() {
        return etapa.valor()
    }
}

object trigoEv0 {
    method cuerpo() {
        return "0"
    }

    method siguienteEtapa() {
        return trigoEv1
    }

    method estáListoParaSerCosechado() {
        return false
    }

    method valor() {
        return 0
    }
}

object trigoEv1 {
    method cuerpo() {
        return "1"
    }

    method siguienteEtapa() {
        return trigoEv2
    }

    method estáListoParaSerCosechado() {
        return false
    }

    method valor() {
        return 0
    }
}

object trigoEv2 {
    method cuerpo() {
        return "2"
    }

    method siguienteEtapa() {
        return trigoEv3
    }

    method estáListoParaSerCosechado() {
        return true
    }

    method valor() {
        return 100
    }
}

object trigoEv3 {
    method cuerpo() {
        return "3"
    }

    method siguienteEtapa() {
        return trigoEv0
    }

    method estáListoParaSerCosechado() {
        return true
    }

    method valor() {
        return 200
    }
}

// MAIZ 
object maíz {
    var property position = game.origin()
    var property estado = maízBebé

    method image() {
        return "maiz_" + estado.cuerpo() + ".png"
    }

    method serRegado() {
        estado = maízAdulto
    }

    method estáListoParaSerCosechado() {
        return estado.estáListoParaSerCosechado()
    }

    method valor() {
        return estado.valor()
    }
}

object maízBebé {
    method cuerpo() { 
        return "bebe"
    }

    method estáListoParaSerCosechado() {
        return false
    }

    method valor() {
        return 150
    }
}

object maízAdulto {
    method cuerpo() { 
        return "adulto"
    }

    method estáListoParaSerCosechado() {
        return true
    }

    method valor() {
        return 150
    }
}