//
//  Card.swift
//  Flashzilla
//
//  Created by Dev Patel on 7/15/23.
//

import Foundation

struct Card: Codable, Identifiable, Equatable, Hashable {
    var id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th doctor in Doctor Who?", answer: "Jodie Whittaker")
}

@MainActor class CardCollection: ObservableObject {
    static let savePath = FileManager.documentsDirectory.appendingPathComponent("cards.json")
    
    static func loadData() -> [Card] {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                return decoded
            }
        }
        
        return []
    }
    
    init() {
        cards = CardCollection.loadData()
    }
    
    @Published var cards: [Card]
    
    func saveData() {
        do {
            if let data = try? JSONEncoder().encode(cards) {
                try data.write(to: CardCollection.savePath, options: [.atomic, .completeFileProtection])
            }
        } catch {
            print("There was an error saving the cards")
        }
    }
}
