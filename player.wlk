import posicionable.*
import wollok.game.*

object nave inherits Posicionable(orientacion=left, position=game.origin()){
    var disparosEnTablero = 0
    const rango = (0..10000)

    method image() = "nave.png" 
        
    method disparar(){
        if(disparosEnTablero<=5) {
            const tiro = new Disparo(position = position.up(1), orientacion=up, eventName="E-" + rango.anyOne())
            disparosEnTablero += 1
            game.addVisual(tiro)
        }
    }

    override method moverse() {
        if(!self.llego())
            self.mover()
    }

    method moverDerecha(){ 
        orientacion= right
        self.moverse()
    }

    method moverIzquierda(){ 
        orientacion= left
        self.moverse()
    }

    method notificarDisparoEliminado() {
        disparosEnTablero -= 1
    }
}

class Disparo inherits Posicionable{

    const property poderDisparo = 20 
    const property eventName 
    method image() = "disparo.png" 
   
    method initialize() {
        game.onTick(100, eventName , {
            self.moverse()
        })
    }
    method eliminarDisparo(){
        game.removeTickEvent(eventName)
        game.removeVisual(self) 
        nave.notificarDisparoEliminado() 
    }

    override method moverse() {
        if( not self.llego())
            self.mover()
        else
            self.eliminarDisparo()
    }
}

