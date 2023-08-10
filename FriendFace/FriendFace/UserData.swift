//
//  UserData.swift
//  FriendFace
//
//  Created by Dev Patel on 6/25/23.
//

import Foundation

class UserData: ObservableObject {
    @Published var users = [User]()
}
