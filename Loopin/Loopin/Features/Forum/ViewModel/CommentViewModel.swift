//
//  CommentViewModel.swift
//  Loopin
//
//  Created by Celine Margaretha on 06/01/24.
//

import Foundation
import Combine

class CommentViewModel: ObservableObject, Hashable, Identifiable {
    
    static func == (lhs: CommentViewModel, rhs: CommentViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private weak var commentRepository : CommentRepository?
    private weak var authService = AuthenticationService.shared

    @Published var comment: Comment
    
    private var cancellables: Set<AnyCancellable> = []
    
    var id = ""
    var isAllowedToEdit = false

    init(comment:Comment, commentRepository: CommentRepository) {
//        print(comment)
        self.comment = comment
        self.commentRepository = commentRepository
        
        $comment
            .compactMap{$0.id}
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        if authService?.user?.id == comment.userId {
            isAllowedToEdit = true
        }
        
        // DEBUG
//        withUnsafePointer(to: &self.commentRepository) { pointer in
//            print("Comment VM untuk post id \(commentRepository.postId) with address \(pointer)")
//
//        }
    }
    
//    func update(comment: Comment) {
//        DispatchQueue.main.async {
//            self.commentRepository?.update(comment)
//        }
//    }
    
    func remove() {
        DispatchQueue.main.async {
            self.commentRepository?.remove(self.comment)
        }
    }
    
}
