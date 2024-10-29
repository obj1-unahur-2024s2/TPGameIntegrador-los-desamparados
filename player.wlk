import wollok.game.*
object nave {
    var position = game.at(25,10) // aca se seta la ubicacion inicial del personaje
    method image() = "nave.png" 
    method position() = position
    method moverseA(nuevaPoscion){
        position = nuevaPoscion
    }
    method moverDerecha(){ // 2do tipo de configuracion de tecla
        position = game.at((game.width() - 1).min(position.x() + 1), position.y())
    }//           el game.width() -1 hace no se pase del tablero a la derecha
    method moverIzquierda(){ // 2do tipo de configuracion de tecla
        position = game.at(0.max(position.x() - 1), position.y()) 
    }//                con eel 0.max hace que el personaje no se de la ubicacion mas a la izquierda
}