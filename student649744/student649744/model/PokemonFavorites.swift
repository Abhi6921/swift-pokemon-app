//
//  PokemonFavorites.swift
//  student649744
//
//  Created by Abhishek Narvekar on 16/10/2022.
//

import Foundation

class PokemonFavorites: ObservableObject {
    @Published var ids: [Int] = []
    
    func toggleFavorite(_ pokemon: Pokemon) {
        if isFavorite(_pokemon: pokemon) {
            ids = ids.filter({ id in return id != pokemon.id })
        }
        else {
            ids.append(pokemon.id)
        }
    }
    
    func isFavorite(_pokemon: Pokemon)  -> Bool {
        return ids.contains(_pokemon.id)
    }
}
