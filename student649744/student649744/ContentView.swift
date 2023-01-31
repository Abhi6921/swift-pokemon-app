//
//  ContentView.swift
//  student649744
//
//  Created by Abhishek Narvekar on 16/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    @StateObject var favorites: PokemonFavorites = .init()
    
    var body: some View {
            TabView {
                PokemonListView()
                    .tabItem {
                        Label("pokemons", systemImage: "list.dash")
                        
                    }
                    .tag(Tabs.tab1)
                
                FavoritesView()
                    .tabItem {
                        Label("favorites", systemImage: "heart")
                    }
            }
            .navigationViewStyle(.stack)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(PokemonFavorites())
            .environmentObject(ViewModel())
    }
}
