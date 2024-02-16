//
//  Pattern.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 08/01/24.
//

import Foundation
struct Pattern: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let symbol: String
    let abbreviation: String
    let content: [PatternContent]
}
