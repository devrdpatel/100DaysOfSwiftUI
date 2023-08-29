//
//  Expense.swift
//  iExpense
//
//  Created by Dev Patel on 6/13/23.
//

import Foundation

class Expense: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let data = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(data, forKey: "Items")
            }
        }
    }
    
    var personalExpenses: [ExpenseItem] {
        items.filter {
            $0.type == "Personal"
        }
    }
    
    var businessExpenses: [ExpenseItem] {
        items.filter {
            $0.type == "Business"
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
