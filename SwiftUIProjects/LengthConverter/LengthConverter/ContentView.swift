//
//  ContentView.swift
//  LengthConverter
//
//  Created by Dev Patel on 6/1/23.
//

import SwiftUI

//enum ConversionOptions: String {
//    case km = "km"
//    case m = "m"
//    case mile = "mile"
//    case feet = "ft"
//    case yards = "yrd"
//}

struct ContentView: View {
    @State private var inputSelection: Dimension = UnitLength.kilometers
    @State private var outputSelection: Dimension = UnitLength.meters
    @State private var inputValue = 0.0
    @State private var selectedUnits = 0
    @FocusState private var inputIsFocused: Bool
    
    let conversions = ["Distance", "Mass", "Temperature", "Time"]
    let unitTypes: [[Dimension]] = [
        [UnitLength.feet, UnitLength.kilometers, UnitLength.meters, UnitLength.miles, UnitLength.yards],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]
    let formatter: MeasurementFormatter
    
    var convertedValue: String {
        let inputMeasurement = Measurement(value: inputValue, unit: inputSelection)
        let outputValue = inputMeasurement.converted(to: outputSelection)
        return formatter.string(from: outputValue)
    }
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Enter input value")
                }
                
                Section {
                    Picker("Conversion", selection: $selectedUnits) {
                        ForEach(0..<conversions.count, id: \.self) {
                            Text(conversions[$0])
                        }
                    }
                    Picker("Input units", selection: $inputSelection) {
                        ForEach(unitTypes[selectedUnits], id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                    Picker("Output units", selection: $outputSelection) {
                        ForEach(unitTypes[selectedUnits], id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                } header: {
                    Text("Choose conversion type")
                }
                
                Section {
                    Text(convertedValue)
                } header: {
                    Text("Converted output value:")
                }
            }
            .navigationTitle("Length Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
            .onChange(of: selectedUnits) { selectedUnit in
                inputSelection = unitTypes[selectedUnit][0]
                outputSelection = unitTypes[selectedUnit][1]
            }
        }
    }
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
