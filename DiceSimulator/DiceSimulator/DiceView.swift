//
//  DiceView.swift
//  DiceSimulator
//
//  Created by Dev Patel on 7/21/23.
//

import SwiftUI

struct DiceView: View {
    var numberOfDice: Int
    var sidesOfDie: Int
    var saveResult: ((DiceResult) -> Void)?
    
    @Environment(\.dismiss) var dismiss
    @State private var diceValues: [Int]
    @State private var steps = -15
    @State private var saveButtonDisabled = true
    
    @State private var feedback = UIImpactFeedbackGenerator(style: .rigid)
    let columns = [
        GridItem(.adaptive(minimum: 75))
    ]
    
    let timer = Timer.publish(every: 0.1, tolerance: 0.1, on: .main, in: .common).autoconnect()
    let animationCount = 12
    
    init(numberOfDice: Int, sidesOfDie: Int, saveResult: ((DiceResult) -> Void)?) {
        self.numberOfDice = numberOfDice
        self.sidesOfDie = sidesOfDie
        self.saveResult = saveResult
        
        //_steps = State(initialValue: numberOfDice * animationCount)
        _diceValues = State(initialValue: Array(repeating: 1, count: numberOfDice))
    }
    
    init(numberOfDice: Int, sidesOfDie: Int, diceValues: [Int]) {
        self.numberOfDice = numberOfDice
        self.sidesOfDie = sidesOfDie
        _steps = State(initialValue: numberOfDice)
        _diceValues = State(initialValue: diceValues)
        timer.upstream.connect().cancel()
        _saveButtonDisabled = State(initialValue: false)
    }
    
    var estimatedSteps: Int {
        numberOfDice * animationCount
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Dice roll with ") + Text("\(numberOfDice) \(numberOfDice == 1 ? "die" : "dice")").bold() + Text(" that \(numberOfDice == 1 ? "is" : "are") ") + Text("\(sidesOfDie)-sided").bold()
                
                LazyVGrid(columns: columns) {
                    ForEach(0..<numberOfDice) { num in
                        Text("\(diceValues[num])")
                            .font(.largeTitle)
                            .frame(width: 75, height: 75)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(.primary)
                            )
                            .padding()
//                            .onReceive(timer) { time in
//                                guard saveResult != nil else { return }
//                                if steps <= 0 {
//                                    print(steps)
//                                    timer.upstream.connect().cancel()
//                                    saveButtonDisabled = false
//                                } else if steps > estimatedSteps - (num + 1) * animationCount {
//                                    steps -= 1
//                                    //                                        withAnimation(.linear) {
//                                    //                                            diceValues[num] = Int.random(in: 1...sidesOfDie)
//                                    //                                        }
//                                    diceValues[num] = Int.random(in: 1...sidesOfDie)
//                                }
//                            }
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .strokeBorder(.primary)
                )
                
                if !saveButtonDisabled {
                    VStack {
                        Text("Total sum of the roll")
                            .font(.headline)
                        Text("\(diceValues.reduce(0, +))")
                            .font(.largeTitle)
                    }
                    .padding()
                }
            }
            .toolbar {
                Button("\(saveResult == nil ? "Done" : "Save Results")") {
                    let result = DiceResult(sidesOfDie: sidesOfDie, numberofDice: numberOfDice, diceValues: diceValues)
                    saveResult?(result)
                    dismiss()
                }
                .disabled(saveButtonDisabled)
            }
            .animation(.default, value: saveButtonDisabled)
            .onReceive(timer) { time in
                updateDice()
            }
        }
    }
    
    func updateDice() {
        guard steps < numberOfDice else {
            saveButtonDisabled = false
            return
        }
        
        for i in steps..<numberOfDice {
            if i < 0 { continue }
            diceValues[i] = Int.random(in: 1...sidesOfDie)
        }
        
        steps += 1
        feedback.impactOccurred()
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(numberOfDice: 2, sidesOfDie: 6, diceValues: [5, 6])
    }
}
