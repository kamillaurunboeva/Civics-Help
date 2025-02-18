//
//  QuizDataManager.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/1/25.
//

import Foundation


class QuizDataManager {
    
    static let shared = QuizDataManager()
    private let starredKey = "starredTestCount"
    private let flashCardsKey = "flashCardsCount"
    
    private init() {}
    
    func getStarredTestCount() -> Int {
        return UserDefaults.standard.integer(forKey: starredKey)
    }
    
    func getFlashCardsCount() -> Int {
        return UserDefaults.standard.integer(forKey: flashCardsKey)
    }
    
    func addStarredQuiz() {
        let currentCount = getStarredTestCount()
        UserDefaults.standard.set(currentCount + 1, forKey: starredKey)
    }
    
    func addFlashCards() {
        let currentCount = getFlashCardsCount()
        UserDefaults.standard.set(currentCount + 1, forKey: flashCardsKey)
    }
}
