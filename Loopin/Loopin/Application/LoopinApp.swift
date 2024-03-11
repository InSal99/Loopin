//
//  LoopinApp.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

@main
struct LoopinApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let persistenceController = PersistenceController.shared
    @StateObject private var authViewModel = AuthenticationViewModel.shared
    @StateObject private var postListViewModel = PostListViewModel.shared
    @StateObject private var projectListViewModel = ProjectListViewModel.shared
//    @State private var appManager = AppManager.shared
    
    var body: some Scene {
        WindowGroup {
            WelcomePage()
                .environmentObject(authViewModel)
                .environmentObject(postListViewModel)
                .environmentObject(projectListViewModel)
                .environmentObject(AppManager.shared)
        }
    }
}



