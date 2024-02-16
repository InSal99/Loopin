//
//  Step.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 09/01/24.
//

import Foundation
struct Step: Codable, Hashable {
    var text: String
    var nums: Int
    var isStitch: Bool
    var guidances: [String] = []
}
