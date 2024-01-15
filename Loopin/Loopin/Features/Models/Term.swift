//
//  Term.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 15/01/24.
//

import Foundation
struct Term: Identifiable, Hashable, Decodable {
    let id = UUID()
    let title: String
    let content: String
    let image: String
}
