//
//  SwiftUIView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 3/2/25.
//

import SwiftUI

struct RepresentativeDetailView: View {
    let representative: Representative
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let url = URL(string: representative.photoUrl),
                   !representative.photoUrl.isEmpty {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                    }
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.gray)
                }
                
                VStack(spacing: 10) {
                    Text(representative.name)
                        .font(.title)
                        .bold()
                    
                    Text(representative.position)
                        .font(.title2)
                    
                    Text(representative.party)
                        .font(.headline)
                        .foregroundColor(representative.party == "Democratic" ? .blue : .red)
                }
                
                // Add more details and contact information here
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Representative Details")
    }
}
    #Preview {
        RepresentativeDetailView(representative: Representative(
            name: "Sample Name",
            position: "Sample Position",
            party: "Democratic",
            photoUrl: ""
        ))
    }
