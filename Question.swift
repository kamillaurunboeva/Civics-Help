//
//  Question.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 4/18/25.
//

import Foundation

struct Question: Codable, Identifiable {
    var id = UUID()
    let answer: Int
    let question: LocalizedText
    let answers: [Answer]

    enum CodingKeys: String, CodingKey {
        case answer, question, answers
    }
}

struct Answer: Codable {
    let num: Int
    let text: LocalizedText
}

struct LocalizedText: Codable {
    let eng: String
    let rus: String
}
