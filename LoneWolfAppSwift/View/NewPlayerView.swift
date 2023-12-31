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
    @State private var knownArts = [Int]()
    
    @State private var isAlertShown = false
    @State private var alertMessage = ""
    
    let arts: [KaiArt]
    
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
                        .keyboardType(.numberPad)
                }
                Section {
                    Text("Endurance")
                    TextField("Initial Endurance", value: $endurance, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                Section("Seleziona 5 discipline kai") {
                    List(arts) { art in
                        HStack {
                            Text(art.name)
                                .padding(.trailing)
                                .onTapGesture {
                                    alertMessage = art.description
                                    isAlertShown = true
                                }
                            Spacer()
                            Image(systemName: artChecked(art.id) ? "\(artIndex(art.id)+1).circle.fill" : "circle")
                                .onTapGesture { tapKaiArt(art.id) }
                                .foregroundColor(artChecked(art.id) ? .green : .gray)
                                .font(.title2)
                        }
                    }
                }
            }
            .alert(alertMessage, isPresented: $isAlertShown) {
                Button("Ok", role: .cancel) { }
            }
            .onTapGesture {
                hideKeyboard()
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
    
    private func tapKaiArt(_ id: Int) {
        if artChecked(id) {
            knownArts.remove(at: knownArts.firstIndex(of: id)!)
        } else if knownArts.count < 5 {
            knownArts.append(id)
        }
        // TODO: aggiungere eventuale notifica in un else
    }
    
    private func artIndex(_ id: Int) -> Int {
        knownArts.firstIndex(of: id)!
    }
    
    private func artChecked(_ id: Int) -> Bool {
        knownArts.contains(id)
    }
    
    private func saveGame() {
        player.setNewPlayer(name, combat, endurance)
        dismiss()
    }
    
    private func checkForm() -> Bool {
        name.isEmpty || combat < 10 || endurance < 20 || knownArts.count < 5
    }
}

struct NewPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlayerView(arts: Bundle.main.decode("KaiArtsIT.json"))
            .environmentObject(Player.example)
    }
}
