//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Dev Patel on 6/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var possibleMoves = ["🪨", "📃", "✂️"]
    
    @State private var appMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var finalResult = false

    @State private var totalAttempts = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Rock, Paper, Scissors...")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                                
                VStack {
                    // Displays Game Instructions
                    VStack {
                        VStack {
                            Text("Computer's Move:")
                            Text(possibleMoves[appMove])
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .padding()
                                .background(.secondary)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        Text("Choose the move that...")
                        Text(shouldWin ? "WINS" : "LOSES")
                            .font(.title)
                            .foregroundColor(shouldWin ? .blue : .red)
                            .fontWeight(.heavy)
                    }
                    
                                    
                    // Displays Player options
                    HStack {
                        ForEach(0..<possibleMoves.count, id: \.self) { index in
                            Button(possibleMoves[index]) {
                                moveMade(playerMove: index)
                            }
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .clipShape(Capsule())
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                
                VStack {
                    Text("Score: \(score)")
                        .font(.title.bold())
                        .foregroundColor(.white)
                }
            }
        }
        .alert("Game Over", isPresented: $finalResult) {
            Button("Restart Game", action: reset)
        } message: {
            Text("Your final score is: \(score)/\(totalAttempts)")
        }
    }
    
    func askQuestion() {
        appMove = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func reset() {
        score = 0
        totalAttempts = 0
        shouldWin = Bool.random()
        askQuestion()
    }
    
    func moveMade(playerMove: Int) {
        totalAttempts += 1

        let winningMoves = [1,2,0]      // Winning moves are the next move in array
        let playerWins: Bool = shouldWin ? playerMove == winningMoves[appMove] : winningMoves[playerMove] == appMove
        
        if playerWins {
            score += 1
        }
        
        askQuestion()
        
        if (totalAttempts >= 10) {
            finalResult = true
        }
    }
//
//    func winningMove() -> String {
//        return shouldWin ?
//        switch possibleMoves[appMove] {
//        case "Rock":
//            return shouldWin ? "Paper" : "Scissors"
//        case "Paper":
//            return shouldWin ? "Scissors" : "Rock"
//        case "Scissors":
//            return shouldWin ? "Rock" : "Paper"
//        default:
//            return ""
//        }
//    }
        
    func buttonName(text: String) -> String {
        switch text {
        case "Rock":
            return "Rock 🪨"
        case "Paper":
            return "Paper 📃"
        case "Scissors":
            return "Scissors ✂️"
        default:
            return "question"
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
