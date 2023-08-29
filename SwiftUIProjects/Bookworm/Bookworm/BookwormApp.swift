//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Dev Patel on 6/22/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
