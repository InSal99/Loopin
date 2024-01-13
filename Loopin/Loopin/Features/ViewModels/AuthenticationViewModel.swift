//
//  AuthenticationViewModel.swift
//  Loopin
//
//  Created by Celine Margaretha on 25/12/23.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    
    static let shared = AuthenticationViewModel()

    @Published var isSignupSuccess: Bool = false
    @Published var isSigninSuccess: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isError: Bool = false
    @Published var alertTitle: String? = nil
    @Published var alertMessage: String? = nil
    
    let authService: AuthenticationService
    
    init(authService: AuthenticationService = AuthenticationService.shared) {
        self.authService = authService
    }
    
    func signUp(username: String, email: String, phone: String, password: String, confirmPassword: String? = nil, completion: @escaping (Bool) -> Void) {
        self.isError = false
        validateInputs(username: username, email: email, phone: phone, password: password, confirmPassword: confirmPassword) { [weak self] isValid in
            if isValid {
                self?.authService.signUp(username: username, email: email, phone: phone, password: password) { result in
                    switch result {
                    case .success:
                        self?.isSignupSuccess = true
                        
                        /// DEBUG
                        print("AuthVM - sign up success: \(self?.isSignupSuccess ?? false)")
                        
                        completion(true)
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.isError = true
                        
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
    
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        self.isError = false
        validateInputs(email: email, password: password) { [weak self] isValid in
            if isValid {
                self?.authService.signIn(email: email, password: password) { result in
                                        
                    switch result {
                    case .success:
                        self?.isSigninSuccess = true
                        self?.alertTitle = "Berhasil masuk akun"
                        self?.alertMessage = "Data ditemukan."
                        
                        /// DEBUG
                        print("AuthVM - sign in success: \(self?.isSigninSuccess ?? false)")
                        
                        completion(true)
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.isError = true
                        self?.alertMessage = "Email atau password salah."
                        
                        /// DEBUG
                        print("AuthVM - sign in failed: \(self?.errorMessage ?? "error message nil")")
                        
                        completion(false)
                    }
                }
            } else {
                self?.alertMessage = "Email dan password harus diisi."
                completion(false)
            }
        }
    }
    
   
    
    
    private func validateInputs(username: String? = nil, email: String, phone: String? = nil, password: String, confirmPassword: String? = nil, completion: @escaping (Bool) -> Void) {
        self.isError = false
        self.alertMessage = nil
        
        var isValid = false
        if username != nil && username!.isEmpty {
            isValid = false
            self.alertMessage = "Username perlu diisi."
        } else if email.isEmpty {
            isValid = false
            self.alertMessage = "Email perlu diisi."
        } else if phone != nil && phone!.isEmpty {
            isValid = false
            self.alertMessage = "Nomor telepon perlu diisi."
        } else if password.isEmpty {
            isValid = false
            self.alertMessage = "Password perlu diisi"
        } else if confirmPassword != nil && confirmPassword!.isEmpty {
            isValid = false
            self.alertMessage = "Konfirmasi password anda."
        } else {
            isValid = true
        }
        
        if !isValid {
            self.isError = true
            self.errorMessage = "Please fill in all the fields."
        }
        
        completion(isValid)
    }
    
}
