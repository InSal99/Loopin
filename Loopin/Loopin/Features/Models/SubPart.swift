//
//  SubPart.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 08/01/24.
//

import Foundation
struct SubPart: Decodable, Hashable {
    let name: String
    let steps: [Step]
    let gauge: Gauges
}
