import wollok.game.*
import player.*
import enemigos.*

object nivelUno {
    const property enemigos = []

    method agregarEnemigos() {
        enemigos.add(new EnemigoFuerte(position = game.at(5,30)))
        enemigos.add(new EnemigoMediano(position = game.at(15,40)))
        enemigos.add(new EnemigoDevil(position = game.at(25,20)))
    }

    method agregarVisuales() {
        enemigos.forEach({e => game.addVisual(e)})
    }

    method agregarControles() {
       enemigos.forEach({e => controlEnemigo.cambiarDireccionDerecha(e)}) 
    }

    method initialize() {
        self.agregarEnemigos()
        self.agregarVisuales()
        self.agregarControles()
        game.addVisual(nave)
        game.boardGround("3ta.gif")
        configurarTeclas.iniciarNave()
    }

    method iniciar(){
	    keyboard.w().onPressDo({
            nave.disparar(enemigos.first())
        })
        
    }
}

object configurarTeclas{
	method iniciarNave(){ // metodo implementado para iniciar la nave
		keyboard.d().onPressDo({nave.moverDerecha()})
		keyboard.a().onPressDo({nave.moverIzquierda()})
	}
}

object controlEnemigo {
    method cambiarDireccionIzquierda(unEnemigo){
        game.onTick(250, "izquierda", {
            unEnemigo.moveteIquierda()
            if (unEnemigo.estoyBordeIzquierdo()){
                game.removeTickEvent("izquierda")
                self.cambiarDireccionDerecha(unEnemigo)
            }
        })
    }

    method cambiarDireccionDerecha(unEnemigo){
        game.onTick(250, "derecha", {
            unEnemigo.moveteDerecha()
            if (unEnemigo.estoyBordeDerecho()){
                game.removeTickEvent("derecha")
                self.cambiarDireccionIzquierda(unEnemigo)
            }
        })
    }
}