//
//  DiceResult.swift
//  DiceSimulator
//
//  Created by Dev Patel on 7/21/23.
//

import Foundation

struct DiceResult: Codable, Identifiable {
    var id = UUID()
    var sidesOfDie: Int
    var numberofDice: Int
    var diceValues: [Int]
}

@MainActor class RollHistory: ObservableObject {
    let savePath = FileManager.documentsDirectory.appendingPathComponent("rollHistory.json")
    
    @Published var rolls: [DiceResult] {
        didSet {
            do {
                if let encoded = try? JSONEncoder().encode(rolls) {
                    try encoded.write(to: savePath)
                    print("Saved")
                }
            } catch {
                print("There was an error saving the data")
            }
        }
    }
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([DiceResult].self, from: data) {
                rolls = decoded
                return
            } else {
                print("There was an error decoding the data at \(savePath)")
            }
        } else {
            print("There was an error loading the data at \(savePath)")
        }
        
        rolls = []
    }
}
