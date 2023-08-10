//
//  Photo.swift
//  PhotoGallery
//
//  Created by Dev Patel on 7/5/23.
//

import Foundation
import SwiftUI

struct Photo: Codable, Comparable, Identifiable {
    var id = UUID()
    var imageName: String
    var latitude: Double?
    var longitude: Double?
    
    var image: Image? {
        let url = FileManager.documentsDirectory.appendingPathComponent("\(id).jpeg")
        
        if let uiImage = try? UIImage(data: Data(contentsOf: url)) {
            return Image(uiImage: uiImage)
        } else {
            print("Could not create UIImage from \(url)")
            return nil
        }
    }
    
    static func <(lhs: Photo, rhs: Photo) -> Bool {
        lhs.imageName.lowercased() < rhs.imageName.lowercased()
    }
}
