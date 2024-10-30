import wollok.game.*
object nave {
    var position = game.at(25,10) // aca se seta la ubicacion inicial del personaje
    method image() = "nave.png" 
    method position() = position
    method moverseA(nuevaPoscion){ // 1er tipo de configuracion de teclas
        position = nuevaPoscion
    }
    method moverDerecha(){ // 2do tipo de configuracion de tecla
        position = game.at((game.width() - 7).min(position.x() + 1), position.y()) // aca puse -7 en game.width porque la nave se salia de la imagen. Tiene que ir -1
    }//           el game.width() -1 hace no se pase del tablero a la derecha
    method moverIzquierda(){ // 2do tipo de configuracion de tecla
        position = game.at(0.max(position.x() - 1), position.y()) 
    }//                con eel 0.max hace que el personaje no se de la ubicacion mas a la izquierda
    method disparar(){
        const tiro = new Disparo(position = position.up(1))
        game.addVisual(tiro)
        tiro.desplazarse()
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

    method desplazarse(){
        game.onCollideDo(self, {accion => accion.quitarVida()})
        game.onTick(50, "disparar",{self.moverDisparo()})
    }
    method moverseArriba(){
        if (position.y() > game.height()){
            game.removeTickEvent("disparar")
            game.removeVisual(self)}
    }
}