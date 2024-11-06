class Posicionable {
    var property position 
    var orientacion 
    method position() = position
    
    method moverse() {
        self.mover()
        if(self.llego())
            self.cambiarDireccion()
    }

    method mover() {
        position = orientacion.siguiente(position)

    }
    method llego() =
        orientacion.enElBorde(position) 

    
    method cambiarDireccion() {
        orientacion = orientacion.opuesto()
    }
}

object up{
    method opuesto() = down
    method siguiente(position) = position.up(1)
    method enElBorde(position) = position.y() >= game.height()-1
}
object right{
    method opuesto() = left
    method siguiente(position) = position.right(1)
    method enElBorde(position) = position.x() >= game.width()-1
}

object down{
    method opuesto() = up
    method siguiente(position) = position.down(1)
    method enElBorde(position) = position.y() <= 0
}

object left{
    method opuesto() = right
    method siguiente(position) = position.left(1)
    method enElBorde(position) = position.x() <= 0
}