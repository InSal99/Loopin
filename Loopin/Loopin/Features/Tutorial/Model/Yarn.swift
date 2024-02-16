//
//  Yarn.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 08/01/24.
//

import Foundation
struct Yarn: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let image: String
    let weight: String
    let hook: String
    let characteristic: String
    let recommend: [String]
    let notRecommend: [String]
}
