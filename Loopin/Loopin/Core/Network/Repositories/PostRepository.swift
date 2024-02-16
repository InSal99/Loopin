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
        
        uploadImageToFirebase(image: imageDatas[0]) { result in
            switch result {
            case .success(let downloadURL):
//                print("Image uploaded successfully. Download URL: \(downloadURL.description)")
                var newPost = post
                newPost.images.append(downloadURL.description)
                self.add(newPost)
            case .failure(let error):
                print("Error uploading image: \(error.localizedDescription)")
            }
//        let imageRef = Storage.storage().reference().child(UUID().uuidString)
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
//
//                        _ = try? self.store.collection(self.path).addDocument(from: newPost)
//                    }
                }
    
    }
    
    // MARK: STILL NOT WORKING
    func deleteImageSource(filePath: String) {
        let storage = Storage.storage().reference()

        let fileRef = storage.child("\(filePath)")

        fileRef.delete { error in
            if let error = error {
                print("Error deleting file: \(error.localizedDescription)")
            } else {
                print("File deleted successfully.")
            }
        }
    }
    
    private func uploadImageToFirebase(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "YourAppDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to JPEG data"])))
            return
        }

        let storageRef = Storage.storage().reference().child("Images").child(UUID().uuidString + ".jpeg")

        // Assuming imageData is the binary data of your image
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url))
                    }
                }
               
            }
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
        
        for image in post.images {
            deleteImageSource(filePath: image)
        }
        
        store.collection(path).document(postId).delete { error in
            if let error = error {
                print("Unable to remove card: \(error.localizedDescription)")
            }
        }
    }
    
}

