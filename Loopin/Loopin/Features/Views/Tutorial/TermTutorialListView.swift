//
//  TermTutorialListView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 06/01/24.
//

import SwiftUI

struct TermTutorialListView: View {
    //    @State private var isTermViewPresented = false
    @State private var termData: [[String: String]] = []
    @State private var selectedTermItem: [String: String]?
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 18) {
                    ForEach(termData, id: \.self) { termItem in
                        NavigationLink(destination: TermTutorialView(title: termItem["title"] ?? "", content: termItem["content"] ?? "", images: termItem["image"] ?? "")) {
                            SquareCard(cardText: termItem["title"] ?? "", cardImage: termItem["image"] ?? "")
                        }
                        //                        Button(action: {
                        //                            selectedTermItem = termItem
                        //                            isTermViewPresented.toggle()
                        //                        }, label: {
                        //                            SquareCard(cardText: termItem["title"] ?? "", cardImage: termItem["image"] ?? "")
                        //                        })
                        //                        .sheet(isPresented: $isTermViewPresented) {
                        //                            if let selectedTermItem = selectedTermItem {
                        //                                TermTutorialView(title: selectedTermItem["title"]!, content: selectedTermItem["content"]!, images: selectedTermItem["image"]!)
                        //                            }
                        //                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                loadTermData()
            }
        }
    }
    
    func loadTermData() {
        termData = load("TermData.json")
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
    TermTutorialListView()
}
