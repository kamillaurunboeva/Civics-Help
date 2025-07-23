//
//  StateDataLoader.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 7/22/25.
//

import Foundation

class StateDataLoader: ObservableObject {
    @Published var states: [StateInfo] = []

    init() {
        loadStates()
    }

    func loadStates() {
        guard let url = Bundle.main.url(forResource: "us_governors_with_capitals_and_senators", withExtension: "json") else {
            print("Could not find JSON file.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decodedStates = try JSONDecoder().decode([StateInfo].self, from: data)
            self.states = decodedStates
        } catch {
            print("Failed to decode JSON: \(error)")
        }
    }
}
