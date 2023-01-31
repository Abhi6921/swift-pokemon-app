//
//  ViewModel.swift
//  student649744
//
//  Created by Abhishek Narvekar on 16/10/2022.
//

import Foundation

final class ViewModel: ObservableObject {
    private let pokemonManager = PokemonManager()
    
    @Published var pokemonList = [Pokemon]()
    @Published var pokemonDetails: DetailPokemon?
    @Published var searchText = ""
    
    @Published var isLoading = true
    var filteredPokemon: [Pokemon] {
        // return all list if nothing is found
        return searchText == "" ? pokemonList : pokemonList.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    init() {
        fetchAllPokemons(pokemonManager: pokemonManager)
    }
    
    func fetchAllPokemons(pokemonManager: PokemonManager) {
        pokemonManager.getPokemon() { pokemon in
            DispatchQueue.main.async {
                self.pokemonList = pokemon
                self.isLoading = false
            }
        }
    }
        
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }
    
    func getDetails(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        self.pokemonDetails = DetailPokemon(id: 0, name: "", height: 0, weight: 0, types: [])
        
        pokemonManager.getDetailPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
            
        }
    }
    
    
    func formatHeightWeight(value: Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.2f", dValue / 10)
        return string
    }

}


