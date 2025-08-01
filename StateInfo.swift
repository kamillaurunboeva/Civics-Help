//
//  SateInfo.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 7/22/25.
//

import Foundation

struct StateInfo: Identifiable, Codable {
    var id: String { state }
    let state: String
    let governor: String
    let party: String
    let capital: String
    let senators: [Senator]
}

struct Senator: Codable {
    let name: String
    let party: String
}

extension StateInfo {
    func saveAsSelected() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "selectedState")
        }
    }

    static func loadSelected() -> StateInfo? {
        if let data = UserDefaults.standard.data(forKey: "selectedState"),
           let decoded = try? JSONDecoder().decode(StateInfo.self, from: data) {
            return decoded
        }
        return nil
    }
    
    static func clearSelected() {
            UserDefaults.standard.removeObject(forKey: "selectedState")
        }
    }


