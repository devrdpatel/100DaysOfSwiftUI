//
//  Activity.swift
//  iHabit
//
//  Created by Dev Patel on 6/17/23.
//

import Foundation

class Activity: ObservableObject {
    @Published var items = [ActivityItem]() {
        didSet {
            if let data = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(data, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ActivityItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
