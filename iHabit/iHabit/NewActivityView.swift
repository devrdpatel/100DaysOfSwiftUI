//
//  NewActivityView.swift
//  iHabit
//
//  Created by Dev Patel on 6/17/23.
//

import SwiftUI

struct NewActivityView: View {
    @ObservedObject var activities: Activity
    
    @State private var title = ""
    @State private var description = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Activity Title", text: $title)
                
                TextField("Activity Description", text: $description)
            }
            .navigationTitle("Add new activity")
            .toolbar {
                Button("Save") {
                    let activityItem = ActivityItem(title: title, description: description)
                    activities.items.append(activityItem)
                    dismiss()
                }
            }
        }
    }
}

struct NewActivityView_Previews: PreviewProvider {
    static var previews: some View {
        NewActivityView(activities: Activity())
    }
}
