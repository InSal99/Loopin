//
//  PostRepository.swift
//  Loopin
//
//  Created by Celine Margaretha on 13/12/23.
//

//import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class PostRepository: ObservableObject {
    static let shared = PostRepository()

    private let path: String = "posts"
    private let store = Firestore.firestore()
    
    private weak var authenticationService = AuthenticationService.shared
    private var cancellables: Set<AnyCancellable> = []
    private var listener: ListenerRegistration?

    //MARK: Card View
    @Published var posts: [Post] = []
    
    init(){
       addListeners()
    }
    
    private func addListeners() {
        /// Remove existing listener if any
        listener?.remove()
        
        authenticationService?.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.get()
            }
            .store(in: &cancellables)
    }
    
    
    func get() {
        listener = store.collection(path)
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
    
    func add(_ post: Post) {
        do {
            _ = try store.collection(path).addDocument(from: post)
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription).")
        }
    }
    
    func update(_ post: Post) {
      guard let postId = post.id else { return }

      do {
        try store.collection(path).document(postId).setData(from: post)
      } catch {
        fatalError("Unable to update card: \(error.localizedDescription).")
      }
    }
    
    func remove(_ post: Post) {
        guard let postId = post.id else { return }

        store.collection(path).document(postId).delete { error in
          if let error = error {
            print("Unable to remove card: \(error.localizedDescription)")
          }
        }
    }
    
}

