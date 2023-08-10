//
//  Resort.swift
//  SnowSeeker
//
//  Created by Dev Patel on 7/22/23.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
    static func sortByName(lhs: Resort, rhs: Resort) -> Bool {
        lhs.name < rhs.name
    }
    
    static func sortByCountry(lhs: Resort, rhs: Resort) -> Bool {
        lhs.country < rhs.country
    }
}
