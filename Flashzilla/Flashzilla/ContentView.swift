//
//  ContentView.swift
//  Flashzilla
//
//  Created by Dev Patel on 7/14/23.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    @StateObject var cardCollection = CardCollection()
    
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    //@State private var cards = Array<Card>(repeating: Card.example, count: 10)
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.7))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(Array(cardCollection.cards.enumerated()), id: \.element) { item in
                        CardView(card: item.element) { reinsert in
                            withAnimation {
                                removeCard(at: item.offset, insertAgain: reinsert)
                            }
                        }
                        .stacked(at: item.offset, in: cardCollection.cards.count)
                        .allowsHitTesting(item.offset == cardCollection.cards.count - 1)
                        .accessibilityHidden(item.offset < cardCollection.cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cardCollection.cards.isEmpty && !isActive {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                } else if cardCollection.cards.isEmpty {
                    Text("Press the '+' button to get started!")
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cardCollection.cards.count  - 1, insertAgain: true)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cardCollection.cards.count - 1, insertAgain: false)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive && !cardCollection.cards.isEmpty else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if !cardCollection.cards.isEmpty {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .environmentObject(cardCollection)
    }
    
    func removeCard(at index: Int, insertAgain: Bool) {
        guard index >= 0 else { return }
        
        if insertAgain {
            cardCollection.cards.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
        } else {
            cardCollection.cards.remove(at: index)
        }
        
        if cardCollection.cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        if cardCollection.cards.isEmpty {
            cardCollection.cards = CardCollection.loadData()
        }
        timeRemaining = 100
        isActive = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
