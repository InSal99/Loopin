//
//  ProjectsViewAdmin.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 07/03/24.
//

import SwiftUI

struct ProjectsViewAdmin: View {
    @State private var isProjectOverviewViewPresented = false
    @State private var projectTemplateData: [ProjectTemplateJSON] = []
    
  
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 18) {
                    ForEach(projectTemplateData) { templateItem in
                        NavigationLink(destination: ProjectOverviewViewAdmin(projectTemplate: templateItem)) {
                            SquareCard(cardText: templateItem.type, cardImage: templateItem.image)
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
        let viewModel = JSONDataViewModel()
        projectTemplateData = viewModel.loadProjectTemplateData()
    }
}

#Preview {
    ProjectsViewAdmin()
}
