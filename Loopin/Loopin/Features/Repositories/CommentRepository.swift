//
//  CommentRepository.swift
//  Loopin
//
//  Created by Celine Margaretha on 13/12/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class CommentRepository: ObservableObject {
    static let shared = CommentRepository()

    private let path: String = "posts"
    private let store = Firestore.firestore()
    
    private let authenticationService = AuthenticationService.shared
    private var cancellables: Set<AnyCancellable> = []

    //MARK: Card View
    @Published var posts: [Post] = []
    
    init(){
        authenticationService.$user
          .receive(on: DispatchQueue.main)
          .sink { [weak self] _ in
            self?.get()
          }
          .store(in: &cancellables)
    }
    
    func get() {
      store.collection(path)
//        .whereField("userId", isEqualTo: userId)
            .order(by: "time", descending: true)
        .addSnapshotListener { querySnapshot, error in
          if let error = error {
            print("Error getting cards: \(error.localizedDescription)")
            return
          }

          self.posts = querySnapshot?.documents.compactMap { document in
            try? document.data(as: Post.self)
          } ?? []
        }
    }
    
}

