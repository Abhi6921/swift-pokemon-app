//
//  Pokemon.swift
//  student649744
//
//  Created by Abhishek Narvekar on 16/10/2022.
//

import Foundation

struct Pokemon: Identifiable, Equatable {
    let id: Int
    let name: String
    var url: URL {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        )!
    }
    
    static var testPokemon = Pokemon(id: 1, name: "bulbasur")
}


