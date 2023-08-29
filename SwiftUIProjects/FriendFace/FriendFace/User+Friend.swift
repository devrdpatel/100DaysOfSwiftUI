//
//  User+Friend.swift
//  FriendFace
//
//  Created by Dev Patel on 6/25/23.
//

import Foundation

struct Friend: Codable, Identifiable {
    let id: String
    let name: String
}

struct User: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    
    let age: Int
    let company: String
    let email: String
    let address: String
    
    let about: String
    let registered: Date
    let tags: [String]
    var friends: [Friend]
}
