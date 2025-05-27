//
//  AllFlashCards.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 5/17/25.
//

import SwiftUI

struct AllFlashCards: View {
        let questions = QuestionLoader.loadQuestions()
       @State private var currentIndex = 0
        @State private var selectedLanguage = "English"

    var body: some View {
        VStack(spacing: 16) {
            Text("Civics Help")
                .font(.title)
                .bold()
            
            HStack {
                Text("Card \(currentIndex + 1) / \(questions.count)")
                    .font(.headline)
                    .padding(.leading)
                
                Spacer()
                
                Menu {
                    Button("English", action: { selectedLanguage = "English" })
                    Button("Русский", action: { selectedLanguage = "Russian" })
                } label: {
                    Label(selectedLanguage, systemImage: "globe")
                        .font(.subheadline)
                }
                .padding(.trailing)
            }
            
            FlashCardView(question: questions[currentIndex])
            
            HStack(spacing: 30) {
                Button(action: {
                    if currentIndex > 0 { currentIndex -= 1 }
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                Button(action: {
                    if currentIndex + 1 < questions.count { currentIndex += 1 }
                }) {
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                    
                }
            }
            
            
          }
        .padding(.top)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 1)
       }
    
    }

#Preview {
    AllFlashCards()
}
