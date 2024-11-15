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
    }

    method sonidoMuerte(){	
		const muerte = game.sound("enemigoMuerte.mp3")
			muerte.play()
			muerte.volume(0.5)
	}

}

class EnemigoDevil inherits Enemigo{
    method image() = "Enemigo.png" 

}

class EnemigoMediano inherits Enemigo{
    method image() = "Enemigo1.png" 
}

class EnemigoFuerte inherits Enemigo{
    method image() = "Enemigo2.png" 
}