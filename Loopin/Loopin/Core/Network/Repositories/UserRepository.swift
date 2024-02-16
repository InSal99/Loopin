//
//  UserRepository.swift
//  Loopin
//
//  Created by Celine Margaretha on 26/12/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class UserRepository: ObservableObject {
    //MARK: Firebase API
    private let path: String = "users"
    private let store = Firestore.firestore()
    
    func registUserToDatabase(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        do {

//            _ = try database.collection(path).addDocument(from: user)
            _ = try store.collection(path).document(user.id ?? "No ID").setData(from: user)
            
            /// DEBUG
            print("UserRepo - registUserToDatabase success: \(user)")
            
            completion(.success(()))
        } catch {
            /// DEBUG
            print("UserRepo - registUserToDatabase error: \(error.localizedDescription)")
            
            completion(.failure(error))
        }
    }
    
    func getUserFromDatabase(userId: String, completion: @escaping (Result<User?, Error>) -> Void) {
        store.collection(path).document(userId).getDocument { document, error in
            if let error = error {
                /// DEBUG
                print("UserRepo - getUserFromDatabase error: \(error.localizedDescription)")
                
                completion(.failure(error))
                return
            }
            
            guard let document = document, document.exists else {
                /// DEBUG
                print("UserRepo - getUserFromDatabase error not found for userId: \(userId)")
                
                completion(.success(nil))
                return
            }
            
            do {
                let userData = try document.data(as: User.self)
                
                /// DEBUG
                print("UserRepo - getUserFromDatabase retrieved: \(userData)")
                
                completion(.success(userData))
            } catch {
                
                /// DEBUG
                print("UserRepo - getUserFromDatabase error decoding user data: \(error.localizedDescription)")
                
                completion(.failure(error))
            }
        }
    }
    
    
    
}


/*
 
 func getUserFromDatabase(userId: String, completion: @escaping (Result<User?, Error>) -> Void) {
     database.collection(path)
         .whereField("userId", isEqualTo: userId)
         .getDocuments { querySnapshot, error in
             if let error = error {
                 print("Error getting user data: \(error.localizedDescription)")
                 completion(.failure(error))
                 return
             }
             
             guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                 print("No user data found for userId: \(userId)")
                 completion(.success(nil))
                 return
             }
             
             /// Assuming you want data from the first matching document
             let firstDocument = documents[0]
             do {
                 let userData = try firstDocument.data(as: User.self)
                 /// Use userData as needed
                 print("User data retrieved:", userData )
                 completion(.success(userData))
             } catch {
                 print("Error decoding user data:", error.localizedDescription)
                 completion(.failure(error))
             }
         }
 }
 */

