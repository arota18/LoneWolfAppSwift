//
//  Player.swift
//  LoneWolfAppSwift
//
//  Created by Andrea Rota on 6/7/23.
//

import Foundation

class Player: ObservableObject, Codable {
    
    private enum CodingKeys: CodingKey {
        case name, combat, endurance, kaiArts
    }
    
    @Published var name: String
    @Published var combat: Int {
        willSet { save() }
    }
    @Published var endurance: Int {
        willSet { save() }
    }
    @Published var kaiArts: [Int] {
        willSet { save() }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        combat = try container.decode(Int.self, forKey: .combat)
        endurance = try container.decode(Int.self, forKey: .endurance)
        kaiArts = try container.decode([Int].self, forKey: .kaiArts)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(combat, forKey: .combat)
        try container.encode(endurance, forKey: .endurance)
        try container.encode(kaiArts, forKey: .kaiArts)
    }
    
    private static func getSaveUrl() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Player.json")
    }
    
    init() {
        do {
            let data = try Data(contentsOf: Player.getSaveUrl())
            let decoded = try JSONDecoder().decode(Player.self, from: data)
            name = decoded.name
            combat = decoded.combat
            endurance = decoded.endurance
            kaiArts = decoded.kaiArts
        } catch {
            print("error while loading player data: \(error.localizedDescription)")
            name = ""
            combat = 0
            endurance = 0
            kaiArts = [Int]()
        }
    }
    
    private func save() {
        guard let encoded = try? JSONEncoder().encode(self) else { return }
        do {
            try encoded.write(to: Player.getSaveUrl())
        } catch {
            print("error while saving player data: \(error.localizedDescription)")
        }
    }
    
    func setNewPlayer(_ name: String, _ combat: Int, _ endurance: Int) {
        self.name = name
        self.combat = combat
        self.endurance = endurance
        save()
    }
}

#if DEBUG
extension Player {
    static let example = Player()
}
#endif
