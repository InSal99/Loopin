//
//  ProjectDetailView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProjectDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let selectedProject: Project
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 25) {
                    Text(selectedProject.description)
                        .font(.outfit(.regular, size: .body2))
                        .padding(.horizontal)
                    VStack(spacing: 10) {
                        DetailProjectCard(placeholder1: "Jenis Benang", placeolder2: selectedProject.yarnType)
                        DetailProjectCard(placeholder1: "Ketebalan Benang", placeolder2: selectedProject.yarnWeight)
                        DetailProjectCard(placeholder1: "Ukuran Hakpen", placeolder2: selectedProject.hookSize)
                        DetailProjectCard(placeholder1: "Jenis Tusukan", placeolder2: selectedProject.stitchType)
                    }
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Bagian Proyek")
                            .font(.outfit(.semiBold, size: .body3))
                            .padding(.horizontal)
                        VStack(spacing: 10) {
                            ForEach(selectedProject.subParts, id: \.self) { subPartItem in
                                ProjectPartCard(subPart: subPartItem)
                            }
                        }
                    }
                }
                NavigationLink {
                    ///ongoing project
                    CurrentProjectView(currentProject: selectedProject)
                } label: {
                    PrimaryButton(buttonText: "Mulai Proyek")
                }
                .padding(.horizontal)
                .padding(.top)
            }
            .background(Color("White"))
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationTitle("\(selectedProject.name)")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct ProjectDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectDetailView(selectedProject:  Project(type:"tipe", name: "name", image: "test", description: "description", preparation: "preparation", yarnType: "yarn type", yarnWeight: "yarn weight", hookSize: "hook size", stitchType: "stitch type", subParts: [], sample: Gauges(length: 6, width: 6, stitch: 6, row: 6)))
//    }
//}
