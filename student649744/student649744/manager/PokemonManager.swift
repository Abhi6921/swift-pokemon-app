//
//  PokemonManager.swift
//  student649744
//
//  Created by Abhishek Narvekar on 16/10/2022.
//

import Foundation

class PokemonManager {
    
    func getPokemon(completion: @escaping ([Pokemon]) -> ()) {
        
        Bundle.main.fetchData(
            url: "https://pokeapi.co/api/v2/pokemon?limit=151",
            model: PokemonPage.self) { data in
            //completion(data.results)
            
            let pokemons = data.results
                .enumerated()
                .map({ (i, entity) in
                    return Pokemon(id: i + 1, name: entity.name)
                    
                })
            completion(pokemons)
            
        }
        failure: { error in
            print(error)
        }
    }
    
    func getDetailPokemon(id: Int, _ completion: @escaping (DetailPokemon) -> ()) {
        Bundle.main.fetchData(
            url: "https://pokeapi.co/api/v2/pokemon/\(id)/",
            model: DetailPokemon.self) { data in
             
                data.types
                    .enumerated()
                    .map({(i, entity) in
                        return Species(name: entity.type.name, url: entity.type.url)
                    })
             completion(data)
             print(data)
            
        } failure: { error in
            print(error)
        }
    }

}
