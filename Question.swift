//
//  Question.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 4/18/25.
//

import Foundation

struct Question: Codable, Identifiable, Hashable {
    var id: UUID
    let answer: Int
    let question: LocalizedText
    let answers: [Answer]

    
    
    enum CodingKeys: String, CodingKey {
        case id, answer, question, answers
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        self.answer = try container.decode(Int.self, forKey: .answer)
        self.question = try container.decode(LocalizedText.self, forKey: .question)
        self.answers = try container.decode([Answer].self, forKey: .answers)
    }


    
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Answer: Codable, Hashable {
    let num: Int
    let text: LocalizedText
}

struct LocalizedText: Codable, Hashable {
    let eng: String
    let rus: String
}
