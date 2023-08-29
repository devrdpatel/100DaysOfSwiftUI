//
//  PhotosContainer.swift
//  PhotoGallery
//
//  Created by Dev Patel on 7/5/23.
//

import Foundation

class PhotosContainer: ObservableObject {
    @Published var photos = [Photo]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(photos) {
                try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
            } else {
                print("Failed to save photos on didSet")
            }
        }
    }
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedItems")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            photos = try JSONDecoder().decode([Photo].self, from: data)
        } catch {
            photos = []
        }
    }
    
    
}
