//
//  PostViewModel.swift
//  Loopin
//
//  Created by Celine Margaretha on 29/12/23.
//

import Foundation
import Combine
import SwiftUI

class PostViewModel: ObservableObject, Identifiable {
    private weak var postRepository = PostRepository.shared
    private weak var authService = AuthenticationService.shared

    @Published var post: Post
    
    private var cancellables: Set<AnyCancellable> = []
    
    var id = ""
    var isAllowedToEdit = false
    var isLiked = false
    
    @Published var commentListViewModel : CommentListViewModel?
    var presentationMode: Binding<PresentationMode>?

    init(post:Post) {
        self.post = post
        $post
            .compactMap{$0.id}
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        
        
        if authService?.user?.id == post.userId {
            isAllowedToEdit = true
        }

        self.isLiked = post.likes.contains(authService?.user?.id ?? "")
        
//        $post
//            .map { $0.likes.contains(self.authService?.user?.id ?? "") }
//            .assign(to: \.isLiked, on: self)
//            .store(in: &cancellables)
        
        if self.commentListViewModel == nil {
            self.commentListViewModel = CommentListViewModel(postId: id)
        }
    }
    
    func updatePostLike() {
        self.isLiked.toggle()
        
        guard let userId = authService?.user!.id else { return }
        
        if isLiked {
            post.likes.append(userId)
        } else {
            post.likes = post.likes.filter({ $0 != userId})
        }

        post.totLikes = post.likes.count
        postRepository?.update(post)

    }
    func update(post:Post) {
        self.post.content = post.content
        postRepository?.update(post)
    }
    func remove() {
        postRepository?.remove(post)
        commentListViewModel?.commentRepository?.removeCollection()
        presentationMode?.wrappedValue.dismiss()
    }
    
    
}
