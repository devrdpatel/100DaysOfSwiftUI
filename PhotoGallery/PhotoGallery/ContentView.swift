//
//  ContentView.swift
//  PhotoGallery
//
//  Created by Dev Patel on 7/5/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var photosContainer = PhotosContainer()
    @State private var showNewImageView = false
        
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                List(photosContainer.photos.sorted()) { photo in
                    NavigationLink {
                        PhotoDetailView(photosContainer: photosContainer, photo: photo)
                    } label: {
                        HStack {
                            photo.image?
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: .secondary, radius: 5, x: 5, y: 5)
                                .padding()
                            VStack {
                                Text(photo.imageName)
                                    .font(.headline)
                                    .padding(.vertical)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(height: geo.size.height * 0.16)
                    }
                }
                .navigationTitle("PhotoGallery")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            NewPhotoView(photosContainer: photosContainer)
                        } label: {
                            Label("Add New Photo", systemImage: "plus")
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
