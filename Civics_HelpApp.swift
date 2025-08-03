//
//  Civics_HelpApp.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/1/25.
//

import SwiftUI

@main
struct Civics_HelpApp: App {
    @StateObject var starred = StarredQuestions()
    var body: some Scene {
        WindowGroup {
                ContentView()
                .environmentObject(starred)
            }
               
        }
    }
