//
//  NewPhotoView.swift
//  PhotoGallery
//
//  Created by Dev Patel on 7/5/23.
//

import SwiftUI

struct NewPhotoView: View {
    @ObservedObject var photosContainer: PhotosContainer
    @Environment(\.dismiss) var dismiss
    
    @State private var showingImagePicker = false
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var imageName = ""
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        ScrollView {
            ZStack {
                Rectangle()
                    .fill(.gray)
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                    .padding(.horizontal)
                Image(systemName: "camera")
                    .font(.largeTitle)
                image?
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal)
            }
            .onChange(of: inputImage) { _ in loadImage() }
            VStack {
                if image != nil {
                    TextField("Add photo description", text: $imageName)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.secondary)
                        )
                }
                Button("Import a photo...") {
                    showingImagePicker = true
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Add New Photo")
        .toolbar {
            Button("Save") {
                savePhoto()
                dismiss()
            }
            .disabled(image == nil || imageName.isBlank)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onDisappear(perform: locationFetcher.stop)
    }
    
    func loadImage() {
        guard let uiImage = inputImage else {
            image = nil
            return
        }
        image = Image(uiImage: uiImage)
        locationFetcher.start()
    }
    
    func savePhoto() {
        var photo = Photo(imageName: imageName)
        photo.latitude = locationFetcher.lastKnownLocation?.latitude
        photo.longitude = locationFetcher.lastKnownLocation?.longitude
        photosContainer.photos.append(photo)
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("\(photo.id).jpeg")
        
        if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}

extension String {
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace})
    }
}

struct NewPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        NewPhotoView(photosContainer: PhotosContainer())
    }
}
