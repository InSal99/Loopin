//
//  AppManager.swift
//  Loopin
//
//  Created by Celine Margaretha on 11/03/24.
//

import Foundation
class AppManager : ObservableObject {
    static let shared = AppManager()
    
    @Published var selectedContentMenuTab = 0
    @Published var selectedProfileSegment = 0
    @Published var showNavigationTabBar = true

}
