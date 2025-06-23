//
//  AppStateManager.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 6/14/25.
//

import Foundation
import Combine

class AppStateManager: ObservableObject {
    @Published var userZipCode: String {
        didSet {
            UserDefaults.standard.set(userZipCode, forKey: "userZipCode")
        }
    }

    init() {
        self.userZipCode = UserDefaults.standard.string(forKey: "userZipCode") ?? ""
    }

    func resetZipCode() {
        userZipCode = ""
        UserDefaults.standard.removeObject(forKey: "userZipCode")
    }
}
