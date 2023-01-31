//
//  PokemonListView.swift
//  student649744
//
//  Created by Abhishek Narvekar on 17/10/2022.
//

import SwiftUI

struct PokemonListView: View {
    
    @StateObject var vm = ViewModel()
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @State var tabSelection: Tabs = .tab1
    var body: some View {
        NavigationView {
                ScrollView {
                    LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                        if vm.isLoading {
                            HStack {
                                ProgressView("Loading")
                            }
                        }
                        else {
                            ForEach(vm.filteredPokemon) { pokemon in
                                NavigationLink(destination: PokemonDetailView(pokemon:pokemon)){
                                    PokemonView(pokemon: pokemon)
                                }
                            }.navigationTitle("pokemons")
                            
                        }
                        
                    }
                    .animation(.easeIn(duration: 0.5), value: vm.filteredPokemon.count)
                    .navigationViewStyle(.stack)
                    
                }
                .searchable(text: $vm.searchText)
            
        }
        .tag(Tabs.tab1)
        .environmentObject(vm)
        .navigationViewStyle(.stack)
        
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
            .environmentObject(ViewModel())
    }
}
