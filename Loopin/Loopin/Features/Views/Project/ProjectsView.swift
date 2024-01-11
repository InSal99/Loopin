//
//  ProjectsView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct ProjectsView: View {
    @State private var isProjectOverviewViewPresented = false
    @State private var projectTemplateData: [Project] = []
    @State private var selectedTemplateItem: Project?
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 18) {
                    ForEach(projectTemplateData) { templateItem in
                        NavigationLink(destination: ProjectOverviewView(projectTemplate: templateItem)) {
                            SquareCard(cardText: templateItem.name, cardImage: templateItem.image)
                        }
                    }
                }
            }
            .navigationTitle("Proyek")
            .navigationBarBackButtonHidden(true)
            .background(Color("White"))
            .onAppear {
                loadProjectTemplateData()
            }
        }
    }
    
    func loadProjectTemplateData() {
        projectTemplateData = load("ProjectTemplateData.json")
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

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
