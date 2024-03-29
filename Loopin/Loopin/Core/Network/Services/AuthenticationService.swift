//
//  AuthenticationService.swift
//  Loopin
//
//  Created by Celine Margaretha on 13/12/23.
//

import Foundation
import Firebase
import FirebaseAuth
import Combine

class AuthenticationService: ObservableObject {
    static let shared = AuthenticationService()

    /// Current user that successfully signed in
    @Published var user: User?
    @Published var userInJSON: UserJSON?
    @Published var role: UserRole = .user
    
    private var authenticationStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        addListeners()
    }
    
    func signUp(username: String, email: String, phone: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                
                /// DEBUG
                print("AuthService - sign up error: \(error.localizedDescription)")
                
                completion(.failure(error))
                return
            }
            
            guard let userId = authResult?.user.uid else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "User ID not available"])
                
                /// DEBUG
                print("AuthService - sign up error setting userId: \(error.localizedDescription)")
                
                completion(.failure(error))
                return
            }
            
            let newUser = User(id: userId, username: username, email: email, phone: phone)
            UserRepository.shared.registUserToDatabase(user: newUser) { result in
                switch result {
                case .success:
                    /// DEBUG
                    print("AuthService - sign up success")
                    
                    completion(.success(()))
                    
                case .failure(let error):
                    
                    /// DEBUG
                    print("AuthService - sign up error saving user into DB: \(error.localizedDescription)")
                    
                    completion(.failure(error))
                }
            }
        }
    }
    
    func signIn(email: String, password: String, role: UserRole, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error != nil {
                /// DEBUG
                print("AuthService - sign in error: \(String(describing: error?.localizedDescription))")
                completion(.failure(error!))
                return
            }
            
            guard let userId = authResult?.user.uid else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "User ID not available"])

                /// DEBUG
                print("AuthService - sign in error setting userId: \(error.localizedDescription)")
                completion(.failure(error))

                return
            }
            
            /// Fetch additional user information from your database
            UserRepository.shared.getUserFromDatabase(userId: userId, role: role) { [weak self] result in
                switch result {
                case .success(let user):
                    if let user = user {
                        self!.user = User(id: userId, username: user.username, email: user.email, phone: user.phone)
                        self!.userInJSON = UserJSON(id: userId, username: user.username, email: user.email, phone: user.phone ?? "")
                        self!.role = role
                        
                        /// DEBUG
                        print("AuthService - sign in success with user data: \(String(describing: self?.user))")
                       
                        completion(.success(()))
                    } else {
                        /// DEBUG
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "sign in success but no user data found"])
                            
                        print("AuthService - sign in success but no user data found: \(String(describing: self?.user))")
                        
                        completion(.failure(error))

                        
                    }
                case .failure(let error):
                    /// DEBUG
                    print("AuthService - sign in error fetching user data from database: \(error.localizedDescription)")

                    completion(.failure(error))

                }
            }
            
        }
    }
    
    
    func signOut(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.userInJSON = nil
            self.role = .user
            completion(true)
        } catch {
            print("AuthService - sign up error: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    private func addListeners() {
        if let handle = authenticationStateHandler {
            Auth.auth().removeStateDidChangeListener(handle)
        }
        authenticationStateHandler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            /// Only update user property when signing in
            if let user = user, self?.user == nil, self?.userInJSON == nil {
                self?.user = User(id: user.uid, email: user.email!)
                
                // When retrieving user defaults
                if let storedData = UserDefaults.standard.value(forKey: "user") as? [String: Any],
                   let encodedData = try? JSONSerialization.data(withJSONObject: storedData),
                   let decodedUser = try? JSONDecoder().decode(UserJSON.self, from: encodedData) {
                    self?.userInJSON = decodedUser
                    
                    self?.user?.id = self?.userInJSON?.id
                    self?.user?.username = self?.userInJSON?.username ?? "-"
                    self?.user?.email = self?.userInJSON?.email ?? "-"
                    self?.user?.phone = self?.userInJSON?.phone ?? "-"
                    self?.user?.postId = self?.userInJSON?.postId ?? []
                    self?.user?.projectId = self?.userInJSON?.projectId
                    
//                    if let savedRole = UserDefaults.standard.string(forKey: UserDefaultKeys.role.rawValue) {
//                        self?.role = UserRole(rawValue: savedRole)
//                    } else {
//                        print("No string data found for key 'role'")
//                    }
                }
            }
            
           
            /// DEBUG
            print("AuthService - addListeners: \(String(describing: self?.user))")

        }
    }

}
