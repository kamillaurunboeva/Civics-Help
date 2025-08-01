//
//  SwiftUIView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 7/22/25.
//

import SwiftUI

struct StatesListView: View {
    @StateObject private var loader = StateDataLoader()
    @State private var selectedState: StateInfo? = StateInfo.loadSelected()


    var body: some View {
        NavigationStack {
            if loader.states.isEmpty {
                ProgressView("Loading...")
            } else {
                List {
                    // My State section (если есть сохранённый)
                    if let savedState = StateInfo.loadSelected() {
                        Section {
                            NavigationLink(destination: StateDetailView(state: savedState)) {
                                Text("📍Go to My State: \(savedState.state)")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                        }
                    }

                    // Все Штаты
                    ForEach(loader.states) { state in
                        NavigationLink(destination: StateDetailView(state: state)) {
                            VStack(alignment: .leading) {
                                Text(state.state).font(.headline)
                                Text("Governor: \(state.governor)").font(.subheadline)
                            }
                        }
                        .onTapGesture {
                            state.saveAsSelected()
                        }
                    }
                }
                .navigationTitle("Choose Your State")
            }
        }
    }
}

#Preview {
    StatesListView()
}

