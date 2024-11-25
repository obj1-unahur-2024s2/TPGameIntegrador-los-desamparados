import visuales.*
import player.*
import wollok.game.*
import niveles.*
import posicionable.*
import puntuaciones.*


class Enemigo inherits Posicionable{
    var property image
    const eventName = "EvenName-" + (0..100).anyOne()
    method inicializar(){
        game.onCollideDo(self, { disparo =>
            juego.puntuacionTotal(juego.puntuacionTotal() + self.puntuacion())
            //puntaje.mostrarPuntaje(juego.puntuacionTotal()).forEach({p => game.addVisual(p)})
            puntaje.nuevaPuntuacion(juego.puntuacionTotal())
            self.quitarVida(disparo)
            disparo.eliminarDisparo()
        })
        game.onTick(300, eventName, {
            self.moverse()
        })
    }

    method puntuacion()

    method quitarVida(unDisparo) { 
        self.eliminar()
    }

    method eliminar(){
        self.muerte()
        //game.removeVisual(self)
        game.removeTickEvent(eventName)
        self.sonidoMuerte()
        juego.aumentarPuntuacion()
    }

    method sonidoMuerte(){	
		const muerte = game.sound("enemigoMuerte.mp3")
			muerte.play()
			muerte.volume(0.5)
	}

    method muerte(){
        image = "colision60px.png"
        game.onTick(200, "muerte", {
            game.removeVisual(self)
            game.removeTickEvent("muerte")
        })
    }
}

class EnemigoDevil inherits Enemigo(image= "enemigo60px.png"){
    //method image() = "enemigo60px.png" 
    override method  puntuacion() = 10
}

class EnemigoMediano inherits Enemigo(image= "enemigoA60px.png"){
    //method image() = "enemigoA60px.png" 
    override method  puntuacion() = 20
}

class EnemigoFuerte inherits Enemigo(image= "enemigoB60px.png"){
    //method image() = "enemigoB60px.png" 
    override method  puntuacion() = 40
}

class EnemigoJefe inherits Enemigo(image= "jefeB200px.png"){
    var alternar = false
    var vida = 5
    //var property image = "jefeB200px.png" 

    override method  puntuacion() = 70

    override method quitarVida(unDisparo) {
        if (vida == 0){
            self.eliminar()
            game.removeTickEvent(eventName) 
        }else{
            self.bajarVida()
        }
    }

    method bajarVida() {
        vida = 0.min(vida - 1)
    }

    method movimiento(){ 
        game.onTick(400, eventName, {
            self.siguienteImagen()
        })
    }

    method siguienteImagen(){
        alternar = !alternar
        image = if(alternar){"jefeB200px.png"} else {"jefeA200px.png"}
    }

    override method sonidoMuerte(){
        const muerte1 = game.sound("muerteEnemigo2.mp3")
			muerte1.play()
			muerte1.volume(0.5)
    }
}