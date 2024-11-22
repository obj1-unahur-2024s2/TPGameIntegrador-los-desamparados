import player.*
import wollok.game.*
import niveles.*
import posicionable.*

class Enemigo inherits Posicionable{

    const eventName = "EvenName-" + (0..100).anyOne()
    method inicializar(){
        game.onCollideDo(self, { disparo => 
            self.quitarVida(disparo) 
            disparo.eliminarDisparo()
        })
        game.onTick(300, eventName, {
            self.moverse()
        })

    }

    method quitarVida(unDisparo) {
        self.eliminar()
    }
    
    method eliminar(){
        game.removeVisual(self)
        game.removeTickEvent(eventName)
        self.sonidoMuerte()
        juego.aumentarPuntuacion()
    }

    method sonidoMuerte(){	
		const muerte = game.sound("enemigoMuerte.mp3")
			muerte.play()
			muerte.volume(0.5)
	}

}

class EnemigoDevil inherits Enemigo{
    method image() = "enemigo60px.png" 

}

class EnemigoMediano inherits Enemigo{
    method image() = "enemigoA60px.png" 
}

class EnemigoFuerte inherits Enemigo{
    method image() = "enemigoB60px.png" 
}

class EnemigoJefe inherits Enemigo{
    var vida = 5
    var property image = "jefeB200px.png" // se cambio el metodo image() por un var property

    override method quitarVida(unDisparo) {
        if (vida == 0){
            self.eliminar()
            game.removeTickEvent(eventName) // se agrego el removedor de tick
        }else{
            self.bajarVida()
        }
    }

    method bajarVida() {
        vida = 0.min(vida - 1)
    }

    method movimiento(){ // se creo el metodo para que se mueva el jefe
        game.onTick(1000, eventName, {
            game.removeVisual(image)
            if (image == "jefeA200px.png"){
                image = "jefeB200px.png"
            }else{
                image = "jefeA200px.png"
            }
            game.addVisual(image)
        })
    }
}