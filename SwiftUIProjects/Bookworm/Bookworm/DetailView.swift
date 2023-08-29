//
//  DetailView.swift
//  Bookworm
//
//  Created by Dev Patel on 6/22/23.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding()
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)
            
            VStack {
                Text(book.review ?? "No review")
                    .padding(.vertical)
                
                RatingView(rating: .constant(Int(book.rating)))
                    .font(.largeTitle)
            }
            
            HStack {
                Text("Review Published: \(book.date?.formatted(date: .abbreviated, time: .shortened) ?? "Unknown Date")")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.trailing)
                Spacer()
            }
            .padding()
        }
        .navigationTitle(book.title ?? "Unknown Title")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        dismiss
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
