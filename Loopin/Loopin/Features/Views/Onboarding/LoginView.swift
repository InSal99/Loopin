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
    
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .center){
                Rectangle()
                    .fill(Color("Peach"))
                    .ignoresSafeArea()
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: 750)
                    .offset(y: 40)
                    .foregroundColor(Color(.white))
                VStack (spacing: 20) {
                    ShortTextField(placeholder: "email@address.com", field: $email)
                        .padding(.top, 90)
                    ShortTextField(placeholder: "password", field: $password)
                    Spacer()
                    
                    PrimaryButton(buttonText: "Masuk")
                        .onTapGesture {
                            authViewModel.signIn(email: email, password: password) { isSuccess in
                                if isSuccess {
                                    print("Masuk - berhasil")
                                } else {
                                    print("Masuk - gagal")
                                }
                                showAlert = true
                            }
                        }
                        .alert(isPresented: $showAlert) {
                            // Display an alert with the alert message from the ViewModel
                            Alert(title: Text(authViewModel.alertTitle ?? "Gagal memssuki akun"), message: Text(authViewModel.alertMessage ?? ""), dismissButton: .default(Text("OK")) {
                                authViewModel.isSigninSuccess = true
                            })
                        }
                }
            }
            .navigationDestination(isPresented: $authViewModel.isSigninSuccess) {
                ContentView()
                
            }
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
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationViewModel())
    }
}
