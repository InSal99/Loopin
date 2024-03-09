//
//  ImageRepository.swift
//  Loopin
//
//  Created by Celine Margaretha on 08/03/24.
//

import FirebaseStorage
import UIKit

class ImageRepository: ObservableObject {
    static let shared = ImageRepository()

    private let storage = Storage.storage()
    
    
    
    func getDownloadUrl(imagePath: String, inFolder storageFolderPath:String, completion: @escaping (String) -> Void){
        
        let storageRef = storage.reference(withPath: storageFolderPath).child(imagePath)
        
        storageRef.downloadURL { (url, error) in
            if let error = error {
                print("\nError getting download URL: \(error.localizedDescription)")
                completion("")
            } else {
                if let url = url {
                    completion("\(url)")
                }
            }
        }
    }
    
    func uploadImageToFirebase(image: UIImage, inFolder storageFolderPath:String, completion: @escaping (Result<String, Error>) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "YourAppDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to JPEG data"])))
            return
        }
        
        /// set image uid path
        let imagePath = "\(UUID().uuidString).jpeg"
        let storageRef = storage.reference(withPath: storageFolderPath).child(imagePath)

        /// Assuming imageData is the binary data of your image
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        /// Add data
        storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if url != nil {
                        completion(.success(imagePath))
                    }
                }
            }
        }
    }
    
    func deleteImages(imagePaths: [String], inFolder storageFolderPath:String, completion: @escaping (Bool) -> Void) {
        for filePath in imagePaths {
            let storageRef = storage.reference(withPath: storageFolderPath).child("\(filePath)")
            storageRef.delete { error in
                if let error = error {
                    print("Error deleting file: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("File deleted successfully.")
                }
            }
        }
        completion(true)
    }
    
}
