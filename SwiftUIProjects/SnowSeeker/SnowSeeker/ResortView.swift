//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Dev Patel on 7/22/23.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    
    @EnvironmentObject var favorites: Favorites
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("By ") + Text("\(resort.imageCredit)").bold()
                        }
                        .font(.caption)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 10))
                        .foregroundColor(.white)
                        .background(.black.opacity(0.7))
                    }
                }
                
                HStack {
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    
                    Button("\(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites")") {
                        if favorited {
                            favorites.remove(resort)
                        } else {
                            favorites.add(resort)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
        .toolbar {
            Button {
                if favorited {
                    favorites.remove(resort)
                } else {
                    favorites.add(resort)
                }
            } label: {
                Label("\(favorited ? "Unfavorite" : "Favorite") Resort", systemImage: "\(favorited ? "star.fill" : "star")")
                    .foregroundColor(.yellow)
            }
        }
    }
    
    var favorited: Bool {
        favorites.contains(resort)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResortView(resort: Resort.example)
                .environmentObject(Favorites())
        }
    }
}
