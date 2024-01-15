//
//  Hook.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 08/01/24.
//

import Foundation
struct Hook: Identifiable, Hashable, Decodable {
    let id = UUID()
    let title: String
    let content: String
}
