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

    @Published var postRepository = PostRepository.shared
    @Published var postViewModels : [PostViewModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {

//        for post in testData {
//            postViewModels.append(PostViewModel(post: post))
//        }
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
//    func update(_ post: Post) {
//        postRepository.update(post)
//        postRepository.objectWillChange.send()
//    }
}
