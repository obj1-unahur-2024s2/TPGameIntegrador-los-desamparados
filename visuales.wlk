object imagenInicial {
    var property position = game.at(0,0)
	var property image = "inicio462px.png"
}

object imagenFinal {
    var property position = game.at(0,0)
	var property image = "imagenFinal462px.png"
}

object pos1 {
    var property position = game.at(1,17)
	var property image = "0.png"
    method ubicacionFinal(){
        self.position(game.at(3,16))
        return self
    }
}

object pos2 {
    var property position = game.at(2,17)
	var property image = "0.png"
    method ubicacionFinal(){
        self.position(game.at(4,16))
        return self
    }
}

object pos3 {
    var property position = game.at(3,17)
	var property image = "0.png"
    method ubicacionFinal(){
        self.position(game.at(5,16))
        return self
    }
}