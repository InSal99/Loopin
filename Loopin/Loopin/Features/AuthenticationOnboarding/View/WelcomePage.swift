//
//  WelcomePage.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI
import Foundation

struct WelcomePage: View {
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            if authViewModel.isLoggedIn || UserDefaults.standard.bool(forKey: UserDefaultKeys.login.rawValue) == true {
                ContentView()
            }
            
            if authViewModel.isLoggedIn == false {
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
        
//        if UserDefaults.standard.bool(forKey: "user") != false {
////        if appSettings.isLoggedIn || UserDefaults.standard.bool(forKey: UserDefaultKeys.login.rawValue) == true {
//            ContentView()
////                .environmentObject(authViewModel)
//        } else {
//            NavigationStack {
//                VStack {
//                    Spacer()
//                    Image("Loopin-Logo2")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: 200)
//                        .padding(55)
//                    Spacer()
//                    
//                    NavigationLink {
//                        LoginView()
//                    } label: {
//                        PrimaryButton(buttonText: "Masuk")
//                    }
//                   
//                    NavigationLink {
//                        SignUpView()
//                    } label: {
//                        SecondaryButton(buttonText: "Daftar")
//                    }
//                }
//                .navigationBarBackButtonHidden(true)
//            }
//        }
        
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
