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
    @Published var post: Post
    
    private var cancellables: Set<AnyCancellable> = []
    
    var id = ""
    var isAllowedToEdit = true
    
    init(post:Post) {
        self.post = post

        $post
            .compactMap{$0.id}
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        if AuthenticationService.shared.user?.id == post.userId {
            isAllowedToEdit = true
        }
        
    }
    
    func update(post:Post) {
        postRepository.update(post)
    }
    func remove() {
        postRepository.remove(post)
    }
    
}
