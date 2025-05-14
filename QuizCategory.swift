//
//  QuizCategory.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/1/25.
//

import Foundation

enum QuizCategory: String, CaseIterable {
    case civicsTest = "Civics Test"
    case starredTest = "Starred Test"
    case flashCards = "FlashCards"
    case studyMaterial = "Study Material"
    case stateRepresentative = "Your Representative"
    case randomSetQuiz = "Random Set Quiz"
    
    var icon: String {
        switch self {
        case .civicsTest: return "doc.text"
        case .starredTest: return "star.fill"
        case .flashCards: return "rectangle.stack.fill"
        case .studyMaterial: return "book.fill"
        case .stateRepresentative: return "person.fill"
        case .randomSetQuiz: return "shuffle.fill"
        }
    }
    
    var quizCount: Int {
        switch self {
        case .civicsTest: return 10
        case .studyMaterial: return 100
        case .flashCards:
            return QuizDataManager.shared.getFlashCardsCount()
        case .starredTest:
            return QuizDataManager.shared.getStarredTestCount()
        case .stateRepresentative: return 0
        case .randomSetQuiz: return 0
        }
    }
}
