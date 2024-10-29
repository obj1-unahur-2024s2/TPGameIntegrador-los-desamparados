class Enemigo{
    var vida = 100
    var position // aca se seta la ubicacion inicial del personaje
    method position() = position
    method moverse(nuevaPos){
        position = nuevaPos
    }
    method quitarVida(unValor){
        vida -= unValor
    }
    method moverIzquierda() {
        position = game.at(0.max(position.x() - 1), position.y()) 
    }
    method moverDerecha() {
        position = game.at((game.width() - 1).min(position.x() + 1), position.y())
    }
    method eliminar(){
        game.removeVisual(self)
    }
}

class EnemigoDevil inherits Enemigo{
    method image() = "Enemigo.png" 
    override method quitarVida(unValor){
        vida -= unValor * 5
    }
}

class EnemigoMediano inherits Enemigo{
    method image() = "Enemigo1.png" 
    override method quitarVida(unValor){
        vida -= unValor * 3
    }
}

class EnemigoFuerte inherits Enemigo{
    method image() = "Enemigo2.png" 
    override method quitarVida(unValor){
        vida -= unValor / 2
    }
}