//
//  DataController.swift
//  Bookworm
//
//  Created by Dev Patel on 6/22/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
