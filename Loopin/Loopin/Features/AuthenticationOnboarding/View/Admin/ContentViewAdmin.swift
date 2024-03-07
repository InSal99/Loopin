//
//  ContentViewAdmin.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 06/03/24.
//

import SwiftUI

struct ContentViewAdmin: View {
    @State private var navigateToWelcomePage = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            TabView {
                // Tab 1
                TutorialPageAdmin()
                    .tabItem {
                        Image(uiImage: UIImage(named: "tutorial")!)
                        Text("Tutorial")
                            .font(.outfit(.semiBold, size: .label2))
                    }

                // Tab 2
                ProjectsViewAdmin()
                    .tabItem {
                        Image(uiImage: UIImage(named: "project")!)
                        Text("Proyek")
                            .font(.outfit(.semiBold, size: .label2))
                    }
            }
            .toolbar(.visible, for: .tabBar)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $navigateToWelcomePage) {
                    WelcomePage()
            }

        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentViewAdmin()
}
