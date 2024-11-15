import wollok.game.*
import player.*
import enemigos.*
import posicionable.*


// cuando se crean los enemigos, se ingresan a la lista de enemigos. lo que habria que hacer es que a medida que se van eliminando los enemigos, la lista se valla vaciando y cuando la lista
// esta vacia ahi que cambie el siguiente nivel.
object nivelUno {
    const property enemigos = []
  
    method inicializar(){
        self.sonidoInicio()
        game.addVisual(nave)
        self.agregarEnemigos()
        self.configurarTeclas()
        game.onTick(100,"pasarNivel", { //con este on tick esta constantemente preguntando si la lista esta vacia para cambiar al proximo nivel, revisar dado que no se si esta correcto, 
            if (self.enemigodEliminados()){ // pero calculo que si es correcto
            nivelDos.inicializar()
            game.removeTickEvent("pasarNivel")
            }
        })
    }

    method agregarEnemigos() {
        enemigos.add(new EnemigoMediano(position = game.at(2,13), orientacion = right))
        enemigos.add(new EnemigoFuerte(position = game.at(12,12), orientacion= left))
        enemigos.add(new EnemigoDevil(position = game.at(5,11), orientacion=right))
        enemigos.add(new EnemigoMediano(position = game.at(7,10), orientacion=left))
        enemigos.forEach({e => 
            game.addVisual(e)
            e.inicializar()  
        })
    }

    method configurarTeclas(){
		keyboard.d().onPressDo({nave.moverDerecha()})
		keyboard.a().onPressDo({nave.moverIzquierda()})
		keyboard.w().onPressDo({nave.disparar()})
    }

    method sonidoInicio(){	
		const inicio = game.sound("inicio.mp3")
		inicio.play()
		inicio.volume(0.5)
	}
    method eliminarEnemigo(unEnemigo){ // aca habria que configurar o ver cual es la instancia de enemigo creada al momento que el disparo le pega para eliminarlo de la lista!!
        enemigos.remove(unEnemigo)     // nose si se puede poner enemigos.remove().first() que es para que elimine el primer enemigo de la lista
    }
    method enemigodEliminados(){
        return enemigos.size() == 0
    }
}

object nivelDos {
    method inicializar(){

    }
}
