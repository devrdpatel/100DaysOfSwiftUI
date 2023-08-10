//
//  FileManager-DocumentsDirectory.swift
//  Flashzilla
//
//  Created by Dev Patel on 7/18/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
