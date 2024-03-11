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
    @Published var commentTextInput : String = ""
    
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
    
    func add(_ comment: Comment, completion: @escaping (Bool) -> Void) {
        commentRepository!.add(comment) { isSuccess in
            completion(isSuccess)
            self.objectWillChange.send()
            self.commentTextInput = ""
        }
    }
    //    func update(_ post: Post) {
    //        postRepository.update(post)
    //    }
    
    func deleteAll() {
        commentRepository?.removeCollection()
    }
    
    func reset() {
//        commentRepository?.reset()
        commentRepository = nil
        commentViewModels.removeAll()
        commentTextInput = ""
    }
}
