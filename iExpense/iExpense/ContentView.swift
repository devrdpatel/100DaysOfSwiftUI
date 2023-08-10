//
//  ContentView.swift
//  iExpense
//
//  Created by Dev Patel on 6/12/23.
//

import SwiftUI

struct ExpenseStyle: ViewModifier {
    let amount: Double
    
    func body(content: Content) -> some View {
        switch amount {
        case 0..<10:
                content.foregroundColor(.green)
        case 10..<100:
                content.foregroundColor(.yellow)
        default:
                content.foregroundColor(.red)
        }
    }
}

struct ExpenseType: View {
    let header: String
    let expenseItems: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section {
            ForEach(expenseItems) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .localCurrency)
                        //.modifier(ExpenseStyle(amount: item.amount))
                        .expenseStyle(for: item)
                }
                .accessibilityElement()
                // Or use \(item.amount.formatted(.currency(code: "USD"))
                .accessibilityLabel("\(item.name), \(item.amount)\(currencyName)")
                .accessibilityHint("\(item.type)")
            }
            .onDelete(perform: deleteItems)
        } header: {
            Text(header)
        }
    }
    
    var currencyName: String {
        Locale.current.currency?.identifier ?? "USD"
    }
}

extension View {
    func expenseStyle(for expenseItem: ExpenseItem) -> some View {
        modifier(ExpenseStyle(amount: expenseItem.amount))
    }
}

struct ContentView: View {
    @StateObject var expenses = Expense()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ExpenseType(header: "Personal Expenses", expenseItems: expenses.personalExpenses, deleteItems: removePersonalItems)
                ExpenseType(header: "Business Expenses", expenseItems: expenses.businessExpenses, deleteItems: removeBusinessItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, in expenseItems: [ExpenseItem]) {
        var itemOffsets = IndexSet()
        
        for offset in offsets {
            let item = expenseItems[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                itemOffsets.insert(index)
            }
        }
        
        expenses.items.remove(atOffsets: itemOffsets)
    }
                            
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalExpenses)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessExpenses)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
