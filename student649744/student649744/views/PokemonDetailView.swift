//
//  PokemonDetailView.swift
//  student649744
//
//  Created by Abhishek Narvekar on 17/10/2022.
//

import SwiftUI

struct PokemonDetailView: View {
    @EnvironmentObject var vm: ViewModel
    let pokemon: Pokemon
    
    @EnvironmentObject var favorites: PokemonFavorites
    let dimensions: Double = 190
    @State private var didAppear = false
    @State private var didCatch = false
    @State var loadingToggle = false
    
    @State private var isSharingShowing = false
        var body: some View {
                ScrollView {
                    VStack {
                        AsyncImage(url: pokemon.url) { image in
                            
                            if let image = image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: dimensions, height: dimensions)
                            }
                        } placeholder: {
                            ProgressView("Loading")
                                .frame(width: dimensions, height: dimensions)
                        }
                        .onAppear {
                            didAppear = true
                        }
                        .scaleEffect(didAppear ? 1 : 2)
                        .opacity(didAppear ? 1 : 0)
                        .animation(.linear(duration: 0.5))
                        .background(didAppear ? Color.yellow : .white)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: didAppear ? 60 : 0))
                        .padding()
                        .animation(
                            .interpolatingSpring(
                                stiffness: 10,
                                damping: 1
                            )
                            .speed(3)
                            .delay(0.5)
                        )
                        .onTapGesture {
                            withAnimation {
                                didCatch.toggle()
                            }
                        }
            
                        if didCatch {
                            Text("you caught \(vm.pokemonDetails?.name ?? "")")
                                .font(.headline)
                                .transition(.opacity.combined(with: .slide))
                        }
                        VStack(spacing: 10) {
                            if vm.pokemonDetails?.id == nil ||
                                vm.pokemonDetails?.name == "" ||
                                vm.pokemonDetails?.height == nil ||
                                vm.pokemonDetails?.weight == nil ||
                                vm.pokemonDetails?.types == nil {
                                ProgressView("Loading")
                            }
                            else {
                                HStack {
                                    Text("Id: ").font(.title2)
                                    Text("\(vm.pokemonDetails?.id ?? 0)").font(.title)
                                    
                                }
                                
                                
                                HStack {
                                    Text("Name: ").font(.title)
                                    Text("\(vm.pokemonDetails?.name ?? "something")").font(.title2)
                                }
                                
                                HStack {
                                    Text("Height: ").font(.title)
                                    Text("\(vm.pokemonDetails?.height ?? 12) M")
                                        .font(.title2)
                                }
                                
                                HStack {
                                    Text("Weight: ").font(.title)
                                    Text("\(vm.pokemonDetails?.weight ?? 45) kg")
                                    .font(.title2)
                                }
                                
                                HStack {
                                    Text("\(vm.pokemonDetails?.name ?? "") Types: ").font(.title)
                                    Text("\(getPokemonTypes(vm: vm))")

                                        .font(.title2)
                                }
                                
                                

                            }
                        }
                        
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(
                                action: {
                                    favorites.toggleFavorite(pokemon)
                                },
                                label: {
                                    let isFavorite  = favorites.isFavorite(_pokemon: pokemon)
                                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                                }
                            )
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(
                                action: {
                                    sharePokemonDetails()
                                },
                                label: {
                                    Image(systemName: "square.and.arrow.up")
                                }
                            )
                        }
                    }
                    .onAppear {
                        vm.getDetails(pokemon: pokemon)
                    }

                }
                            
    }
    
    func getPokemonTypes(vm: ViewModel) -> String {
        var name = ""
        vm.pokemonDetails?.types.forEach { data in
            //name += data.type.name + " "
            if vm.pokemonDetails?.types.count == 2 {
                name += data.type.name + ", "
            }
            else {
                name += data.type.name + " "
            }
        }
        return name
    }
    
    func sharePokemonDetails() {
        isSharingShowing.toggle()
        
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemon.id).png")
        let activityView = UIActivityViewController(activityItems: [url!],
        applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
}



struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: .testPokemon)
            .environmentObject(PokemonFavorites())
            .environmentObject(ViewModel())
    }
}
