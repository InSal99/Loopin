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
//                        self?.isSignupSuccess = true
                        self?.alertTitle = "Berhasil mendaftarkan akun"
                        self?.alertMessage = "Data disimpan."
                        self?.errorMessage = nil
                        
                        /// DEBUG
                        print("AuthVM - sign up success: \(self?.isSignupSuccess ?? false)")
                        
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
    
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        self.isError = false
        validateInputs(email: email, password: password) { [weak self] isValid in
            if isValid {
                self?.authService.signIn(email: email, password: password) { result in
                                        
                    switch result {
                    case .success:
//                        self?.isSigninSuccess = true
                        self?.alertTitle = "Berhasil masuk akun"
                        self?.alertMessage = "Data ditemukan."
                        self?.errorMessage = nil

                        /// DEBUG
                        print("AuthVM - sign in success: \(self?.isSigninSuccess ?? false)")
                        
                        completion(true)
                    case .failure(let error):
                        self?.isError = true
                        self?.alertTitle = "Gagal masuk akun"
                        self?.alertMessage = "Email atau password salah."
                        self?.errorMessage = error.localizedDescription

                        /// DEBUG
                        print("AuthVM - sign in failed: \(self?.errorMessage ?? "error message nil")")
                        
                        completion(false)
                    }
                }
            } else {
//                self?.alertTitle = "Gagal masuk akun"
//                self?.alertMessage = "Email atau password salah."
//                self?.errorMessage = " "
                
//                self?.alertMessage = "Email dan password kurang tepat"
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
        } else if password.isEmpty || password.count < 3 {
            isValid = false
            self.alertMessage = "Password perlu diisi."
        } else if password.count < 6 {
            isValid = false
            self.alertMessage = "Password minimal 6 karakter."
        } else if confirmPassword != nil && confirmPassword!.isEmpty {
            isValid = false
            self.alertMessage = "Konfirmasi password anda."
        }else if confirmPassword != nil && confirmPassword != password {
            isValid = false
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
