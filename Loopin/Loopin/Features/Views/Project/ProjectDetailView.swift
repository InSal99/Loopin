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
                        DetailProjectCard(placeholder1: "Jenis Benang", placeolder2: selectedProject.yarntType)
                        DetailProjectCard(placeholder1: "Ketebalan Benang", placeolder2: selectedProject.yarnWeight)
                        DetailProjectCard(placeholder1: "Ukuran Hakpen", placeolder2: selectedProject.hookSize)
                        DetailProjectCard(placeholder1: "Jenis Tusukan", placeolder2: selectedProject.stitchType)
                    }
                    Text("Bagian Proyek")
                        .font(.outfit(.semiBold, size: .body3))
                        .padding(.horizontal)
                    VStack(spacing: 10) {
                        ForEach(selectedProject.subPart, id: \.self) { subPartItem in
                            ProjectPartCard(subPart: subPartItem)
                        }
                    }
                    NavigationLink {
                        //ongoing project
                        CurrentProjectView(currentProject: selectedProject)
                    } label: {
                        PrimaryButton(buttonText: "Mulai Proyek")
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color("White"))
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationTitle("Detail Proyek")
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

struct ProjectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDetailView(selectedProject: Project(name: "name", image: "test", description: "description", preparation: "preparation", yarntType: "yarn type", yarnWeight: "yarn weight", hookSize: "hook size", stitchType: "stitch type", subPart: [], gauge: []))
    }
}
