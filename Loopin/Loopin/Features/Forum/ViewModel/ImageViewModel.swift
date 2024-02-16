//
//  ImageViewModel.swift
//  Loopin
//
//  Created by Celine Margaretha on 12/01/24.
//

import SwiftUI
import Firebase
import FirebaseStorage

class ImageViewModel: ObservableObject {
    @Published var selectedImage: UIImage?

//    func uploadImage(completion: @escaping (Result<String, Error>) -> Void) {
//        guard let imageData = selectedImage?.jpegData(compressionQuality: 0.5) else {
//            completion(.failure(NSError(domain: "Invalid image data", code: 0, userInfo: nil)))
//            return
//        }
//
//        let storageRef = Storage.storage().reference().child("images").child(UUID().uuidString)
//
//        storageRef.putData(imageData, metadata: nil) { (_, error) in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                storageRef.downloadURL { (url, error) in
//                    if let error = error {
//                        completion(.failure(error))
//                    } else if let downloadURL = url {
//                        completion(.success(downloadURL.absoluteString))
//                    }
//                }
//            }
//        }
//    }
}
