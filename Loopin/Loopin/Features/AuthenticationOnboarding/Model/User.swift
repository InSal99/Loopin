//
//  User.swift
//  Loopin
//
//  Created by Celine Margaretha on 01/12/23.
//

//import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    
    @DocumentID var id: String?
    var username: String = ""
    var email: String
    var phone: String?
    var postId: [String]?
    var projectId : [String]?
  
}
