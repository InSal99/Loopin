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
        NavigationView {
            VStack {
                Spacer()
                Text("Loopin")
                    .font(.outfit(.bold, size: .heading1))
                Spacer()
                
                NavigationLink {
                    LoginView()
                } label: {
                    PrimaryButton(buttonText: "Masuk")
                        .onTapGesture {
                            print("welcome view")
                        }
                }
               
                
                
                NavigationLink {
                    SignUpView()
                } label: {
                    SecondaryButton(buttonText: "Daftar")
                        
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
