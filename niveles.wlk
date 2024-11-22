import wollok.game.*
import player.*
import enemigos.*
import posicionable.*
import visuales.*

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
        self.agregarEnemigos()
        game.onTick(100,"pasarNivel", { 
            if (puntuacion == enemigos.size()){ 
                self.IniciarSegundoNivel()
                game.removeTickEvent("pasarNivel")
                }
            }
        )
    }

    method configurarTeclas(){
		keyboard.d().onPressDo({nave.moverDerecha()})
		keyboard.a().onPressDo({nave.moverIzquierda()})
		keyboard.w().onPressDo({nave.disparar()})
        keyboard.space().onPressDo({game.stop()})
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
    
    method agregarJefes() {
        enemigos.add(new EnemigoJefe(position = game.at(2,12), orientacion = right))
        enemigos.add(new EnemigoJefe(position = game.at(4,8), orientacion = left))
        enemigos.add(new EnemigoJefe(position = game.at(6,4), orientacion = right))
    }

    method prepararPresentacion(){
		game.title("Galaga")
	    game.width(14)
	    game.height(18)
	    game.boardGround("fondoVacio462px.png")
	    game.cellSize(35) 
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
        self.configurarTeclas()
    }

    method IniciarSegundoNivel() { 
        enemigos.clear()
        puntuacion = 0
        self.agregarJefes()
        enemigos.forEach({e => 
            game.addVisual(e)
            e.movimiento() // se agrego los movimientos al jefe
            e.inicializar()
        })
        game.onTick(100,"final", { 
            if (puntuacion == enemigos.size()){ 
                self.mostrarFinal()
                game.removeTickEvent("final")
                }
            }
        )
    }

    method mostrarFinal() {
        game.clear()
        game.title("Galaga")
	    game.width(20)
	    game.height(25)
	    game.boardGround("fondoVacio462px.png")
	    game.cellSize(42)
        game.addVisual(imagenFinal)
    }
}