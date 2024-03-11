//
//  UserJSON.swift
//  Loopin
//
//  Created by Celine Margaretha on 09/03/24.
//

import Foundation
struct UserJSON: Identifiable, Codable {
    
    var id: String?
    var username: String = ""
    var email: String
    var phone: String = ""
    var postId: [String] = []
    var projectId : [String]?
  
}
