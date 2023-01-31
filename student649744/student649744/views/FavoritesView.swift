//
//  FavoritesView.swift
//  student649744
//
//  Created by Abhishek Narvekar on 17/10/2022.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject var vm = ViewModel()
    
    @EnvironmentObject var favorites: PokemonFavorites
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        if (favorites.ids.isEmpty) {
            Text("you have no favorite pokemons")
        }
        else {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                        ForEach(vm.filteredPokemon.filter({ pokemon in
                            return favorites.isFavorite(_pokemon: pokemon)
                        })) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                PokemonView(pokemon: pokemon)
                            }
                        }.navigationTitle("pokemons")
                    }
                    .animation(.easeIn(duration: 0.5), value: vm.filteredPokemon.count)
                    
                }
            }
            .environmentObject(vm)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView().environmentObject(PokemonFavorites())
            .environmentObject(ViewModel())
    }
}
