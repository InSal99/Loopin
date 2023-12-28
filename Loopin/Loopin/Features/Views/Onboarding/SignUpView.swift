//
//  SignInView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel

    var body: some View {
        ZStack (alignment: .center){
            Rectangle()
                .fill(Color("Peach"))
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 30)
                .frame(height: 750)
                .offset(y: 40)
                .foregroundColor(Color(.white))
            VStack (spacing: 20) {
                ShortTextField(placeholder: "username", field: $username)
                    .padding(.top, 90)
                ShortTextField(placeholder: "email@address.com", field: $email)
                ShortTextField(placeholder: "phone", field: $phone)
                ShortTextField(placeholder: "password", field: $password)
                ShortTextField(placeholder: "confirm password", field: $confirmPassword)
                Spacer()
                
                PrimaryButton(buttonText: "Daftar")
                    .onTapGesture {
                        authViewModel.signUp(username: username, email: email, phone: phone, password: password, confirmPassword: confirmPassword) { isSuccess in
                            if isSuccess {
                                print("Daftar - berhasil")
                            } else {
                                print("Daftar - gagal")
                            }
                        }
                    }
                
                
            }
        }
        .navigationTitle("Daftar")
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $authViewModel.isSignupSuccess) {
            LoginView()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthenticationViewModel())
    }
}