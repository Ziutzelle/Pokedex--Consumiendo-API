//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Ziutzel grajales on 18/01/23.
//



import Foundation
import UIKit

protocol pokemonManagerDelegado {
    
    func mostrarListaPokemon (lista : [Pokemon]) //La struct de pokemon lo haré en otro file
    }

struct PokemonManager {
    
    var delegado: pokemonManagerDelegado?
    
//Implementamos el metodo verPokemon para buscar los datos necesarios en la API
    func verPokemon() {
        
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
//Ahora creamos el objeto url
        
    if let url = URL(string: urlString) {
        let session = URLSession(configuration: .default)

        let tarea = session.dataTask(with: url) { datos, respuesta, error in
            if error != nil {
                print ("Error al obtener datos de la API :",error?.localizedDescription)
            }
            
            if let datosSeguros = datos?.parseData(quitarString: "null,") {
                
                if let listaPokemon = self.parsearJSON(datosPokemon: datosSeguros) {
                //  print ("Lista Pokemon : ", listaPokemon)
                    delegado?.mostrarListaPokemon(lista: listaPokemon)
                }
            }
        }
        tarea.resume()
        
        
        }
    }
//Agregamos la funcion parsearJson
    func parsearJSON(datosPokemon: Data) -> [Pokemon]? {
        let decodificador = JSONDecoder()
        do {
            let datosDecodificados = try decodificador.decode([Pokemon].self, from: datosPokemon)
            return datosDecodificados
        }catch{
            print ("Error al decodificar los datos : ", error.localizedDescription)
            return nil
        }
    }
}


//Necesitamos crear el metodo ParseData para quitar el null de la API

extension Data {
    func parseData (quitarString palabra : String) -> Data? {
        let dataAsString = String (data: self , encoding : .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: palabra, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
