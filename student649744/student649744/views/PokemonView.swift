//
//  PokemonView.swift
//  student649744
//
//  Created by Abhishek Narvekar on 17/10/2022.
//

import SwiftUI

struct PokemonView: View {
    
    @EnvironmentObject var vm: ViewModel
    let pokemon: Pokemon
    let dimensions: Double = 190
    
    var body: some View {
        VStack {
            if pokemon.id == 0 || pokemon.name == "" {
                ProgressView("Loading")
            }
            else {
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
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            
                HStack {
                    
                    Text("\(pokemon.id)")
                    .background(.blue)
                    .foregroundColor(.white)
                    .font(.headline)
                    
                    Text("\(pokemon.name)")
                        .font(.title3)
                        .foregroundColor(.white)
                        .bold()
                }
                .frame(minWidth: 150, maxWidth: 190, minHeight: 30, maxHeight: 50, alignment: .topLeading)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            }
                
        }
        
    }
    
    struct PokemonView_Previews: PreviewProvider {
        static var previews: some View {
            PokemonView(pokemon: Pokemon.testPokemon)
                .environmentObject(ViewModel())
        }
    }
}
