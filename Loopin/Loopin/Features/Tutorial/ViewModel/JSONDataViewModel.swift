//
//  HookViewModel.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 15/01/24.
//

import Foundation

struct JSONDataViewModel {
    func load<T: Decodable>(_ filename: String) -> T {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        let data: Data
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    func loadHookData() -> [Hook] {
        return load("HookData.json")
    }
    
    func loadTermData() -> [Term] {
        return load("TermData.json")
    }
    
    func loadPatternData() -> [Pattern] {
        return load("PatternData.json")
    }
    
    func loadYarnData() -> [Yarn] {
        return load("YarnData.json")
    }
    
    func loadProjectTemplateData() -> [ProjectTemplateJSON] {
        return load("ProjectTemplateData.json")
    }
    
    func loadTutorialData() -> [TutorialAdmin] {
        return load("TutorialAdminData.json")
    }
}
