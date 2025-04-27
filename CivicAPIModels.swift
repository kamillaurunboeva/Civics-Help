//
//  CivicAPIModels.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/16/25.
//

import Foundation

struct CivicAPIResponse: Codable {
    let offices: [Office]
    let officials: [Official]
}

struct Office: Codable {
    let name: String
    let officialIndices: [Int]
}

struct Official: Codable {
    let name: String
    let party: String?
}

struct Representatives: Identifiable {
    let id = UUID()
    let name: String
    let office: String
    let party: String
}
