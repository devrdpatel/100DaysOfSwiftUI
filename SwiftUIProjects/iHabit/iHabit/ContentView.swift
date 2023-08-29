//
//  ContentView.swift
//  iHabit
//
//  Created by Dev Patel on 6/17/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activity()
    @State private var showingCreationScreen = false
    
    var body: some View {
        NavigationView {
            List(activities.items) { item in
                NavigationLink {
                    ActivityDetailView(activities: activities, activity: item)
                } label: {
                    Text(item.title)
                }
            }
            .navigationTitle("iHabit")
            .toolbar {
                Button {
                    showingCreationScreen.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingCreationScreen) {
                NewActivityView(activities: activities)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
