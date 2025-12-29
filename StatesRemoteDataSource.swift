//
//  StatesRemoteDataSource.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 12/28/25.
//

import Foundation

struct StateExtraDTO: Decodable {
    let party: String?
    let capital: String?
    let senators: [Senator]?
}

final class StatesRemoteDataSource {

    func fetchExtra(for state: String) async throws -> StateExtraDTO {
        // TODO: заменить на реальный endpoint
        var comps = URLComponents(string: "https://example.com/state")!
        comps.queryItems = [
            URLQueryItem(name: "q", value: state)
        ]
        let url = comps.url!

        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        // если нужен ключ:
        // req.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: req)

        if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(StateExtraDTO.self, from: data)
    }
}
