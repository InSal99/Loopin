//
//  SubPart.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 08/01/24.
//

import Foundation
struct SubPart: Codable, Hashable {
    var name: String
    var steps: [Step] = []
    var gauge: Gauges
}
