//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Dev Patel on 7/22/23.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    enum SortResorts: String {
        case `default` = "Default", alphabetical = "Alphabetical", country = "Country"
    }
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    @State private var sortResorts = SortResorts.default
    @State private var showingSortOptions = false
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .strokeBorder(.black, lineWidth: 1)
                            )
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "star.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                HStack(spacing: 0) {
                    Button("Sort:") {
                        showingSortOptions = true
                    }
                    
                    Button {
                        if sortResorts == .alphabetical {
                            sortResorts = .default
                        } else {
                            sortResorts = .alphabetical
                        }
                    } label: {
                        Label("\(SortResorts.alphabetical.rawValue) Sort", systemImage: "character")
                    }
                    .saturation(sortResorts == .alphabetical ? 1 : 0)
                    
                    Button {
                        if sortResorts == .country {
                            sortResorts = .default
                        } else {
                            sortResorts = .country
                        }
                    } label: {
                        Label("\(SortResorts.alphabetical.rawValue) Sort", systemImage: "flag.checkered")
                    }
                    .saturation(sortResorts == .country ? 1 : 0)
                }
                .accessibilityElement()
                .accessibilityLabel("Sort resorts by name or country")
            }
            .confirmationDialog("Sort resorts by:", isPresented: $showingSortOptions) {
                Button(SortResorts.alphabetical.rawValue) { sortResorts = .alphabetical }
                Button(SortResorts.country.rawValue) { sortResorts = .country }
                Button(SortResorts.default.rawValue) { sortResorts = .default }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        //.phoneOnlyNavigationView()
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var sortedResorts: [Resort] {
        switch sortResorts {
        case .default:
            return filteredResorts.sorted {
                favorites.contains($0) || favorites.contains($1)
            }
        case .alphabetical:
            return filteredResorts.sorted(by: Resort.sortByName(lhs:rhs:))
        case .country:
            return filteredResorts.sorted(by: Resort.sortByCountry(lhs:rhs:))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
