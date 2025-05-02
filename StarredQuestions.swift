//
//  StarredQuestions.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 4/26/25.
//

import Foundation

class StarredQuestions: ObservableObject {
    @Published var questions: [Question] = []
    
    func load(from allQuestions: [Question]) {
        if let savedIds = UserDefaults.standard.array(forKey: "StarredQuestions") as? [String] {
            let savedUUIDs = savedIds.compactMap { UUID(uuidString: $0) }
            self.questions = allQuestions.filter { savedUUIDs.contains($0.id) }
        }
     }
}
