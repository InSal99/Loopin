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
    
    var postId : String
    
    private let parentPath: String = "posts"
    private let path: String = "comments"
    private let store = Firestore.firestore()
    
    private weak var authenticationService = AuthenticationService.shared
    private var cancellables: Set<AnyCancellable> = []
    private var listener: ListenerRegistration?

    //MARK: Card View
    @Published var comments: [Comment] = []
    
    init(postId: String){
        self.postId = postId
        self.addListeners(postId)
    }
    
    private func addListeners(_ postId: String) {
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
        
        listener = store.collection(parentPath).document(postId).collection(path)
            .order(by: "time", descending: false)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting cards: \(error.localizedDescription)")
                    return
                }
                
                self.comments = querySnapshot?.documents.compactMap { document in
                    do {
                        /// Try to map the Firestore document data to Comment model
                        let comment = try document.data(as: Comment.self)
                        return comment
                    } catch {
                        print("Error mapping Comment for document \(document.documentID): \(error.localizedDescription)")
                        return nil
                    }
                } ?? []
                
            }
    }
    
    func add(_ comment: Comment, completion: @escaping (Bool) -> Void) {
        do {
            _ = try store.collection(parentPath).document(postId).collection(path).addDocument(from: comment)
            completion(true)
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription).")
        }

    }
    
//    func update(_ comment: Comment) {
//        guard let commentId = comment.id else { return }
//        
//        do {
//            try           store.collection(parentPath).document(postId).collection(path).document(commentId).setData(from: comment)
//        } catch {
//            fatalError("Unable to update card: \(error.localizedDescription).")
//        }
//    }
    
    func remove(_ comment: Comment) {
        guard let commentId = comment.id else { return }
        
        store.collection(parentPath).document(postId).collection(path).document(commentId).delete { error in
            if let error = error {
                print("Unable to remove card: \(error.localizedDescription)")
            }
        }
    }
    
    func removeCollection() {
        let collectionRef = store.collection(parentPath).document(postId).collection(path)
        
        /// Delete all documents in the collection
        collectionRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
                return
            }
            
            for document in querySnapshot!.documents {
                document.reference.delete()
            }
        }
    }
    
}

