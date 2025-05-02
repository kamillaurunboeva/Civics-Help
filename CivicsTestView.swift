//
//  CivicsTestView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/17/25.
//

import SwiftUI

struct CivicsTestView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var starred: StarredQuestions // <-- Added environment object

    
    @State private var questions: [Question] = []
    @State private var currentIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var correctCount = 0
    @State private var timeElapsed = 0
    @State private var showResults = false
    @State private var selectedLanguage = "English"
    @State private var starredQuestions: Set<Question> = []
    @State private var showLanguageMenu = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()

                if questions.isEmpty {
                    ProgressView("Loading...")
                        .onAppear(perform: loadQuestions)
                } else if showResults {
                    VStack(spacing: 20) {

                        HStack {
                            Button(action:  {
                                dismiss()
                            }) {
                                Image(systemName: "chevron.backward")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)

                        
                        Text("✅ Test Completed")
                            .font(.largeTitle)
                            .bold()

                        Text("You got \(correctCount) out of 10 correct!")
                            .font(.title3)
                            .foregroundColor(.black)

                        Text("Time: \(formatTime(timeElapsed))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Button("🔁 Retake Test") {
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
                            // Backward Button
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "chevron.backward")
                                    .font(.title2)
                                    .padding(8)
//                                    .background(Color.white)
                                    .foregroundColor(.blue)
//                                    .clipShape(Circle())
                            }

                            Spacer()

                            // Language Menu
                            Menu {
                                Button("English", action: { selectedLanguage = "English" })
                                Button("Русский", action: { selectedLanguage = "Russian" })
                            } label: {
                                Label(selectedLanguage, systemImage: "globe")
                                    .font(.subheadline)
                            }

                            Spacer()

                            // Timer
                            Text("\(formatTime(timeElapsed))")
                                .font(.subheadline)
                                .padding(.trailing, 4)
                        }
                        .padding(.horizontal)

//Progress-bar
                        ProgressView(value: Double(currentIndex + 1), total: 10)
                            .progressViewStyle(LinearProgressViewStyle(tint: .green))
                            .frame(height: 12)
                            .padding(.horizontal)
                        Spacer()
                            
//Quiz Section
                        QuestionCardView(
                            
                            question: questions[currentIndex],
                            selectedAnswer: $selectedAnswer,
                            correctAnswer: questions[currentIndex].answer,
                            isRussian: selectedLanguage == "Russian",
                            correctCount: $correctCount
                        )
                        .transition(.move(edge: .trailing))
                        .animation(.easeInOut, value: currentIndex)

                        Spacer()
// Lest next button
                        HStack(spacing: 50) {
                            Button(action: goToPrevious) {
                                Image(systemName: "chevron.left")
                                    .font(.title2)
                                    .padding()
                                    .frame(width: 50, height: 50)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                            .disabled(currentIndex == 0)

//                            Star to star question
                            Button(action: toggleStarred) {
                                Image(systemName: starredQuestions.contains(questions[currentIndex]) ? "star.fill" : "star")
                                    .font(.title)
                                    .foregroundColor(.yellow)
                            }

//                            Right next button
                            Button(action: goToNext) {
                                Image(systemName: "chevron.right")
                                    .font(.title2)
                                    .padding()
                                    .frame(width: 50, height: 50)
                                    .background(Color.green)
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
        let currentQuestion = questions[currentIndex]
        
        if starredQuestions.contains(currentQuestion) {
            starredQuestions.remove(currentQuestion)
        } else {
            starredQuestions.insert(currentQuestion)
        }
        
        saveStarred()
    }


    private func saveStarred() {
        let ids = starredQuestions.map { $0.id.uuidString }
        UserDefaults.standard.set(ids, forKey: "StarredQuestions")
    }


    private func loadStarred() {
        let allQuestions = QuestionLoader.loadQuestions()

        if let savedIds = UserDefaults.standard.array(forKey: "StarredQuestions") as? [String] {
            let savedUUIDs = savedIds.compactMap { UUID(uuidString: $0) }

            starredQuestions = Set(allQuestions.filter { savedUUIDs.contains($0.id) })
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
        @Binding var correctCount: Int

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
                        answer.num == question.answer {
                            correctCount += 1
                       
                    }
                })
                
                {
                    Text(isRussian ? answer.text.rus : answer.text.eng)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(buttonColor(answer))
                        .foregroundColor(.black)
                        .bold()
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
        .cornerRadius(20)
        .shadow(radius: 1)
    }

    private func buttonColor(_ answer: Answer) -> Color {
        guard let selected = selectedAnswer else { return Color.gray.opacity(0.1) }
        if answer.num == selected {
            return answer.num == correctAnswer ? Color.green.opacity(0.4) : Color.red.opacity(0.4)
        } else if answer.num == correctAnswer {
            return Color.green.opacity(0.3)
        }
        return Color.white
    }
}

#Preview {
    CivicsTestView().environmentObject(StarredQuestions())
}
