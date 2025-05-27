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
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.indigo)
                .frame(height: 300)
                .shadow(radius: 5)
            
            VStack {
                if isFlipped {
                    Text(correctAnswerText())
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                } else {
                    Text(isRussian ? question.question.rus : question.question.eng)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                }
                
            }
        }
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
            }
        }
        .padding()
    }

    private func correctAnswerText() -> String {
           guard let correct = question.answers.first(where: { $0.num == question.answer }) else {
               return "Answer not available"
           }
           return isRussian ? correct.text.rus : correct.text.eng
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

