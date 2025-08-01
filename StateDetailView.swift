//
//  StateDetailView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 7/22/25.
//

import SwiftUI

struct StateDetailView: View {
    let state: StateInfo

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Governor: \(state.governor)").bold()
                Text("Party: \(state.party)")
                Text("Capital: \(state.capital)")
                Divider().padding(.vertical)

                Text("Senators:")
                    .font(.headline)

                ForEach(state.senators, id: \.name) { senator in
                    Text("• \(senator.name) (\(senator.party))")
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(state.state)
    }
}

