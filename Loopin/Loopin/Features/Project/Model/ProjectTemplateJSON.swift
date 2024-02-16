//
//  ProjectTemplateJSON.swift
//  Loopin
//
//  Created by Celine Margaretha on 11/01/24.
//

import Foundation
struct ProjectTemplateJSON: Identifiable, Codable {
    let id = UUID()
    
    var type: String
    var name: String
    var image: String
    var description: String
    var preparation: String
    var yarnType: String
    var yarnWeight: String
    var hookSize: String
    var stitchType: String
    var subParts: [SubPart] = []
    var sample: Gauges
}
