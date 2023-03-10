//
//  CeldaPokemonTableViewCell.swift
//  Pokedex
//
//  Created by Ziutzel grajales on 19/01/23.
//

import UIKit

class CeldaPokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var imagenPokemon: UIImageView!
    
    @IBOutlet weak var nombrePokemon: UILabel!
    
    @IBOutlet weak var ataquePokemon: UILabel!
    
    @IBOutlet weak var defensaPokemon: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        imagenPokemon.layer.cornerRadius = 15
    }
    
}
