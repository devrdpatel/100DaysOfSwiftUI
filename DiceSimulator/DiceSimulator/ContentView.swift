//
//  ContentView.swift
//  DiceSimulator
//
//  Created by Dev Patel on 7/20/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var rollHistory = RollHistory()
    
    var body: some View {
        TabView {
            PlayView()
                .tabItem {
                    Label("Roll Dice", systemImage: "dice")
                }
            RollHistoryView()
                .tabItem {
                    Label("Roll History", systemImage: "text.book.closed")
                }
        }
        .environmentObject(rollHistory)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
