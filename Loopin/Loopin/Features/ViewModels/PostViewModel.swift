//
//  PostViewModel.swift
//  Loopin
//
//  Created by Celine Margaretha on 29/12/23.
//

import Foundation
import Combine

class PostViewModel: ObservableObject, Identifiable {
    private let postRepository = PostRepository.shared
    private let authService = AuthenticationService.shared

    @Published var post: Post
    
    private var cancellables: Set<AnyCancellable> = []
    
    var id = ""
    var isAllowedToEdit = false
    var isLiked = false
    
    var commentListViewModel : CommentListViewModel?
    
    init(post:Post) {
        self.post = post
        $post
            .compactMap{$0.id}
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        if authService.user?.id == post.userId {
            isAllowedToEdit = true
        }

        self.isLiked = post.likes.contains(authService.user?.id ?? "")
        
        if self.commentListViewModel == nil {
            self.commentListViewModel = CommentListViewModel(postId: id)
        }
    }
    
    func updatePostLike() {
        self.isLiked.toggle()
        
        guard let userId = authService.user!.id else { return }
        
        if isLiked {
            post.likes.append(userId)
        } else {
            post.likes = post.likes.filter({ $0 != userId})
        }

        post.totLikes = post.likes.count
        postRepository.update(post)

    }
    func update(post:Post) {
        postRepository.update(post)
    }
    func remove() {
        postRepository.remove(post)
        commentListViewModel?.commentRepository?.removeCollection()
    }
    
}
