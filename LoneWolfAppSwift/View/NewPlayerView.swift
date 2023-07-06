//
//  NewPlayerView.swift
//  LoneWolfAppSwift
//
//  Created by Andrea Rota on 6/7/23.
//

import SwiftUI

struct NewPlayerView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var player: Player
    
    @State private var name = ""
    @State private var combat = 0
    @State private var endurance = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Name")
                    TextField("Choose a name for your Lone Wolf", text: $name)
                }
                Section {
                    Text("Combat Skill")
                    TextField("Initial Combat Skill", value: $combat, formatter: NumberFormatter())
                }
                Section {
                    Text("Endurance")
                    TextField("Initial Endurance", value: $endurance, formatter: NumberFormatter())
                }
            }
            .navigationTitle("New Game")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: saveGame)
                        .disabled(checkForm())
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func saveGame() {
        player.setNewPlayer(name, combat, endurance)
        dismiss()
    }
    
    func checkForm() -> Bool {
        name.isEmpty || combat <= 0 || endurance <= 0
    }
}

struct NewPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlayerView()
            .environmentObject(Player.example)
    }
}
