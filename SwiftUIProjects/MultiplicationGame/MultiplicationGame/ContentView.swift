//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Dev Patel on 6/11/23.
//

import SwiftUI

struct Question {
    let firstNumber: Int
    let secondNumber: Int
    
    var message: String {
        "\(firstNumber) x \(secondNumber)"
    }
}

struct ContentView: View {
    let questionOptions = [5, 10, 15, 20]
    @State private var questionArray = [Question]()
    
    @State private var tableUpto = 6
    @State private var numberOfQuestions = 10
    @State private var gameStarted = false
    @State private var answer = 0
    
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var questionsAsked = 0
    @State private var questionsCorrect = 0
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Form {
                        Section {
                            Stepper("\(tableUpto) x \(tableUpto) table", value: $tableUpto, in: 2...12)
                                .disabled(gameStarted)
                        } header: {
                            Text("Muliplication Questions upto")
                        }
                        
                        Section {
                            Picker("Questions:", selection: $numberOfQuestions) {
                                ForEach(questionOptions, id: \.self) { option in
                                    Text("\(option) questions")
                                }
                            }
                            .disabled(gameStarted)
                        } header: {
                            Text("Number of questions")
                        }
                        
                        Section {
                            VStack {
                                if gameStarted {
                                    Text("\(firstNumber) x \(secondNumber)")
                                        .font(.largeTitle)
                                        .padding()
                                        .background(.blue)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                    TextField("Enter your answer", value: $answer, format: .number)
                                        .keyboardType(.numberPad)
                                        .onSubmit(checkAnswer)
                                } else {
                                    Text("Select the game settings you would like and then start the game")
                                }
                            }
                            .transition(.slide)
                            .animation(.easeInOut(duration: 1), value: gameStarted)
                        } header: {
                            Text(gameStarted ? "What is the answer to..." : "Game Instructions")
                        }
                    }
                }
                
                VStack {
                    Button("Start Game", action: startGame)
                        .padding()
                        .background(.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .disabled(gameStarted)
                        .opacity(gameStarted ? 0.75 : 1)
                        .animation(.default, value: gameStarted)
                }
            }
            .navigationTitle("MathWiz")
            .alert("Game Over", isPresented: $showingAlert) {
                Button("Restart", action: resetGame)
            } message: {
                Text("Your score is \(questionsCorrect)/\(questionsAsked)")
            }
        }
    }
    
    func startGame() {
        questionsAsked = 0
        questionsCorrect = 0
        generateQuestions()
        askQuestion()
        gameStarted = true
    }
    
    func generateQuestions() {
        questionArray.removeAll()
        for _ in 0..<numberOfQuestions {
            questionArray.append(Question(firstNumber: Int.random(in: 0...tableUpto), secondNumber: Int.random(in: 0...tableUpto)))
        }
    }
    
    func resetGame() {
        gameStarted = false
    }
    
    func checkAnswer() {
        if (firstNumber * secondNumber == answer) {
            questionsCorrect += 1
        }
        
        if (questionsAsked == numberOfQuestions) {
            showingAlert = true
        } else {
            askQuestion()
        }
    }
    
    func askQuestion() {
        
        // Now set the values for next question
        firstNumber = questionArray[questionsAsked].firstNumber
        secondNumber = questionArray[questionsAsked].secondNumber
        questionsAsked += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
