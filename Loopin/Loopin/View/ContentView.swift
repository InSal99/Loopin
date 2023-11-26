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
        TabView {
            // Tab 1
            TutorialPage()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("Tutorial")
                        .font(.outfit(.semiBold, size: .label2))
                }

            // Tab 2
            ProjectsView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Proyek")
                        .font(.outfit(.semiBold, size: .label2))
                }
                
            // Tab 3
            ForumView()
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Forum")
                        .font(.outfit(.semiBold, size: .label2))
                }
        
            // Tab 4
            ProfileView()
                .tabItem {
                    Image(systemName: "4.square.fill")
                    Text("Profile")
                        .font(.outfit(.semiBold, size: .label2))
                }
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $navigateToWelcomePage) {
                WelcomePage()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
