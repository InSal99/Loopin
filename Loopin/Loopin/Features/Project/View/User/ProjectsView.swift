//
//  ProjectsView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct ProjectsView: View {
    @State private var isProjectOverviewViewPresented = false
    @State private var projectTemplateData: [ProjectTemplateJSON] = []
  
    var body: some View {
        VStack {
            ScrollView(.vertical){
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 18) {
                    ForEach(projectTemplateData) { templateItem in
                        
                        NavigationLink {
                            ProjectOverviewView(projectTemplate: templateItem)
                                .toolbar(.hidden, for: .tabBar)
                        } label: {
                            SquareCard(cardText: templateItem.type, cardImage: templateItem.image)
                        }
                        
//                        NavigationLink(destination:
//                        ProjectOverviewView(projectTemplate: templateItem)
//                            .toolbar(.hidden, for: .tabBar)
//) {
//                            SquareCard(cardText: templateItem.type, cardImage: templateItem.image)
//                        }
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

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
