//
//  ContentView.swift
//  BetterRest
//
//  Created by Dev Patel on 6/6/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime {
        didSet {
            calculateBedTime()
            alertTitle = "Hello"
        }
    }
    @State private var sleepAmount = 8.0 {
        didSet {
            calculateBedTime()
        }
    }
    @State private var coffeeAmount = 0 {
        didSet {
            calculateBedTime()
        }
    }
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var toggleCalculation = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 30
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section("When do you want to wake up?") {
                        DatePicker("Please enter time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    }
                    
                    Section {
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    } header: {
                        Text("Desired amount of sleep")
                    }
                    
                    Section {
                        Picker("Cups of coffee", selection: $coffeeAmount) {
                            ForEach(1..<21) {
                                Text("\($0) \($0 == 1 ? "cup" : "cups")")
                            }
                        }
                    } header: {
                        Text("Daily Coffee Intake")
                    }
                    
                    Section {
                        //Toggle("Calculate Automatically", isOn: $toggleCalculation)
                        Text(getCalculatedBedTime())
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } header: {
                        Text("Your ideal sleeptime is...")
                    }
                }
            }
            .navigationTitle("Better Rest")
//            .toolbar {
//                Button("Calculate", action: calculateBedTime)
//            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("OK") { }
//            } message: {
//                Text(alertMessage)
//            }
        }
    }
    
    func getCalculatedBedTime() -> String {
        var returnMessage = ""
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))
            let sleepTime = wakeUp - prediction.actualSleep
            returnMessage = "\(sleepTime.formatted(date: .omitted, time: .shortened))"
        } catch {
            returnMessage = "Error\nSorry, there was a problem calculating your bedtime"
        }
        return returnMessage
    }

    
    func calculateBedTime() {
        do {
            print("Start of function")
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            print("End of function")
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
        }
        showingAlert = true
        //return alertTitle + alertMessage
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
