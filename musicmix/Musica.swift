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
    var genero: String
    
    init(tempoMin: Int, generoMus: String) {
        tempo = tempoMin
        genero = generoMus
    }
}
