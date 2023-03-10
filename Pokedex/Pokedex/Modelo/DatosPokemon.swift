//
//  DatosPokemon.swift
//  Pokedex
//
//  Created by Ziutzel grajales on 18/01/23.
//

import Foundation
import UIKit

struct Pokemon : Decodable , Identifiable {
    let id : Int
    let attack : Int
    let name : String
    let imageUrl: String
    
    //Agregamos los datos que  necesitaremos para nuestra segunda pantalla
    let description: String
    let type: String
    let defense: Int
}

//Recordemos que las constantes deben ser del mismo tipo, asi como deben tener el mismo nombre de la API que vamos a extraer
