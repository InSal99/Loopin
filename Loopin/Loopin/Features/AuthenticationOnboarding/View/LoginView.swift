//
//  LoginView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var isToggleOn = false
    
    @State private var email = "cm@gmail.com"
    @State private var password = "cmcmcm"
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                ZStack (alignment: .center){
                    Rectangle()
                        .fill(Color("Peach"))
                        .ignoresSafeArea()
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: 750)
                        .offset(y: 100)
                        .foregroundColor(Color(.white))
                    VStack (spacing: 20) {
                        ShortTextField(placeholder: "email@address.com", field: $email)
                            .padding(.top, 150)
                        ShortTextField(placeholder: "password", field: $password)
                        Toggle("Masuk sebagai admin", isOn: $isToggleOn)
                            .padding(20)
                            .font(.outfit(.regular, size: .body3))
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        NavigationLink {
                            ContentViewAdmin()
                        } label: {
                            PrimaryButton(buttonText: "Masuk Admin")
                        }

                        PrimaryButton(buttonText: "Masuk")
                            .onTapGesture {
                                authViewModel.signIn(email: email, password: password, role: isToggleOn ? UserRole.admin : UserRole.user) { isSuccess in
                                    if isSuccess {
                                        print("Masuk - berhasil")
                                    } else {
                                        print("Masuk - gagal")
                                    }
                                    showAlert = true
                                }
                            }
                            .alert(isPresented: $showAlert) {
                                
                                /// Display an alert with the alert message from the ViewModel
                                Alert(title: Text(authViewModel.alertTitle ?? "Semua data perlu diisi."), message: Text(authViewModel.alertMessage ?? ""), dismissButton: .default(Text("OK")) {
                                    
                                    if authViewModel.errorMessage == nil {
                                        authViewModel.saveSignInState(role: isToggleOn ? UserRole.admin : UserRole.user)
                                    }
                                    showAlert = false
                                })
                            }
                            .padding(.bottom, -80)
                    }
                }
            }
            .ignoresSafeArea()
        }
        .navigationTitle("Masuk")
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
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
        .onDisappear {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationViewModel())
    }
}
