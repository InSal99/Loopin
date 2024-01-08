//
//  PatternTutorialListView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 07/01/24.
//

import SwiftUI
import SwiftUI

struct PatternTutorialListView: View {
//    @State private var isPatternViewPresented = false
    @State private var patternData: [Pattern] = []
    @State private var selectedPatternItem: Pattern?
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 18) {
                    ForEach(patternData) { patternItem in
                        NavigationLink(destination: PatternTutorialView(pattern: patternItem)) {
                            SquareCard(cardText: patternItem.name, cardImage: patternItem.symbol)
                        }
                        //                        Button(action: {
                        //                            selectedPatternItem = patternItem
                        //                            isPatternViewPresented.toggle()
                        //                        }, label: {
                        //                            SquareCard(cardText: patternItem.name , cardImage: patternItem.symbol )
                        //                        })
                        //                        .sheet(isPresented: $isPatternViewPresented) {
                        //                            if let selectedPatternItem = selectedPatternItem {
                        //                                PatternTutorialView(pattern: selectedPatternItem)
                        //                            }
                        //                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                loadPatternData()
            }
        }
    }
    
    func loadPatternData() {
        patternData = load("PatternData.json")
    }
    
    func load<T: Decodable>(_ filename: String) -> T {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in the main bundle.")
        }
        
        let data: Data
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from the main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}


#Preview {
    PatternTutorialListView()
}
