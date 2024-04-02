//
//  AuthenticationViewModel.swift
//  Loopin
//
//  Created by Celine Margaretha on 25/12/23.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    
    static let shared = AuthenticationViewModel()

    @Published var isSignedUp : Bool = false
    @Published var isSignedIn : Bool {
        didSet {
            UserDefaults.standard.set(isSignedIn, forKey: "\(UserDefaultKeys.login.rawValue)")
        }
    }
    @Published var role : UserRole {
        didSet {
            UserDefaults.standard.set(role, forKey: "\(UserDefaultKeys.role.rawValue)")
            self.authService.role = role
        }
    }
    
    @Published var isError: Bool = false
    @Published var errorMessage: String? = nil
    @Published var alertTitle: String? = nil
    @Published var alertMessage: String? = nil
    
    let authService: AuthenticationService
    
    init(authService: AuthenticationService = AuthenticationService.shared) {
        self.authService = authService
        self.isSignedIn = UserDefaults.standard.bool(forKey: "\(UserDefaultKeys.login.rawValue)")
        
        if let savedRoleString = UserDefaults.standard.string(forKey: "\(UserDefaultKeys.role.rawValue)"),
               let savedRole = UserRole(rawValue: savedRoleString) {
                self.role = savedRole
            } else {
                /// Provide a default role if the stored value doesn't exist or couldn't be converted to UserRole
                self.role = .user
            }
    }
    
    func signUp(username: String, email: String, password: String, confirmPassword: String? = nil, completion: @escaping (Bool) -> Void) {
        self.isError = false
        validateInputs(username: username, email: email, password: password, confirmPassword: confirmPassword) { [weak self] isValid in
            if isValid {
                self?.authService.signUp(username: username, email: email, password: password) { result in
                    switch result {
                    case .success:
                        self?.alertTitle = "Berhasil mendaftarkan akun"
                        self?.alertMessage = "Data disimpan."
                        self?.errorMessage = nil
                        
                        /// DEBUG
                        print("AuthVM - sign up success: \(self?.isSignedUp ?? false)")
                        
                        completion(true)
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.isError = true
                        self?.alertTitle = "Gagal mendaftarkan akun"
                        self?.alertMessage = "Data gagal disimpan. Coba gunakan akun lain"

                        /// DEBUG
                        print("AuthVM - sign up failed: \(self?.errorMessage ?? "error message nil")")

                        completion(false)
                    }
                }
            } else {
                completion(false)
            }
        }
    }
    
    
    func signIn(email: String, password: String, role: UserRole, completion: @escaping (Bool) -> Void) {
        self.isError = false
        validateInputs(email: email, password: password) { [weak self] isValid in
            if isValid {
                self?.authService.signIn(email: email, password: password, role: role) { result in
                                        
                    switch result {
                    case .success:
                        self?.alertTitle = "Berhasil masuk akun"
                        self?.alertMessage = "Data ditemukan."
                        self?.errorMessage = nil

                        /// DEBUG
                        print("AuthVM - sign in success: \(true)")
                        
                        completion(true)
                    case .failure(let error):
                        self?.isError = true
                        self?.alertTitle = "Gagal masuk akun"
                        self?.alertMessage = "Akun tidak ditemukan."
                        self?.errorMessage = error.localizedDescription

                        /// DEBUG
                        print("AuthVM - sign in failed: \(self?.errorMessage ?? "error message nil")")
                        
                        completion(false)
                    }
                }
            } else {
                completion(false)
            }
        }
    }
    
    func signOut(completion: @escaping (Bool)-> Void) {
        isSignedUp = false
        errorMessage  = nil
        isError = false
        alertTitle = nil
        alertMessage = nil
        
        PostListViewModel.shared.reset()
        ProjectListViewModel.shared.reset()
        
        authService.signOut() { isSuccess in
            completion(isSuccess)
        }
    }
    func update(newUsername: String, completion: @escaping (Bool)-> Void) {
        guard authService.user?.username != nil else {
            return
        }
        authService.user?.username = newUsername
        authService.userInJSON?.username = newUsername
        UserRepository.shared.update(authService.user!, role) { isSuccess in
            if isSuccess {
                self.saveSignInState(role: self.role)
                PostListViewModel.shared.updateUsername(newUsername: newUsername)
                completion(true)
            }
            else {
                completion(false)
            }
            
        }
    }
    
    private func validateInputs(username: String? = nil, email: String, password: String, confirmPassword: String? = nil, completion: @escaping (Bool) -> Void) {
        self.isError = false
        self.alertMessage = nil
        
        var isValid = false
        if username != nil && username!.isEmpty {
            self.alertMessage = "Username perlu diisi."
        } else if email.isEmpty {
            self.alertMessage = "Email perlu diisi."
        } else if password.isEmpty || password.count < 3 {
            self.alertMessage = "Password perlu diisi."
        } else if password.count < 6 {
            self.alertMessage = "Password minimal 6 karakter."
        } else if confirmPassword != nil && confirmPassword!.isEmpty {
            self.alertMessage = "Konfirmasi password anda."
        }else if confirmPassword != nil && confirmPassword != password {
            self.alertMessage = "Konfirmasi password harus sama dengan password"
        } else {
            isValid = true
        }
        
        if !isValid {
            self.isError = true
            self.errorMessage = "Semua data perlu diisi."
        }
        
        completion(isValid)
    }
    
}

// MARK: Set user defaults
extension AuthenticationViewModel {
    
    func saveSignOutState(){
        self.isSignedIn = false
        AppManager.shared.reset()
        UserDefaults.standard.removeObject(forKey: UserDefaultKeys.user.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultKeys.role.rawValue)
    }
    
    func saveSignInState(role: UserRole){
        if let encodedData = try? JSONEncoder().encode(AuthenticationService.shared.userInJSON),
           let userDictionary = try? JSONSerialization.jsonObject(with: encodedData, options: []) as? [String: Any] {
            self.isSignedIn = true
            UserDefaults.standard.set(userDictionary, forKey: UserDefaultKeys.user.rawValue)
            UserDefaults.standard.set(role.rawValue, forKey: UserDefaultKeys.role.rawValue)
        }
    }
    
}
