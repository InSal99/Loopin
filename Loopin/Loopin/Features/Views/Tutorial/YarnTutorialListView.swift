//
//  TarnTutorialListView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 08/01/24.
//

import SwiftUI

struct YarnTutorialListView: View {
//    @State private var isYarnViewPresented = false
    @State private var yarnData: [Yarn] = []
    @State private var selectedYarnItem: Yarn?
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 18) {
                    ForEach(yarnData) { yarnItem in
                        NavigationLink(destination: YarnTutorialView(yarn: yarnItem)) {
                            SquareCard(cardText: yarnItem.name, cardImage: yarnItem.image)
                        }
                        //                        Button(action: {
                        //                            selectedYarnItem = yarnItem
                        //                            isYarnViewPresented.toggle()
                        //                        }, label: {
                        //                            SquareCard(cardText: yarnItem.name, cardImage: yarnItem.image )
                        //                        })
                        //                        .sheet(isPresented: $isYarnViewPresented) {
                        //                            if let selectedYarnItem = selectedYarnItem {
                        //                                YarnTutorialView(yarn: selectedYarnItem)
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
        yarnData = load("YarnData.json")
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
    YarnTutorialListView()
}
