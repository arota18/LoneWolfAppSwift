//
//  ContentView.swift
//  LoneWolfAppSwift
//
//  Created by Andrea Rota on 6/7/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var player = Player()
    
    @State private var isNewGameShown = false
    
    var body: some View {
        Group {
            if player.name.isEmpty {
                Button("Create new Lone Wolf") {
                    isNewGameShown = true
                }
            } else {
                mainView
            }
        }
        .sheet(isPresented: $isNewGameShown) {
            NewPlayerView()
        }
        .environmentObject(player)
    }
    
    @ViewBuilder var mainView: some View {
        VStack {
            Spacer()
            Text(player.name)
            Spacer()
            Text("\(player.combat)")
            Spacer()
            Text("\(player.endurance)")
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
