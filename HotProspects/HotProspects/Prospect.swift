//
//  Prospect.swift
//  HotProspects
//
//  Created by Dev Patel on 7/11/23.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var addTime = Date.now
    fileprivate(set) var isContacted = false
    
    static func sortByName(lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }
    
    static func sortByRecent(lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.addTime < rhs.addTime
    }
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("prospects.json")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
        
        people = []
    }
    
    private func save() {
        do {
            if let encoded = try? JSONEncoder().encode(people) {
                try encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
            }
        } catch {
            print("There was an error saving the prospects")
        }
    }
    
//    let saveKey = "SavedData"
//
//    init() {
//        if let data = UserDefaults.standard.data(forKey: saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//                return
//            }
//        }
//
//        people = []
//    }
    
//    private func save() {
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: saveKey)
//        }
//    }
    
    func toggle(prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }    
}
