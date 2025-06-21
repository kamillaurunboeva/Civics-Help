//
//  StateSelectionView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 6/14/25.
//

import SwiftUI

let usStates: [String: String] = [
    "AL": "Alabama", "AK": "Alaska", "AZ": "Arizona", "AR": "Arkansas", "CA": "California",
    "CO": "Colorado", "CT": "Connecticut", "DE": "Delaware", "FL": "Florida", "GA": "Georgia",
    "HI": "Hawaii", "ID": "Idaho", "IL": "Illinois", "IN": "Indiana", "IA": "Iowa",
    "KS": "Kansas", "KY": "Kentucky", "LA": "Louisiana", "ME": "Maine", "MD": "Maryland",
    "MA": "Massachusetts", "MI": "Michigan", "MN": "Minnesota", "MS": "Mississippi", "MO": "Missouri",
    "MT": "Montana", "NE": "Nebraska", "NV": "Nevada", "NH": "New Hampshire", "NJ": "New Jersey",
    "NM": "New Mexico", "NY": "New York", "NC": "North Carolina", "ND": "North Dakota", "OH": "Ohio",
    "OK": "Oklahoma", "OR": "Oregon", "PA": "Pennsylvania", "RI": "Rhode Island", "SC": "South Carolina",
    "SD": "South Dakota", "TN": "Tennessee", "TX": "Texas", "UT": "Utah", "VT": "Vermont",
    "VA": "Virginia", "WA": "Washington", "WV": "West Virginia", "WI": "Wisconsin", "WY": "Wyoming"
]

struct StateSelectionView: View {
    @EnvironmentObject var appState: AppStateManager
    
    var body: some View {
        NavigationStack {
            List(usStates.sorted(by: { $0.value < $1.value }), id: \.key) { abbreviation, name in
                Button(action: {
                    appState.selectedState = abbreviation
                }) {
                    Text(name)
                }
            }
            .navigationTitle("Выберите свой штат")
        }
    }
}


#Preview {
    StateSelectionView()
}
