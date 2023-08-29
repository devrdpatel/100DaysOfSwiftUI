//
//  PlayView.swift
//  DiceSimulator
//
//  Created by Dev Patel on 7/21/23.
//

import SwiftUI

struct PlayView: View {
    @EnvironmentObject var rollHistory: RollHistory
    
    @AppStorage("numberOfDice") var numberOfDice = 2
    @AppStorage("sidesOfDie") var sidesOfDie = 6
    @State private var rollStarted = false
        
    let dieSideOptions = [6, 7, 8, 10, 12, 15, 20, 100]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Stepper("Dice to roll: \(numberOfDice)", value: $numberOfDice, in: 1...12)
                        .padding()
                    HStack {
                        Text("Type of die")
                        Spacer()
                        Picker("Choose how many sides the die should have: ", selection: $sidesOfDie) {
                            ForEach(dieSideOptions, id: \.self) { num in
                                Text("\(num)-sided die")
                            }
                        }
                        .pickerStyle(.automatic)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Button("Roll \(numberOfDice == 1 ? "Die" : "Dice")") {
                            rollStarted.toggle()
                        }
                            .padding()
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                }
            }
            .navigationTitle("Dice Simulator")
            .sheet(isPresented: $rollStarted) {
                DiceView(numberOfDice: numberOfDice, sidesOfDie: sidesOfDie) { diceResult in
                    rollHistory.rolls.append(diceResult)
                }
            }
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
