//
//  EditCards.swift
//  Flashzilla
//
//  Created by Dev Patel on 7/17/23.
//

import SwiftUI

struct EditCards: View {
    @EnvironmentObject var cardCollection: CardCollection
    
    @Environment(\.dismiss) var dismiss
    @State private var prompt = ""
    @State private var answer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Card Prompt", text: $prompt)
                    TextField("Card Answer", text: $answer)
                    Button("Add Card", action: addCard)
                    .buttonStyle(.borderedProminent)
                }
                
                Section("Cards") {
                    ForEach(0..<cardCollection.cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cardCollection.cards[index].prompt)
                                .font(.headline)
                            Text(cardCollection.cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: loadCards)
        }
    }
    
    func loadCards() {
        cardCollection.cards = CardCollection.loadData()
    }
    
    func done() {
        dismiss()
    }
    
    func removeCards(at offsets: IndexSet) {
        cardCollection.cards.remove(atOffsets: offsets)
        cardCollection.saveData()
    }
    
    func addCard() {
        let trimmedPrompt = prompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = prompt.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else { return }
        
        let card = Card(prompt: prompt, answer: answer)
        cardCollection.cards.insert(card, at: 0)
        prompt = ""
        answer = ""
        cardCollection.saveData()
    }
}

//struct EditCards_Previews: PreviewProvider {
//    static var previews: some View {
//        EditCards(cardCollection: CardCollection())
//    }
//}
