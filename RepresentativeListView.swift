//
//  RepresentativeListView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/12/25.
//

import SwiftUI

struct RepresentativeListView: View {
    @EnvironmentObject var appState: AppStateManager
    @State private var representatives: [Representative] = []
    @State private var isLoading = true

    var body: some View {
        NavigationStack {
            if isLoading {
                ProgressView("Loading...")
            } else {
                List(representatives) { rep in
                    VStack(alignment: .leading) {
                        Text(rep.name).bold()
                        Text(rep.position)
                        Text(rep.party).foregroundColor(.gray)
                    }
                }
                .navigationTitle("Your Representatives")
                .toolbar {
                    Button("Change ZIP") {
                        appState.resetZipCode()
                    }
                }
            }
        }
        .task {
            await loadRepresentatives()
        }
        

    }

    private func loadRepresentatives() async {
        guard !appState.userZipCode.isEmpty else {
            print("ZIP not set")
            return
        }

        do {
            self.representatives = try await CivicAPIService.shared.fetchRepresentatives(for: appState.userZipCode)
        } catch {
            print("Failed to fetch reps: \(error)")
        }

        isLoading = false
    }

}


#Preview {
        RepresentativeListView()
        
}

