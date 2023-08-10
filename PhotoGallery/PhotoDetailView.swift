//
//  PhotoDetailView.swift
//  PhotoGallery
//
//  Created by Dev Patel on 7/5/23.
//
import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    var location: CLLocationCoordinate2D
}

struct PhotoDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var photosContainer: PhotosContainer
    
    @State private var showingDeleteAlert = false
    @State private var showingDeleteResult = false
    @State private var showingMap = false
    @State private var deleteAlertTitle = ""
    @State private var deleteAlertMessage = ""
    @State private var imageName: String
    let photo: Photo
    let coordinateRegion: MKCoordinateRegion?
    
    var locations = [Location]()
    
    var body: some View {
        VStack {
            VStack {
                photo.image?
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                TextField("Change your image description", text: $imageName)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.secondary)
                    )
                Button("Update Description", action: updateImageName)
                    .buttonBorderShape(.capsule)
            }
            .padding(.horizontal)
            
            Toggle("Show Photo Location", isOn: $showingMap.animation(.easeIn))
                .disabled(coordinateRegion == nil)
                .padding(.horizontal)
            
            if showingMap {
                Map(coordinateRegion: .constant(coordinateRegion!), annotationItems: locations) { location in
                    MapMarker(coordinate: location.location)
                }
                .ignoresSafeArea()
            } else {
                Spacer()
            }
        }
        .navigationTitle(photo.imageName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete Photo", systemImage: "trash")
            }
        }
        .alert("Deleting Photo", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                deletePhoto()
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?\nThis photo will be deleted permanently")
        }
        .alert(deleteAlertTitle, isPresented: $showingDeleteResult) {
            Button("OK") { }
        } message: {
            Text(deleteAlertMessage)
        }
    }
    
    func deletePhoto() {
        let index = photosContainer.photos.firstIndex(of: photo)
        let photoToDelete = photosContainer.photos[index!]
        let savePath = FileManager.documentsDirectory.appendingPathComponent("\(photoToDelete.id).jpeg")
        if FileManager.default.fileExists(atPath: savePath.path) {
            try? FileManager.default.removeItem(at: savePath)
            deleteAlertTitle = "Success"
            deleteAlertMessage = "Photo was deleted successfully"
        } else {
            print("File at \(savePath.path) doesn't exist")
            deleteAlertTitle = "Failed"
            deleteAlertMessage = "There was an error trying to delete this photo"
        }
        photosContainer.photos.remove(at: index!)
        showingDeleteResult = true
    }
    
    init(photosContainer: PhotosContainer, photo: Photo) {
        self.photosContainer = photosContainer
        self.photo = photo
        _imageName = State(initialValue: photo.imageName)
        if let latitude = photo.latitude,
           let longitude = photo.longitude {
            
            coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.locations.append(Location(location: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
            
        } else {
            coordinateRegion = nil
        }
    }
    
    func updateImageName() {
        let index = photosContainer.photos.firstIndex(of: photo)
        photosContainer.photos[index!].imageName = imageName
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhotoDetailView(photosContainer: PhotosContainer(), photo: Photo(imageName: "Test Image"))
        }
    }
}
