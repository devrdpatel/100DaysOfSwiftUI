//
//  RollHistoryView.swift
//  DiceSimulator
//
//  Created by Dev Patel on 7/21/23.
//

import SwiftUI

struct RollHistoryView: View {
    @EnvironmentObject var rollHistory: RollHistory
    
    var body: some View {
        NavigationView {
            List {
                ForEach(rollHistory.rolls) { diceResult in
                    NavigationLink {
                        DiceView(numberOfDice: diceResult.numberofDice, sidesOfDie: diceResult.sidesOfDie, diceValues: diceResult.diceValues)
                    } label: {
                        VStack(alignment: .leading) {
                            Text("Rolled \(diceResult.numberofDice) \(diceResult.numberofDice == 1 ? "die" : "dice")")
                            Text("Total sum: \(diceResult.diceValues.reduce(0, +))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Roll History")
        }
    }
}

struct RollHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        RollHistoryView()
    }
}
