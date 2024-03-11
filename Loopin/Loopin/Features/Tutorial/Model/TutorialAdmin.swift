//
//  TutorialAdmin.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 12/03/24.
//

import Foundation
struct TutorialAdmin: Identifiable, Hashable, Decodable {
    let id = UUID()
    let title: String
    let content: String
}
