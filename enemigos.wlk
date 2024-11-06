import player.*
import wollok.game.*
import niveles.*
import posicionable.*

class Enemigo inherits Posicionable{

    method inicializar(){
        game.onCollideDo(self, { disparo => 
            self.quitarVida(disparo) 
            disparo.eliminarDisparo()
        })
        game.onTick(300, "evenName" + 0.randomUpTo(10), {
            self.moverse()
        })
    }
  
    method quitarVida(unDisparo) {
        self.eliminar()
    }
 
    method eliminar(){
        game.removeVisual(self)
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