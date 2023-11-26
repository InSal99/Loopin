//
//  LoginView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack (alignment: .center){
            Rectangle()
                .fill(Color("Peach"))
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 30)
                .frame(height: 750)
                .offset(y: 40)
                .foregroundColor(Color(.white))
            VStack {
                ShortTextField(placeholder: "email@address.com")
                    .padding(.top, 90)
                ShortTextField(placeholder: "password")
                Spacer()
                NavigationLink {
                    ContentView()
                } label: {
                    PrimaryButton(buttonText: "Masuk")
                }
            }
        }
        .navigationTitle("Masuk")
        .navigationBarBackButtonHidden(true)
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
    }
}
