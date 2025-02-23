//
//  ContentView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/1/25.
//

import SwiftUI

struct ContentView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
         
                ZStack{
                    Color(.systemGray6)
                    .ignoresSafeArea()
                    
                    VStack {
                        Text("Civics Help")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxHeight: .infinity, alignment: .top)
                            .padding(.top, 0)
                        
                        
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(QuizCategory.allCases, id: \.self) { category in
                                NavigationLink(destination: DetailView(category: category)) {
                                    CategoryCard(category: category)
                                }
                            }
                        }
                        .padding()
                        
                        Spacer()
                        
                        //                    Button(action: {
                        //                        print("Next button tapped")
                        //                    }) {
                        //                        Text("NEXT")
                        //                            .font(.headline)
                        //                            .frame(maxWidth: .infinity)
                        //                            .padding()
                        //                            .background(Color.red)
                        //                            .foregroundColor(.white)
                        //                            .cornerRadius(10)
                        //                    }
                        
                            .padding()
                        
                        
                    }
                    .padding()
                    .frame(maxHeight: .infinity, alignment: .top)
            }
                
        
        }

    }
}
#Preview {
    ContentView()
}
