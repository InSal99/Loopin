//
//  Comment.swift
//  Loopin
//
//  Created by Celine Margaretha on 01/12/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Comment: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var time: Date
    var username: String
    var content: String
}

#if DEBUG
let testComment = (1...10).map { i in
    Comment(id: "gulPqq4J35ZTfB1RrQep", userId: "", time: Date.now, username: "test\(i)", content: "comment dummy \(i)")
   
}
#endif
