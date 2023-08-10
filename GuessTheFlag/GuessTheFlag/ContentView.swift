//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dev Patel on 6/1/23.
//

import SwiftUI

struct FlagImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showScore = false
    @State private var finalResults = false
    @State private var resultTitle = ""
    @State private var score: Int = 0
    @State private var questionsAsked = 0
    @State private var resultMessage = ""
    
    // For animation effects
    @State private var animationAmount = 0.0
    @State private var flagSelected = -1
    @State private var opacityValue = 1.0
    
    @State private var countries = allCountries.shuffled()
    
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
        
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.15, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of ")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagSelected = number
                            withAnimation {
                                animationAmount = 360
                                opacityValue = 0.25
                            }
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: countries[number])
                                .accessibilityLabel(labels[countries[number], default: "Unknown"])
                        }
                        .opacity(number != flagSelected ? opacityValue : 1.0)
                        //.opacity(flagSelected == -1 || flagSelected == number ? 1.0 : 0.25)
                        .rotation3DEffect(.degrees(number == flagSelected ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        .rotation3DEffect(.degrees((number == flagSelected || flagSelected == -1) ? 0 : animationAmount - 270), axis: (x: 1, y: 0, z: 0))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert(resultTitle, isPresented: $showScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(resultMessage)
        }
        .alert("Game Over", isPresented: $finalResults) {
            Button("Restart Game", action: reset)
        } message: {
            Text("Your final score is: \(score)/8")
        }
    }
    
    func reset() {
        score = 0
        askQuestion()
    }
    
    func flagTapped(_ number: Int) {
        questionsAsked += 1

        if number == correctAnswer {
            resultTitle = "Correct"
            resultMessage = "That was the correct flag!"
            score += 1
        } else {
            let needsThe = ["US", "UK"]
            
            if needsThe.contains(countries[number]) {
                resultMessage = "That was the flag of the \(countries[number])"
            } else {
                resultMessage = "That was the flag of \(countries[number])"
            }
            resultTitle = "Wrong"
        }
        
        showScore = true
        
        if (questionsAsked == 8) {
            finalResults = true
        }
    }
    
    func askQuestion() {
        opacityValue = 1
        flagSelected = -1
        animationAmount = 0
        countries = Self.allCountries
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
