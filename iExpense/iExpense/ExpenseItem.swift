//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Dev Patel on 6/13/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
