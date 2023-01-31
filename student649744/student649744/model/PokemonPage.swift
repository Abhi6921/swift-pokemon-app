//
//  PokemonPage.swift
//  student649744
//
//  Created by Abhishek Narvekar on 16/10/2022.
//

import Foundation

struct PokemonEntity: Decodable {
    let name: String
}

struct PokemonPage: Decodable {
    
    let results:[PokemonEntity]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        
    }
}
