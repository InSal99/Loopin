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
    //    var id: ObjectIdentifier
    
    @DocumentID var id: String?
    
//    var id: String
    var username: String = ""
    var email: String
    var phone: String = ""
    
    var projectId : [String]?
    var postId: [String]?
    
//    init(username: String, email: String, phone: String) {
//           self.username = username
//           self.email = email
//           self.phone = phone
//       }
    
//    init(id: String, username: String, email: String, phone: String) {
//        self.id = id
//        self.username = username
//        self.email = email
//        self.phone = phone
//    }
//    init(id: String, email: String) {
//        self.id = id
//        self.email = email
//    }
    
    
//    init(firebaseUser: Firebase.User) {
//        self.id = firebaseUser.uid
//        self.username = "" // Set appropriate value
//        self.email = firebaseUser.email ?? ""
//        self.phone = "" // Set appropriate value
//    }
}

/*
 struct User {
 var id: String
 var name: String
 var email: String
 var phone: String
 
 var projectId : [String] = []
 var postId: [String] = []
 }
 
 */
