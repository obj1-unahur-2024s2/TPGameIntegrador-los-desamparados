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
        juego.aumentarPuntuacion() //esto lo que hace es eliminar al enemigo de la lista
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