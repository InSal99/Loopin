//
//  WelcomePage.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI
import Foundation

struct WelcomePage: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("Loopin-Logo2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .padding(55)
                Spacer()
                
                NavigationLink {
                    LoginView()
                } label: {
                    PrimaryButton(buttonText: "Masuk")
                }
               
                NavigationLink {
                    SignUpView()
                } label: {
                    SecondaryButton(buttonText: "Daftar")
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
