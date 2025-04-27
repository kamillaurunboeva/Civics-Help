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
                if let photoUrl = representative.photoUrl,
                   !photoUrl.isEmpty,
                   let url = URL(string: photoUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(.gray)
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

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Representative Details")
    }
}

#Preview {
    RepresentativeDetailView(representative: Representative(
        name: "",
        position: "",
        party: "",
        photoUrl: nil 
    ))

}
