//
//  QuestionLoader.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 4/18/25.
//

import Foundation

class QuestionLoader {
    static func loadQuestions() -> [Question] {
        guard let url = Bundle.main.url(forResource: "all_questions_ordered", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let questions = try? JSONDecoder().decode([Question].self, from: data) else {
            print("Failed to load or decode questions")
            return []
        }
        return questions
    }
}
