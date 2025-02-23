//
//  JSONLoader.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/21/25.
//

import Foundation

struct QuizQuestion: Codable, Identifiable {
    let id = UUID() 
    let answer: Int
    let question: [String: String]
    let answers: [AnswerOption]
}

struct AnswerOption: Codable {
    let num: Int
    let text: [String: String]
}
