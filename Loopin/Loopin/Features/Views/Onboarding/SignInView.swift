//
//  SignInView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct SignInView: View {
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
                ShortTextField(placeholder: "username")
                    .padding(.top, 90)
                ShortTextField(placeholder: "email@address.com")
                ShortTextField(placeholder: "phone")
                ShortTextField(placeholder: "password")
                ShortTextField(placeholder: "confirm password")
                Spacer()
                NavigationLink {
                    ContentView()
                } label: {
                    PrimaryButton(buttonText: "Daftar")
                }
                
            }
        }
        .navigationTitle("Daftar")
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
