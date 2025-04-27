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
        let apiKey = "AIzaSyBrALYXwUW1fKXTdu5MBzqBnkLmIXoPvRgat"
        let urlString = "https://www.googleapis.com/civicinfo/v2/representatives?address=\(zipCode)&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoded = try JSONDecoder().decode(CivicAPIResponse.self, from: data)
            
            let federalTitles = [
                "President of the United States",
                "Vice President of the United States",
                "United States Senator",
                "United States Representative",
                "Speaker of the House"
            ]
            
            var representatives: [Representative] = []
            
            for office in decoded.offices {
                if federalTitles.contains(office.name) {
                    for index in office.officialIndices {
                        guard index < decoded.officials.count else { continue }
                        let official = decoded.officials[index]
                        
                        representatives.append(Representative(
                            name: official.name,
                            position: office.name,
                            party: official.party ?? "Unknown",
                            photoUrl: official.photoUrl ?? ""

                    ))
                    }
                }
            }
            
            return representatives
        } catch {
            print("JSON decode error: \(error)")
            print("Raw JSON:\n", String(data: data, encoding: .utf8) ?? "Cannot read")
            throw error
        }
    }
}

