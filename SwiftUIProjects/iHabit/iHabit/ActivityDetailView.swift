//
//  ActivityDetailView.swift
//  iHabit
//
//  Created by Dev Patel on 6/17/23.
//

import SwiftUI

struct ActivityDetailView: View {
    @ObservedObject var activities: Activity
    
    var activity: ActivityItem
    
    var body: some View {
        VStack {
            Text(activity.description)
                .padding([.horizontal, .bottom])
            VStack {
                Text("You completed this activity \(activity.completionCount) times!")
                    .font(.headline)
                Button("Increase count") {
                    let index = activities.items.firstIndex(of: activity)
                    var activity = self.activity
                    activity.completionCount += 1
                    activities.items[index!] = activity
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .foregroundColor(.white)
            .background(.secondary)
            .clipShape(Capsule())
            Spacer()
        }
        .navigationTitle(activity.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activities: Activity(), activity: ActivityItem(title: "Test Title", description: "Test Desc"))
    }
}
