//
//  ContentView.swift
//  WeSplit
//
//  Created by Dev Patel on 5/30/23.
//

import SwiftUI

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(BlueTitle())
    }
}

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var amountOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var finalCheckAmount: Double {
        totalPerPerson * Double(amountOfPeople + 2)
    }
    
//    var currencyFormat = { () -> FloatingPointFormatStyle<Double>.Currency in
//        FloatingPointFormatStyle.Currency.currency(code: Locale.current.currency?.identifier ?? "USD")
//    }
    
    let currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var totalPerPerson: Double {
        let peopleCount = Double(amountOfPeople + 2)
        let tipPercentage = Double(tipPercentage)
        
        return (checkAmount + checkAmount * tipPercentage / 100) / peopleCount
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $amountOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("Tip Percentage")
                }
                
                Section {
                    Text(finalCheckAmount, format: currencyFormat)
                        .foregroundColor(tipPercentage > 0 ? .primary: .red)
                } header: {
                    Text("Total Check Amount")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyFormat)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
