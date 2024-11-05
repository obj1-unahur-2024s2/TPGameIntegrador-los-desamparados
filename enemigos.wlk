import player.*
import wollok.game.*

class Enemigo{
    var property position // aca se seta la ubicacion inicial del personaje

    method position() = position
    method moverse(nuevaPos){
        position = nuevaPos
    }
    method quitarVida(unDisparo) {
        self.eliminar()
    }
    method moveteDerecha() {
        position = position.right(1)
    }

    method moveteIquierda() {
        position = position.left(1)
    }

    method estoyBordeDerecho()= position.x() == game.width() - 1
    method estoyBordeIzquierdo()= position.x() == 0

    method eliminar(){
        game.removeVisual(self)
    }
}

class EnemigoDevil inherits Enemigo{
    method image() = "Enemigo.png" 

}

class EnemigoMediano inherits Enemigo{
    method image() = "Enemigo1.png" 
}

class EnemigoFuerte inherits Enemigo{
    method image() = "Enemigo2.png" 
}