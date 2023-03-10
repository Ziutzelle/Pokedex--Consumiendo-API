//
//  DetallePokemonViewController.swift
//  Pokedex
//
//  Created by Ziutzel grajales on 19/01/23.
//

import UIKit

class DetallePokemonViewController: UIViewController {
    
    @IBOutlet weak var imagenPokemon: UIImageView!
    
    @IBOutlet weak var descriptionPokemon: UITextView!
    
    @IBOutlet weak var tipoPokemon: UILabel!
    
    @IBOutlet weak var atquePokemon: UILabel!
    
    @IBOutlet weak var descripcionPokemon: UILabel!
    
    @IBOutlet weak var defensaPokemon: UILabel!
    
    //MARK: VARIABLES
    
    var variableMostrar : Pokemon?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagenPokemon.loadFrom(URLAddres: variableMostrar?.imageUrl ?? "")
        tipoPokemon.text = "Tipo: \(variableMostrar?.type ?? "")"
        atquePokemon.text = "Ataque: \(variableMostrar!.attack)"
        defensaPokemon.text = "Defensa: \(variableMostrar!.defense)"
        descripcionPokemon.text = variableMostrar?.description ?? ""
        
    }
}
        //MARK: metodo para mostrar la imagen
        extension UIImageView {
            func loadFrom(URLAddres: String) {
                guard let url = URL(string: URLAddres) else { return }
                
                DispatchQueue.main.async { [weak self] in
                    if let imagenData = try? Data(contentsOf: url) {
                        if let loadedImage = UIImage(data : imagenData) {
                            self?.image = loadedImage
                        }
                    }
                }
            }
        }
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


