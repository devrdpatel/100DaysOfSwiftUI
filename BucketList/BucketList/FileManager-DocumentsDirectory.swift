//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Dev Patel on 6/30/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
