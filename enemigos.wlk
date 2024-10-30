import player.*
class Enemigo{
    var vida = 100
    var position // aca se seta la ubicacion inicial del personaje
    method vida() = vida
    method position() = position
    method moverse(nuevaPos){
        position = nuevaPos
    }
    method quitarVida(){
        vida = 0.max(vida - tiro.poderDisparo())
        game.say(self, "Me queda " + self.vida() + " de salud")
        self.eliminar()
    }
    method moverIzquierda() {
        position = game.at(0.max(position.x() - 1), position.y()) 
    }
    method moverDerecha() {
        position = game.at((game.width() - 1).min(position.x() + 1), position.y())
    }
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