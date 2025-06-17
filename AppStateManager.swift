//
//  AppStateManager.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 6/14/25.
//

import Foundation
import Combine

class AppStateManager: ObservableObject {
    @Published var selectedState: String? {
        didSet {
            if let state = selectedState {
                UserDefaults.standard.set(state, forKey: "SelectedState")
            }
        }
    }

    init() {
        self.selectedState = UserDefaults.standard.string(forKey: "SelectedState")
    }

    func resetStateSelection() {
        UserDefaults.standard.removeObject(forKey: "SelectedState")
        selectedState = nil
    }
}
