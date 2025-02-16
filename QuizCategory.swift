//
//  QuizCategory.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/1/25.
//

import Foundation

enum QuizCategory: String, CaseIterable {
    case civicsTest = "Civics Test"
//    case writingTest = " Writing Test"
//    case readingTest = "Reading Test"
    case starredTest = "Starred Test"
//    case interviewN400 = " Interview & N400"
    case flashCards = "FlashCards"
    case studyMaterial = "Study Material"
    case stateRepresentative = "Your Representative"
    case randomSetQuiz = "Random Set Quiz"
    
    var icon: String {
        switch self {
        case .civicsTest: return "doc.text"
//        case .writingTest: return "pencil"
//        case .readingTest: return "book"
        case .starredTest: return "star.fill"
//        case .interviewN400: return "person.fill.questionmark"
        case .flashCards: return "rectangle.stack.fill"
        case .studyMaterial: return "openbook.fill"
        case .stateRepresentative: return "person.fill"
        case .randomSetQuiz: return "shuffle.fill"
        }
    }
    
    var quizCount: Int {
        switch self {
        case .civicsTest: return 10
//        case .writingTest: return 38
//        case .readingTest: return 38
        case .studyMaterial: return 100
//        case .interviewN400: return 154
        case .flashCards:
            return QuizDataManager.shared.getFlashCardsCount()
        case .starredTest:
            return QuizDataManager.shared.getStarredTestCount()
        case .stateRepresentative: return 0
        case .randomSetQuiz: return 0
        }
    }
}
