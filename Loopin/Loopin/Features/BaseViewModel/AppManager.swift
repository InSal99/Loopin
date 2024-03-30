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

    init() {
        reset()
    }
    
    func reset() {
        selectedContentMenuTab = 0
        selectedProfileSegment = 0
        showNavigationTabBar = true
    }
}
