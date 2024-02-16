//
//  CommentListViewModel.swift
//  Loopin
//
//  Created by Celine Margaretha on 06/01/24.
//

import Foundation
import Combine

class CommentListViewModel: ObservableObject {
    
    @Published var commentRepository : CommentRepository?
    @Published var commentViewModels : [CommentViewModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(postId: String) {
        
        if  commentRepository == nil {
            commentRepository = CommentRepository(postId: postId)
        }
        
        commentRepository!.$comments
            .map { comments in
                comments.map { CommentViewModel(comment: $0, commentRepository: self.commentRepository!) }
            }
            .assign(to: \.commentViewModels, on: self)
            .store(in: &cancellables)
        
    }
    
    func add(_ comment: Comment) {
        commentRepository!.add(comment)
    }
    //    func update(_ post: Post) {
    //        postRepository.update(post)
    //    }
    
    func deleteAll() {
        commentRepository?.removeCollection()
    }
}
