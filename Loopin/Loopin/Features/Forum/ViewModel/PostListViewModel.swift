//
//  PostListViewModel.swift
//  Loopin
//
//  Created by Celine Margaretha on 29/12/23.
//

import Combine
import Foundation
import UIKit

class PostListViewModel: ObservableObject {

    static let shared = PostListViewModel()

    @Published var postRepository = PostRepository.shared
    @Published var postViewModels : [PostViewModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        postRepository.$posts.map { posts in
            posts.map(PostViewModel.init)
        }
        .assign(to: \.postViewModels, on: self)
        .store(in: &cancellables)
    }
    func add(_ post: Post) {
        postRepository.add(post)
    }
    
    func add(_ post: Post, withImages imageDatas: [UIImage]) {
           postRepository.add(post, withImages: imageDatas)
    }
    
    func reset() {
        for postViewModel in postViewModels {
            postViewModel.reset()
        }
        postViewModels.removeAll()
    }
}
