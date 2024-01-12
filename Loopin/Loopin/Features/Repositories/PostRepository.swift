//
//  PostRepository.swift
//  Loopin
//
//  Created by Celine Margaretha on 13/12/23.
//

//import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
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
    
    func add(_ post: Post, withImages imageDatas: [UIImage]) {
        // Upload images to Firebase Storage
           uploadImages(imageDatas) { imagePaths in
               // Once images are uploaded, add post to Firestore with image paths
               var newPost = post
               newPost.images = imagePaths
//               newPost.time = Date()
               
               self.add(newPost)
           }
        
//        let imageRef = Storage.storage().reference().child("images").child(UUID().uuidString)
//
//                _ = imageRef.putData(imageDatas[0], metadata: nil) { _, error in
//                    if let error = error {
//                        print("Error uploading image to storage: \(error.localizedDescription)")
//                        return
//                    }
//
//                    imageRef.downloadURL { url, error in
//                        if let error = error {
//                            print("Error getting download URL: \(error.localizedDescription)")
//                            return
//                        }
//
//                        var newPost = post
//                        newPost.images.append(imageRef.fullPath)
//                        newPost.time = Date()
//
//                        _ = try? self.store.collection(self.path).addDocument(from: newPost)
//                    }
//                }
    
    }
    
    private func uploadImages(_ images: [UIImage], completion: @escaping ([String]) -> Void) {
        var uploadedImagePaths: [String] = []

        let group = DispatchGroup()

        for image in images {
            group.enter()

            // Convert UIImage to Data (JPEG representation)
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                let imageRef = Storage.storage().reference().child("images").child(UUID().uuidString)

                _ = imageRef.putData(imageData, metadata: nil) { _, error in
                    defer {
                        group.leave()
                    }

                    if let error = error {
                        print("Error uploading image to storage: \(error.localizedDescription)")
                        return
                    }

                    imageRef.downloadURL { url, error in
                        if let error = error {
                            print("Error getting download URL: \(error.localizedDescription)")
                            return
                        }

                        if let downloadURL = url {
                            uploadedImagePaths.append(downloadURL.absoluteString)
                        }
                    }
                }
            } else {
                // Handle conversion failure if needed
                group.leave()
            }
        }

        group.notify(queue: .main) {
            completion(uploadedImagePaths)
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

