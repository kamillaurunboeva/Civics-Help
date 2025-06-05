//
//  AllFlashCards.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 5/17/25.
//

//
//  AllFlashCards.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 5/17/25.


import SwiftUI

struct AllFlashCards: View {
        let questions = QuestionLoader.loadQuestions()
    @State private var currentIndex = 0
    @State private var selectedLanguage = "English"

    var body: some View {
            NavigationStack {
                ZStack {
                    Color.white.ignoresSafeArea()

                    VStack(spacing: 16) {
                        Text("Civics Help")
                            .font(.title)
                            .bold()

                        // Top Bar
                        HStack {
                                
                            Menu {
                                Button("English", action: { selectedLanguage = "English" })
                                Button("Русский", action: { selectedLanguage = "Russian" })
                            } label: {
                                Label(selectedLanguage, systemImage: "globe")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }

                            Spacer()

                            Text("Card \(currentIndex + 1) / \(questions.count)")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)

                        // Progress Bar
                        ProgressView(value: Double(currentIndex + 1), total: Double(questions.count))
                            .progressViewStyle(LinearProgressViewStyle(tint: .green))
                            .frame(height: 6)
                            .padding(.horizontal)

                        Spacer()

                        FlashCardView(question: questions[currentIndex])

                        Spacer()

                        // Arrows + Star
                        HStack(spacing: 100) {
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
                        .padding(.bottom)
                    }
                }
                
            }

        }

        
    }

    #Preview {
        AllFlashCards()
    }
