//
//  PokemonDetail.swift
//  student649744
//
//  Created by Abhishek Narvekar on 16/10/2022.
//

import Foundation

struct DetailPokemon: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [TypeElement]
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species
}

struct Species: Codable {
    let name: String
    let url: String
}



