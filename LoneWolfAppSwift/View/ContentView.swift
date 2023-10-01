//
//  ContentView.swift
//  LoneWolfAppSwift
//
//  Created by Andrea Rota on 6/7/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.locale) private var loc
    
    @StateObject var player = Player()
    
    @State private var arts: [KaiArt] = Bundle.main.decode("KaiArtsIT.json")
    
    @State private var isNewGameShown = false
    
    var body: some View {
        Group {
            if player.name.isEmpty {
                Button("Create new Lone Wolf") { isNewGameShown = true }
            } else { mainMenuView }
        }
        .sheet(isPresented: $isNewGameShown) { NewPlayerView(arts: arts) }
        .environmentObject(player)
    }
    
    @ViewBuilder var mainMenuView: some View {
        TabView {
            StatView(isNewGameShown: $isNewGameShown)
                .tabItem {
                    Label("Stat", systemImage: "doc.text.below.ecg")
                }
            CombatView()
                .tabItem {
                    Label("Combat", systemImage: "figure.martial.arts")
                }
            InfoView()
                .tabItem {
                    Label("Info", systemImage: "info")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
