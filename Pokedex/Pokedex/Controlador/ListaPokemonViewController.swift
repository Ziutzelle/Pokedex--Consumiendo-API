//
//  ViewController.swift
//  Pokedex
//
//  Created by Ziutzel grajales on 17/01/23.
//

import UIKit

class ListaPokemonViewController: UIViewController {
    
    @IBOutlet weak var busquedaPokemon: UITextField!
   
    @IBOutlet weak var tablaPokemon: UITableView!
    
    
    //MARK: VARIABLES QUE INSTANCIAREMOS DEL ARCHIVO POKEMON MANAGER PARA PODER USARLAS EN ESTE VIEW CONTROLLER
    
    var pokemonManager = PokemonManager()
    var pokemons : [Pokemon] = []
    
//Arreglo de pokemons vacio
    
    var pokemonsFiltrados = [Pokemon]()
    
//variable para enviar elementos:
    var elementoEnviar : Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//MARK: Vamos a registrar la celda
        
//Creamos el delegado de mi textfield
                
        busquedaPokemon.delegate = self
        
        tablaPokemon.register(UINib(nibName: "CeldaPokemonTableViewCell", bundle: nil),forCellReuseIdentifier: "celda")
    
        pokemonManager.delegado = self
        tablaPokemon.delegate = self
        tablaPokemon.dataSource = self
        

//Ejecutar el metodo para buscar la lista de pokemon
        pokemonManager.verPokemon()
    }

//Agregamos el metodo didSelectRowAt que me ayudará a identificar que celda se seleccionó
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tablaPokemon.deselectRow(at: indexPath, animated: true)
        
        elementoEnviar = pokemonsFiltrados[indexPath.row]
        
        performSegue(withIdentifier: "mostrarPokemon", sender: self)
    }
    
//metodo para enviar parametros de una pantalla a otra
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
//Primero debemos hacer una validación
        
    if segue.identifier == "mostrarPokemon" {
        
        let mostrarPokemon = segue.destination as! DetallePokemonViewController
            
        mostrarPokemon.variableMostrar = elementoEnviar
        }
    }}

//MARK: Delegado Pokemon

extension ListaPokemonViewController : pokemonManagerDelegado {
    func mostrarListaPokemon(lista: [Pokemon]) {
        
  //Aqui el manager ya me trae la lista con los pokemons y yo lo estoy vaciando en la variable pokemons que inicalicé vacia al principi del view Controller
        
        pokemons = lista
        pokemonsFiltrados = pokemons
        
        
        DispatchQueue.main.async {
            self.tablaPokemon.reloadData()
        }
    }
    
}

//MARK: TABLA

extension ListaPokemonViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemonsFiltrados.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let celda = tablaPokemon.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaPokemonTableViewCell
        
        celda.nombrePokemon.text = pokemonsFiltrados[indexPath.row].name
        celda.ataquePokemon.text = "Ataque : \(pokemonsFiltrados[indexPath.row].attack)"
        celda.defensaPokemon.text = "Defensa: \(pokemonsFiltrados[indexPath.row].defense)"
        
//Vamos a crear el metodo para extraer la celda imagen desde URL
        if let urlString = pokemonsFiltrados[indexPath.row].imageUrl as? String {
            if let imagenUrl = URL(string: urlString){
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenUrl) else { return }
            let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        celda.imagenPokemon.image = image
                    }
                }
            }
        }
        
        return celda
    }
}

//Extension para crear los protocolos y delegados de mi textField y programar su busquda :
extension ListaPokemonViewController : UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    // Hare un print como buena practica para ver que mi metodo su funciona, NO es necesaio
        print (textField.text)
    //Seguiremos algunos pasos para poder filtrar con mi textfield:
        
    // 1). Primero debo vaciar el arreglo de pokemons filtrados
        pokemonsFiltrados = []
        
    //2). Validar si el texto en mi textfield esta vacio
        if textField.text == "" {
            
            pokemonsFiltrados = pokemons //Esto nos indica que si  no he escrito nada en mi textfield, me mostrará todos los pokemons
        } else {
 //Si ya empiezo a escribir texto en el textfield, empiezo a validar letra por letra con ayuda de un for
            for pokemon in pokemons {
                
    //3). Validamos si coincide la busqueda con el nombre de algun elemento de mi array
            
                if pokemon.name.lowercased().contains(textField.text!.lowercased()) {
                    
    //4). Si si coincide, a mi array de pokemon vacio le añadiré ese elemento encontrado
                    
                    pokemonsFiltrados.append(pokemon)
        }
    }
}
  //4). Actualizamos la tabla fuera del else
        self.tablaPokemon.reloadData()
    }
    
    
}
