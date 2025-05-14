//
//  CategoryCard.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/1/25.
//

import SwiftUI

struct CategoryCard: View {
    let category: QuizCategory
    
    var body: some View {
        VStack {
            Image(systemName: category.icon)
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Text(category.rawValue)
                .font(.headline)
                .foregroundColor(.white)
            
            // Text("\(category.quizCount) Quizzes")
            //     .font(.subheadline)
            //     .foregroundColor(.white.opacity(0.8))
        }
        .frame(width: 150, height: 150)
        .background(category == .civicsTest ? Color.red : Color.blue)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}
#Preview {
    CategoryCard(category: .civicsTest)
}
