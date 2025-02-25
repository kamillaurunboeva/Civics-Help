//
//  CivicAPIModels.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/16/25.
//

import Foundation

import Foundation

// Struct for API response
struct CivicAPIResponse: Codable {
    let offices: [Office]
    let officials: [Official]
}

// Struct for Government Offices (like "U.S. Senator")
struct Office: Codable {
    let name: String
    let officialIndices: [Int]
}

//Struct for Officials (like "TRUMP")
struct Official: Codable {
    let name: String
    let party: String?
}

//Model to Use in SwiftUI View
struct Representatives: Identifiable {
    let id = UUID()
    let name: String
    let office: String
    let party: String
}
