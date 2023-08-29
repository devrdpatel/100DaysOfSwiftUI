//
//  Activity.swift
//  iHabit
//
//  Created by Dev Patel on 6/17/23.
//

import Foundation

struct ActivityItem: Codable, Identifiable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    var completionCount: Int = 0
}
