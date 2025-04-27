//
//  StudyMaterialView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/17/25.
//

import SwiftUI

struct StudyMaterialView: View {
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

            List(questions.indices, id: \.self) { index in
                let question = questions[index]
                let correct = question.answers.first { $0.num == question.answer }

                VStack(alignment: .leading, spacing: 6) {
                    if !isRussian {
                      
                        Text("\(index + 1). \(question.question.eng)")
                            .font(.headline)

                        if let correct = correct {
                            Text("✅ \(correct.text.eng)")
                                .font(.callout)
                                .foregroundColor(.green)
                        }
                    } else {
                
                        Text("\(index + 1). \(question.question.rus)")
                            .font(.headline)

                        if let correct = correct {
                            Text("✅ \(correct.text.rus)")
                                .font(.callout)
                                .foregroundColor(.green)
                        }
                    }
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Civics Help")
    }
}

#Preview {
    StudyMaterialView()
}
