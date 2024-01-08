//
//  ContentView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var navigateToWelcomePage = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            TabView {
                // Tab 1
                TutorialPage()
                    .tabItem {
                        Image(uiImage: UIImage(named: "tutorial")!)
                        Text("Tutorial")
                            .font(.outfit(.semiBold, size: .label2))
                    }

                // Tab 2
                ProjectsView()
                    .tabItem {
                        Image(uiImage: UIImage(named: "project")!)
                        Text("Proyek")
                            .font(.outfit(.semiBold, size: .label2))
                    }
                    
                // Tab 3
                ForumView()
                    .tabItem {
                        Image(uiImage: UIImage(named: "forum")!)
                        Text("Forum")
                            .font(.outfit(.semiBold, size: .label2))
                    }
            
                // Tab 4
                ProfileView()
                    .tabItem {
                        Image(uiImage: UIImage(named: "profile")!)
                        Text("Profile")
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
