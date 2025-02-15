//
//  DetailView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/1/25.
//

import SwiftUI

struct DetailView: View {
    let category: QuizCategory
    
    var body: some View {
        VStack {
            Text("\(category.rawValue)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Number of quizes: \(category.quizCount)")
                          .font(.headline)
            
                
            Spacer()
        }
        .navigationTitle(category.rawValue)
    }
}

#Preview {
    DetailView(category: .civicsTest)
}
