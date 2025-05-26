//
//  AllFlashCards.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 5/17/25.
//

import SwiftUI

struct AllFlashCards: View {
        let questions = QuestionLoader.loadQuestions()
        @State private var isRussian = false

        var body: some View {
            VStack {
                Picker("Language", selection: $isRussian) {
                    Text("🇺🇸 English").tag(false)
                    Text("🇷🇺 Русский").tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(questions.prefix(100), id: \.id) { question in
                            FlashCardView(question: question, isRussian: isRussian)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 3)
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .navigationTitle("FlashCards")
        }
    }

#Preview {
    AllFlashCards()
}
