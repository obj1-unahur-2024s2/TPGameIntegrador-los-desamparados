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
        self.agregarEnemigos()
        game.onTick(100,"pasarNivel", { //con este on tick esta constantemente preguntando si la lista esta vacia para cambiar al proximo nivel, revisar dado que no se si esta correcto, 
            if (puntuacion == enemigos.size()){ // pero calculo que si es correcto
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
            e.inicializar()
        })
        game.onTick(100,"final", { //con este on tick esta constantemente preguntando si la lista esta vacia para cambiar al proximo nivel, revisar dado que no se si esta correcto, 
            if (puntuacion == enemigos.size()){ // pero calculo que si es correcto
                self.mostrarFinal()
                game.removeTickEvent("final")
                }
            }
        )
    }

    method mostrarFinal() {
        game.clear()
        game.title("Galaga")
	    game.width(14)
	    game.height(18)
	    game.boardGround("fondoVacio462px.png")
	    game.cellSize(42)
        game.addVisual(imagenFinal)
    }
}