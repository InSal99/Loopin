//
//  ProjectsView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct ProjectsView: View {
    @State private var isProjectOverviewViewPresented = false
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 18) {
                    ForEach(1...10, id: \.self) { option in
                        Button(action: {
                            isProjectOverviewViewPresented.toggle()
                        }, label: {
                            SquareCard()
                        })
                        .sheet(isPresented: $isProjectOverviewViewPresented) {
                            ProjectOverviewView(projectName: "Lorem Ipsum", projectDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
                        }
                    }
                }
            }
            .navigationTitle("Proyek")
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
