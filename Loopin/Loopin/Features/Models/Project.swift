//
//  ProjectTemplateData.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 08/01/24.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Project: Identifiable, Codable {
    @DocumentID var id: String?
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
