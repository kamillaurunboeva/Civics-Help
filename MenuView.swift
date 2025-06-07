//
//  MenuView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 5/12/25.
//

import SwiftUI

struct MenuView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

        var body: some View {
            NavigationStack {
                ZStack {
                    Color(.systemGray6)
                        .ignoresSafeArea()

                    VStack {
                        Text("Civics Help")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.top, 0)

                        Spacer()

                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(QuizCategory.allCases, id: \.self) { category in
                                NavigationLink(destination: destinationView(for: category)) {
                                    CategoryCard(category: category)
                                }
                            }
                        }
                        .padding()

                        Spacer()
                    }
                    .padding()
                    .frame(maxHeight: .infinity, alignment: .top)
                }
            }
        }

        @ViewBuilder
        func destinationView(for category: QuizCategory) -> some View {
            switch category {
            case .civicsTest:
                CivicsTestView()
            case .starredTest:
                StarredTestView()
            case .stateRepresentative:
                ZipCodeEntryView()
            case .studyMaterial:
                StudyMaterialView()
            case .flashCards: 
                AllFlashCards()
            default:
                DetailView(category: category)
            }
        }
    }

#Preview {
    MenuView()
}
