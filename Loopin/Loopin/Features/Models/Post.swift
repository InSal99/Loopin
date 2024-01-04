//
//  Post.swift
//  Loopin
//
//  Created by Celine Margaretha on 01/12/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Post: Identifiable, Codable {
//    @DocumentID var id: String?
    @DocumentID var id: String?
    var userId: String
    var username: String
    var content: String
    var time: Date
    var totLikes: Int
    var totComments: Int
//    var commentsId: [Comment] = []
}


#if DEBUG
let testData = (1...10).map { i in
    Post(userId: "nZnXdEEl77XPKyMVL7Mf8dPVmd52", username: "Ok", content: "hay ini postinganku ke \(i)", time: Date(), totLikes: i+2, totComments: i+4)
}
#endif
