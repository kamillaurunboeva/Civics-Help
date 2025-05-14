//
//  StarredTestView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/1/25.
//

import SwiftUI

struct StarredTestView: View {
    @EnvironmentObject var starred: StarredQuestions

    @State private var questions: [Question] = []
    @State private var currentIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var correctCount = 0
    @State private var timeElapsed = 0
    @State private var showResults = false
    @State private var selectedLanguage = "English"
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()

            VStack(spacing: 16) {

                Menu {
                 Button("English", action: { selectedLanguage = "English" })
                Button("Русский", action: { selectedLanguage = "Russian" })
                } label: {
                Label(selectedLanguage, systemImage: "globe")
                .font(.subheadline)
                        }
                
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top)

                if questions.isEmpty {
                    VStack(spacing: 20) {
                        Text("No Starred Questions")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.blue)

                        Text("Please mark some questions with a star to practice them.")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                } else if showResults {
                    VStack(spacing: 20) {
                        Text("✅ Test Complete")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.blue)

                        Text("You got \(correctCount) out of \(questions.count) correct")
                            .font(.title2)
                            .foregroundColor(.primary)

                        Button("🔁 Retake Test") {
                            resetTest()
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                } else {
                    VStack(spacing: 16) {
                        Text("Question \(currentIndex + 1) of \(questions.count)")
                            .foregroundColor(.blue)
                            .font(.headline)

                        ProgressView(value: Double(currentIndex + 1), total: Double(questions.count))
                            .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                            .padding(.horizontal)

                        Spacer()

                        VStack(alignment: .leading, spacing: 16) {
                            // Вопрос
                            Text(selectedLanguage == "Russian"
                            ?questions[currentIndex].question.rus
                            : questions[currentIndex].question.eng)
                                .font(.title2)
                                .foregroundColor(.black)

                            // Ответы
                            ForEach(questions[currentIndex].answers, id: \.num) { answer in
                                Button(action: {
                                    if selectedAnswer == nil {
                                        selectedAnswer = answer.num
                                        if answer.num == questions[currentIndex].answer {
                                            correctCount += 1
                                        }
                                    }
                                }) {
                                    Text(selectedLanguage == "Russian" ? answer.text.rus : answer.text.eng)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(buttonColor(answer))
                                        .foregroundColor(.black)
                                        .cornerRadius(10)
                                }
                                .disabled(selectedAnswer != nil)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .padding(.horizontal)

                        Spacer()

                        HStack(spacing: 30) {
                            Button(action: goToPrevious) {
                                Image(systemName: "chevron.left")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                            .disabled(currentIndex == 0)

                             Button(action: toggleStarred) {
                                Image(systemName: isStarred(questions[currentIndex]) ? "star.fill" : "star")
                                    .font(.title2)
                                    .foregroundColor(.yellow)
                                                   }

                            Button(action: goToNext) {
                                Image(systemName: "chevron.right")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.bottom)
                    }
                    .onReceive(timer) { _ in
                        timeElapsed += 1
                    }
                }
            }
        }
        .onAppear {
            resetTest()
        }
    }

    private func resetTest() {
        let allQuestions = QuestionLoader.loadQuestions()
        starred.load(from: allQuestions)
        questions = starred.questions.shuffled().prefix(10).map { $0 }

        currentIndex = 0
        selectedAnswer = nil
        correctCount = 0
        timeElapsed = 0
        showResults = false
    }

    private func buttonColor(_ answer: Answer) -> Color {
        guard let selected = selectedAnswer else { return Color.gray.opacity(0.2) }
        if answer.num == selected {
            return answer.num == questions[currentIndex].answer ? Color.green.opacity(0.5) : Color.red.opacity(0.5)
        } else if answer.num == questions[currentIndex].answer {
            return Color.green.opacity(0.3)
        }
        return Color.gray.opacity(0.2)
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
        let question = questions[currentIndex]
        let idString = question.id.uuidString
        var savedIds = UserDefaults.standard.stringArray(forKey: "StarredQuestions") ?? []

        if savedIds.contains(idString) {
            savedIds.removeAll { $0 == idString }
        } else {
            savedIds.append(idString)
        }
        
        UserDefaults.standard.set(savedIds, forKey: "StarredQuestions")

               // Update starred questions and refresh list
               let allQuestions = QuestionLoader.loadQuestions()
               starred.load(from: allQuestions)
               questions = starred.questions.shuffled().prefix(10).map { $0 }

               if currentIndex >= questions.count {
                   currentIndex = max(0, questions.count - 1)
               }

               selectedAnswer = nil
           }
    
    private func isStarred(_ question: Question) -> Bool {
           let savedIds = UserDefaults.standard.stringArray(forKey: "StarredQuestions") ?? []
           return savedIds.contains(question.id.uuidString)
       }
   }

#Preview {
    StarredTestView()
        .environmentObject(StarredQuestions())
}
