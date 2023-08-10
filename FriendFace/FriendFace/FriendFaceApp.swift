//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Dev Patel on 6/25/23.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
