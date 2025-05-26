//
//  FlashCardView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 5/14/25.
//

import SwiftUI

struct FlashCardView: View {
    var question: Question
    var isRussian: Bool = false
    @State private var isFlipped = false

    var body: some View {
        VStack {
            Text(isFlipped ? correctAnswerText() : (isRussian ? question.question.rus : question.question.eng))
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
                .animation(.easeInOut, value: isFlipped)
                .onTapGesture {
                    withAnimation {
                        isFlipped.toggle()
                    }
                }
        }
    }

    private func correctAnswerText() -> String {
        if let correct = question.answers.first(where: { $0.num == question.answer }) {
            return isRussian ? correct.text.rus : correct.text.eng
        }
        return "Answer not available"
    }
}


 #Preview {
        let questions = QuestionLoader.loadQuestions()
        if let first = questions.first {
            FlashCardView(question: first)
        } else {
            Text("No questions found")
        }
    }
