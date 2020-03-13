//
//  Musica.swift
//  musicmix
//
//  Created by Evaldo Garcia de Souza Júnior on 10/03/20.
//  Copyright © 2020 Evaldo Garcia de Souza Júnior. All rights reserved.
//

import Foundation

class Musica {
    var tempo: Int
    var nome: String
    var capa: UIImage
    var artista: String
    
    init(tempoMin: Int, nomeMus: String, artistaMus: String, capaMus: UIImage) {
        tempo = tempoMin
        nome = nomeMus
        capa = capaMus
        artista = artistaMus
    }
}
