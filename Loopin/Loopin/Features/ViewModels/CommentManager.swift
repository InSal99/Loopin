//
//  CommentManager.swift
//  Loopin
//
//  Created by Celine Margaretha on 07/01/24.
//

import Foundation

class CommentManager {
    private var commentRepositories: [String: CommentRepository] = [:]

    func getCommentRepository(for postId: String) -> CommentRepository {
        if let repository = commentRepositories[postId] {
            return repository
        } else {
            let newRepository = CommentRepository(postId: postId)
            commentRepositories[postId] = newRepository
            return newRepository
        }
    }
}
