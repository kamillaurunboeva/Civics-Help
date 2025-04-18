//
//  CivicAPIService.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 4/18/25.
//

import Foundation

class CivicAPIService {
    static let shared = CivicAPIService()
    private init() {}

    func fetchRepresentatives(for zipCode: String) async throws -> [Representative] {
        let apiKey = "YOUR_GOOGLE_API_KEY"
        let urlString = "https://www.googleapis.com/civicinfo/v2/representatives?address=\(zipCode)&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(CivicAPIResponse.self, from: data)
        
        return decoded.officials.enumerated().map { index, official in
            Representative(
                name: official.name,
                position: decoded.offices.first(where: { $0.officialIndices.contains(index) })?.name ?? "Unknown",
                party: official.party ?? "Unknown",
                photoUrl: official.photoUrl ?? ""
            )
        }
    }
}
