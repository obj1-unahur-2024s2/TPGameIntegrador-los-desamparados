import wollok.game.*

object nave {
    var position = game.at(25,10) // aca se seta la ubicacion inicial del personaje
    method image() = "nave.png" 
    method position() = position
    method moverDerecha(){ // 2do tipo de configuracion de tecla
        position = game.at((game.width() - 1).min(position.x() + 1), position.y()) // aca puse -7 en game.width porque la nave se salia de la imagen. Tiene que ir -1
    }//           el game.width() -1 hace no se pase del tablero a la derecha
    method moverIzquierda(){ // 2do tipo de configuracion de tecla
        position = game.at(0.max(position.x() - 1), position.y()) 
    }//                con eel 0.max hace que el personaje no se de la ubicacion mas a la izquierda
    method disparar(unEnemigo){
        const tiro = new Disparo(position = position.up(1))
        game.addVisual(tiro)
        tiro.desplazarse(unEnemigo)
        tiro.moverseArriba()
    }
}

class Disparo{
    var position = nave.position()
    const property poderDisparo = 20 
    method image() = "disparo.png" 
    method position() = position
    method moverDisparo() {
        position = game.at(position.x(), position.y() + 1)
    }

    method desplazarse(enemigo) {
        game.onTick(10, "disparar", {
            self.moverDisparo()
            game.onCollideDo(self, { enemigo => 
                enemigo.quitarVida(self) // Llamamos a quitarVida() solo en el enemigo
                self.eliminarDisparo()
            })
        })
    }
    method moverseArriba(){
        if (game.height() - 1 == position)
        game.removeVisual(self)
    }
    method eliminarDisparo(){
        game.removeVisual(self)
    }
}