//
//  SplashScreenView.swift
//  student649744
//
//  Created by Abhishek Narvekar on 17/10/2022.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isProgramActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @StateObject var favorites: PokemonFavorites = .init()
    var body: some View {
        if isProgramActive {
            ContentView().environmentObject(favorites)
        }
        else {
            VStack {
                VStack {
                    Image("poksplash").resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.all, 30)
                }
                .onAppear {
                    withAnimation(.easeIn(duration: 1.4)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isProgramActive = true
                }
            }
        }

    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
