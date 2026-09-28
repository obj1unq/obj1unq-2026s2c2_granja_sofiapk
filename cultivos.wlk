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
}

object trigoEv0 {
    method cuerpo() {
        return "0"
    }

    method siguienteEtapa() {
        return trigoEv1
    }
}

object trigoEv1 {
    method cuerpo() {
        return "1"
    }

    method siguienteEtapa() {
        return trigoEv2
    }
}

object trigoEv2 {
    method cuerpo() {
        return "2"
    }

    method siguienteEtapa() {
        return trigoEv3
    }
}

object trigoEv3 {
    method cuerpo() {
        return "3"
    }

    method siguienteEtapa() {
        return trigoEv0
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
}

object maízBebé {
    method cuerpo() { 
        return "bebe"
    }
}

object maízAdulto {
    method cuerpo() { 
        return "adulto"
    }
}