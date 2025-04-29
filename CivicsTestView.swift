//
//  CivicsTestView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/17/25.
//

import SwiftUI

struct CivicsTestView: View {
    @State private var questions: [Question] = []
    @State private var currentIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var correctCount = 0
    @State private var timeElapsed = 0
    @State private var showResults = false
    @State private var selectedLanguage = "English"
    @State private var starredQuestions: Set<Int> = []
    @State private var showLanguageMenu = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.90, green: 0.97, blue: 1.0).ignoresSafeArea()

                if questions.isEmpty {
                    ProgressView("Loading...")
                        .onAppear(perform: loadQuestions)
                } else if showResults {
                    VStack(spacing: 20) {
                        Text("Test Completed")
                            .font(.largeTitle)
                            .bold()

                        Text("You got \(correctCount) out of 10 correct!")
                            .font(.title3)
                            .foregroundColor(.black)

                        Text("Time: \(formatTime(timeElapsed))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Button(" Retake Test") {
                            resetTest()
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .padding()
                } else {
                    VStack(spacing: 16) {
                        Text("Civics Help")
                            .font(.title)
                            .bold()

                        HStack {
                            ProgressView(value: Double(currentIndex + 1), total: 10)
                                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                                .frame(height: 8)

                            Spacer()

                            Menu {
                                Button("English", action: { selectedLanguage = "English" })
                                Button("Русский", action: { selectedLanguage = "Russian" })
                            } label: {
                                Label(selectedLanguage, systemImage: "globe")
                                    .font(.subheadline)
                            }

                            Text(" \(formatTime(timeElapsed))")
                                .font(.subheadline)
                                .padding(.trailing)
                        }
                        .padding(.horizontal)

                                                Spacer()

                                                QuestionCardView(
                                                    question: questions[currentIndex],
                                                    selectedAnswer: $selectedAnswer,
                                                    correctAnswer: questions[currentIndex].answer,
                                                    isRussian: selectedLanguage == "Russian"
                                                )
                                                .transition(.move(edge: .trailing))
                                                .animation(.easeInOut, value: currentIndex)

                                                Spacer()

                                                HStack(spacing: 40) {
                                                    Button(action: goToPrevious) {
                                                        Image(systemName: "chevron.left")
                                                            .font(.title2)
                                                            .padding()
                                                            .background(Color.blue)
                                                            .foregroundColor(.white)
                                                            .clipShape(Circle())
                                                    }
                                                    .disabled(currentIndex == 0)

                                                    Button(action: toggleStarred) {
                                                        Image(systemName: starredQuestions.contains(currentIndex) ? "star.fill" : "star")
                                                            .font(.title2)
                                                            .foregroundColor(.yellow)
                                                    }

                                                    Button(action: goToNext) {
                                                        Image(systemName: "chevron.right")
                                                            .font(.title2)
                                                            .padding()
                                                            .background(Color.blue)
                                                            .foregroundColor(.white)
                                                            .clipShape(Circle())
                                                    }
                                                    .disabled(selectedAnswer == nil)
                                                }
                                                .padding(.bottom)
                                            }
                                            .padding()
                                        }
                                    }
                                }
                                .navigationBarBackButtonHidden(true)
                                .onReceive(timer) { _ in
                                    if !showResults {
                                        timeElapsed += 1
                                    }
                                }
                            }

                            private func loadQuestions() {
                                questions = QuestionLoader.loadQuestions().shuffled().prefix(10).map { $0 }
                                loadStarred()
                            }

                            private func resetTest() {
                                questions = QuestionLoader.loadQuestions().shuffled().prefix(10).map { $0 }
                                currentIndex = 0
                                selectedAnswer = nil
                                correctCount = 0
                                timeElapsed = 0
                                showResults = false
                            }

                            private func goToNext() {
                                if currentIndex + 1 < questions.count {
                                    currentIndex += 1
                                    selectedAnswer = nil
                                } else {
                                    showResults = true
                                }
                            }

                            private func goToPrevious() {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                    selectedAnswer = nil
                                }
                            }

                            private func toggleStarred() {
                                if starredQuestions.contains(currentIndex) {
                                    starredQuestions.remove(currentIndex)
                                } else {
                                    starredQuestions.insert(currentIndex)
                                }
                                saveStarred()
                            }

                            private func saveStarred() {
                                UserDefaults.standard.set(Array(starredQuestions), forKey: "StarredQuestions")
                            }

                            private func loadStarred() {
                                if let saved = UserDefaults.standard.array(forKey: "StarredQuestions") as? [Int] {
                                    starredQuestions = Set(saved)
                                }
                            }

                            private func formatTime(_ seconds: Int) -> String {
                                let minutes = seconds / 60
                                let secs = seconds % 60
                                return String(format: "%02d:%02d", minutes, secs)
                            }
                        }

                        struct QuestionCardView: View {
                            var question: Question
                            @Binding var selectedAnswer: Int?
                            var correctAnswer: Int
                            var isRussian: Bool

                            var body: some View {
                                VStack(alignment: .leading, spacing: 20) {
                                    Text(isRussian ? question.question.rus : question.question.eng)
                                        .font(.title2)
                                        .bold()
                                        .padding(.bottom)

                                    ForEach(question.answers, id: \..num) { answer in
                                        Button(action: {
                                            if selectedAnswer == nil {
                                                selectedAnswer = answer.num
                                            }
                                        }) {
                                            Text(isRussian ? answer.text.rus : answer.text.eng)
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .background(buttonBackgroundColor(for: answer))
                                                .foregroundColor(.black)
                                                .cornerRadius(12)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                                )
                                        }
                                        .disabled(selectedAnswer != nil)
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(radius: 4)
                            }

                         private func buttonBackgroundColor(for answer: Answer) -> Color {
                          guard let selected = selectedAnswer else { return Color.white }
                             
                       if answer.num == selected {
                       return answer.num == correctAnswer ? Color.green.opacity(0.4) : Color.red.opacity(0.4)
                           
                      } else if answer.num == correctAnswer {
                     return Color.green.opacity(0.3)
                   }
               return Color.white
               }
            }

                        #Preview {
                            CivicsTestView()
                        }
