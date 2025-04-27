//
//  RepresentativeListView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/12/25.
//

import SwiftUI

mport SwiftUI

struct RepresentativeListView: View {
    let zipCode: String
    @State private var representatives: [Representative] = []
    @State private var isLoading = true
    @State private var error: Error?
    @State private var showError = false

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading representatives...")
            } else {
                List(representatives) { representative in
                    NavigationLink(destination: RepresentativeDetailView(representative: representative)) {
                        RepresentativeRowView(representative: representative)
                    }
                }
            }
        }
        .navigationTitle("Your Representatives")
        .alert("Error", isPresented: $showError, presenting: error) { _ in
            Button("OK") {}
        } message: { error in
            Text(error.localizedDescription)
        }
        .task {
            await loadRepresentatives()
        }
    }

    private func loadRepresentatives() async {
        isLoading = true
        do {
            representatives = try await CivicAPIService.shared.fetchRepresentatives(for: zipCode)
        } catch {
            self.error = error
            self.showError = true
        }
        isLoading = false
    }
}

struct RepresentativeRowView: View {
    let representative: Representative

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                RepresentativeImageView(photoURL: representative.photoUrl!)

                VStack(alignment: .leading) {
                    Text(representative.name)
                        .font(.headline)
                    Text(representative.position)
                        .font(.subheadline)
                    Text(representative.party)
                        .font(.caption)
                        .foregroundColor(representative.party == "Democratic" ? .blue : .red)
                }
            }
        }
        .padding(.vertical)
    }
}

struct RepresentativeImageView: View {
    let photoURL: String

    var body: some View {
        Group {
            if let url = URL(string: photoURL), !photoURL.isEmpty {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure, .empty:
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(.gray)
                    @unknown default:
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(.gray)
                    }
                }
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 50, height: 50)
        .clipShape(Circle())
    }
}

#Preview {
    NavigationView {
        RepresentativeListView(zipCode: "32811")
    }
}

