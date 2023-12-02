//
//  Post.swift
//  Loopin
//
//  Created by Celine Margaretha on 01/12/23.
//

import Foundation
struct Post {
    var id: String
    var name: String
    var desc: String
    var likes: Int
    var commentsId: [Comment] = []
}

