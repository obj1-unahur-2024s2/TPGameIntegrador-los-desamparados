import wollok.game.*

class Numeros{
    var property position = game.at(1 , game.height() - 1)
    var property image
}


object puntaje{
    method digitos(unNumero) {
        return (0.. unNumero.digits()-1).map({ index => unNumero.toString().charAt(index) + ".png" })
    }
    method mostrarPuntaje(unNumero){
        const listaDeNumeros = self.digitos(unNumero)
        return self.crearListaDeNumeros(listaDeNumeros)
        
    }
    method crearListaDeNumeros(lista){
        const listaNueva = []
        listaNueva.add(new Numeros(image = lista.first(), position = game.at(0, game.height() - 1)))
        lista.remove(lista.first())
        listaNueva.add (new Numeros(image = lista.first(), position = game.at(1 , game.height() - 1)))
        lista.remove(lista.first())
        listaNueva.add (new Numeros(image = lista.first(), position = game.at(2 , game.height() - 1)))
        lista.remove(lista.first())
        return listaNueva
    }
}