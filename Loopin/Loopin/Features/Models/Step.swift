//
//  Step.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 09/01/24.
//

import Foundation
struct Step: Decodable, Hashable {
    let text: String
    let nums: [Int]
    let guidances: [String]
}
