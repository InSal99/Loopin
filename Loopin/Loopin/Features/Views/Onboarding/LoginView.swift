//
//  LoginView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var email = ""
    @State private var password = ""
    
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
                        }
                    }
            }
        }
        .navigationTitle("Masuk")
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $authViewModel.isSigninSuccess) {ContentView()}
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
