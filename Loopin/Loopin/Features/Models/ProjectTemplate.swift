//
//  ProjectTemplateData.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 08/01/24.
//

import Foundation
struct ProjectTemplate: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let image: String
    let description: String
    let preparation: String
    let subPart: [SubPart]
    let gauge: [Gauges]
}
