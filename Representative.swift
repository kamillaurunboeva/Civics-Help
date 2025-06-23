//
//  Representative.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/16/25.
//

import Foundation

struct Representative: Identifiable {
    let id = UUID()
    let name: String
    let position: String
    let party: String
    let photoUrl: String
}
