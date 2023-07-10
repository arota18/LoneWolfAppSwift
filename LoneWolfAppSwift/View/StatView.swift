//
//  StatView.swift
//  LoneWolfAppSwift
//
//  Created by Andrea Rota on 10/7/23.
//

import SwiftUI

struct StatMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .frame(width: 50)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.secondary, lineWidth: 4)
            }
    }
}

extension View {
    func statMod() -> some View {
        modifier(StatMod())
    }
}

struct StatView: View {
    
    @EnvironmentObject var player: Player
    @Binding var isNewGameShown: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                SingleStatView(statName: "Combat skill", singleStat: $player.combat)
                .padding(.bottom)
                SingleStatView(statName: "Endurance", singleStat: $player.endurance)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isNewGameShown = true
                    } label: {
                        Label("New game", systemImage: "goforward.plus")
                    }
                }
            }
        }
    }
}

struct SingleStatView: View {
    
    let statName: String
    @Binding var singleStat: Int
    let iconSize = 32.0
    
    var body: some View {
        VStack {
            Text(statName)
                .foregroundColor(.secondary)
            HStack(spacing: iconSize) {
                Button {
                    singleStat -= 1
                } label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconSize)
                }
                Text("\(singleStat)")
                    .statMod()
                Button {
                    singleStat += 1
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconSize)
                }
            }
        }
    }
}
