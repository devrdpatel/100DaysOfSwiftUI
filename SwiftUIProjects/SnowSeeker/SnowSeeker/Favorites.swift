//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Dev Patel on 7/22/23.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let loaded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = loaded
                return
            } else {
                print("Data from \(saveKey) failed to load")
            }
        }
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        } else {
            print("Save failed: Unable to save favorites")
        }
    }
}
