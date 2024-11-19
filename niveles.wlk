import wollok.game.*
import player.*
import enemigos.*
import posicionable.*
import visuales.*

// cuando se crean los enemigos, se ingresan a la lista de enemigos. lo que habria que hacer es que a medida que se van eliminando los enemigos, la lista se valla vaciando y cuando la lista
// esta vacia ahi que cambie el siguiente nivel.


object juego {
    const property enemigos = []
    var puntuacion = 0
    
    method presentarMenu() {
        self.prepararPresentacion()
        keyboard.enter().onPressDo({
            game.removeVisual(imagenInicial)
            self.iniciarJuego()
        })
    }

    method iniciarJuego() {
        self.prepararNivel()
        self.nivelUno()
    }


    method nivelUno(){
        self.agregar
        game.onTick(100,"pasarNivel", { //con este on tick esta constantemente preguntando si la lista esta vacia para cambiar al proximo nivel, revisar dado que no se si esta correcto, 
            if (puntuacion == enemigos.size()){ // pero calculo que si es correcto
                self.nivelDos()
                game.removeTickEvent("pasarNivel")
                }
            }
        )
    }

    method agregarEnemigos() {
        const enemigoDevil = 
        enemigos.add(new EnemigoMediano(position = game.at(2,13), orientacion = right))
        enemigos.add(new EnemigoFuerte(position = game.at(12,12), orientacion= left))
        enemigos.add(new EnemigoDevil(position = game.at(5,11), orientacion=right))
        enemigos.add(new EnemigoMediano(position = game.at(7,10), orientacion=left))
        enemigos.add(new EnemigoDevil(position = game.at(5,9), orientacion=right))
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

    method aumentarPuntuacion(){
        puntuacion += 1
    }
    method puntuacion() = puntuacion

    method nivelDos() {
        enemigos.clear()
        self.agregarEnemigos()    
        game.onTick(100,"final", {
            if (puntuacion == enemigos.size()){
                game.clear()
                game.title("Galaga")
	            game.width(14)
	            game.height(18)
	            game.boardGround("gameOver462px.png")
	            game.cellSize(42) 
                game.removeTickEvent("final")
            }
        })
    }














































    method prepararPresentacion(){
		game.title("Galaga")
	    game.width(14)
	    game.height(18)
	    game.boardGround("fondoVacio462px.png")
	    game.cellSize(42) 
		game.addVisual(imagenInicial)
	}

    method prepararNivel() {
        game.title("Galaga")
	    game.width(14)
	    game.height(18)
	    game.boardGround("fondoVacio462px.png")
	    game.cellSize(42)
        self.sonidoInicio()
        game.addVisual(nave)
    }




}