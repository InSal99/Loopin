//
//  StoragePaths.swift
//  Loopin
//
//  Created by Celine Margaretha on 09/03/24.
//

import Foundation

struct StoragePathGenerator {
    enum StorageFolder: String {
        case images = "Images"
        case contents
        case tutorial
        case templates
        case glosarium
        case hookHandling
        case pattern
        case yarn
    }
    
    static func getMainRefPath(forType type: StorageFolder) -> String? {
        switch type {
        case .images, .contents:
            return type.rawValue
        case .templates, .tutorial:
            return "\(StorageFolder.contents.rawValue)/\(type.rawValue)"
        case .glosarium, .hookHandling, .pattern, .yarn:
            return "\(StorageFolder.contents.rawValue)/\(StorageFolder.tutorial.rawValue)/\(type.rawValue)"
        }

    }
    
    static func getUserFolderRefPath(withId id: String) -> String{
        return "\(getMainRefPath(forType: .images)!)/\(id)"
    }
    
    static func getUserFolderRefPath() -> String{
        return "\(getMainRefPath(forType: .images)!)"
    }
}
