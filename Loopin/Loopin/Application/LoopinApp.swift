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

    var body: some Scene {
        WindowGroup {
//            WelcomePage()
            
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            ContentView()
        }
    }
}

