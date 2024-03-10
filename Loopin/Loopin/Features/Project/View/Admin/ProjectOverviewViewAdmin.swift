//
//  ProjectOverviewViewAdmin.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 07/03/24.
//

import SwiftUI

struct ProjectOverviewViewAdmin: View {
    @Environment(\.presentationMode) var presentationMode
    let projectTemplate: ProjectTemplateJSON
    @State private var navigateToProfile = false
    @State private var isAddProjectViewPresented = false
    @State private var isChildViewPresented = false
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                ZStack(alignment: .top) {
                    ImageSlider(images: [projectTemplate.image])
                        .frame(maxWidth: 390, maxHeight: 290)
                    RoundedRectangle(cornerRadius: 30)
                        .frame(minHeight: 571)
                        .foregroundColor(Color(.white))
                        .padding(.top, 273)
                    VStack(alignment: .leading, spacing: 25) {
                        Text(projectTemplate.name)
                            .font(.outfit(.semiBold, size: .heading3))
                            .padding(.horizontal)
                        Text(projectTemplate.description)
                            .font(.outfit(.regular, size: .body2))
                            .padding(.horizontal)
                        VStack(spacing: 10) {
                            DetailProjectCard(placeholder1: "Jenis Benang", placeolder2: projectTemplate.yarnType)
                            DetailProjectCard(placeholder1: "Ketebalan Benang", placeolder2: projectTemplate.yarnWeight)
                            DetailProjectCard(placeholder1: "Ukuran Hakpen", placeolder2: projectTemplate.hookSize)
                            DetailProjectCard(placeholder1: "Jenis Tusukan", placeolder2: projectTemplate.stitchType)
                        }
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Bagian Proyek")
                                .font(.outfit(.semiBold, size: .body3))
                                .padding(.horizontal)
                            VStack(spacing: 10) {
                                ForEach(projectTemplate.subParts, id: \.self) { subPartItem in
                                    ProjectPartNameCard(subPart: subPartItem)
                                }
                            }
                        }
                    }
                    .padding(.top, 300)
                    .padding()
                }
            }
            .ignoresSafeArea()
            .background(Color("White"))
            .navigationViewStyle(StackNavigationViewStyle())
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddProjectViewPresented.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    })
                    .sheet(isPresented: $isAddProjectViewPresented) {
                        AddProjectTemplateView()
                    }.edgesIgnoringSafeArea(.bottom)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProjectOverviewViewAdmin(projectTemplate: ProjectTemplateJSON(type: "Cardigan", name: "name", image: "test", description: "description", preparation: "preparation", yarnType: "yarn type", yarnWeight: "yarn weight", hookSize: "hook size", stitchType: "stitch type", subParts: [], sample: Gauges(length: 6, width: 6, stitch: 6, row: 6)))
}
