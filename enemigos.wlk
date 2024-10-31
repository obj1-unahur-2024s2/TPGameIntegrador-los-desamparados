import player.*
import wollok.game.*
class Enemigo{
    var vida = 100
    var property position // aca se seta la ubicacion inicial del personaje
    method vida() = vida
    method position() = position
    method moverse(nuevaPos){
        position = nuevaPos
    }
    method quitarVida() {
        vida = 0.max(vida - Disparo.poderDisparo())
        if (vida <= 0) {
            game.removeVisual(self) // Elimina el enemigo si la vida llega a 0
        }
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
        if (vida == 0) game.removeVisual(self)
    }
}

class EnemigoDevil inherits Enemigo{
    method image() = "Enemigo.png" 
    override method quitarVida(){
        vida -= super() * 5
    }
}

class EnemigoMediano inherits Enemigo{
    method image() = "Enemigo1.png" 
    override method quitarVida(){
        vida -= super() * 3
    }
}

class EnemigoFuerte inherits Enemigo{
    method image() = "Enemigo2.png" 
    override method quitarVida(){
        vida -= super() / 2
    }
}