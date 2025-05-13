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
        TabView {
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "house")
                }
            
            ZipCodeEntryView() // <- Correct SwiftUI View here
                .tabItem {
                    Label("Representative", systemImage: "person.2.fill")
                }
            
            //            SettingsView()
            //                .tabItem {
            //                    Label("Settings", systemImage: "gear")
            //                }
        }
        
    }
}
#Preview {
    ContentView()
        .environmentObject(StarredQuestions())
}
