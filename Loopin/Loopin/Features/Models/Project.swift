//
//  ProjectTemplateData.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 08/01/24.
//

import Foundation
struct Project: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let image: String
    let description: String
    let preparation: String
    let yarntType: String
    let yarnWeight: String
    let hookSize: String
    let stitchType: String
    let subPart: [SubPart]
    let sample: [Gauges]
}
