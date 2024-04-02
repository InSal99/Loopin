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
            VStack(alignment: .leading) {
                ScrollView(.vertical){
                    ZStack(alignment: .top) {
                        Image(projectTemplate.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 390, maxHeight: 290)
                        RoundedRectangle(cornerRadius: 30)
                            .frame(minHeight: 600)
                            .foregroundColor(Color(.white))
                            .padding(.top, 243)
                            .padding()
                        VStack(alignment: .leading, spacing: 20) {
                            Spacer()
                            Text(projectTemplate.type)
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
                            Spacer()
                            //                        Button() {
                            //                            isChildViewPresented.toggle()
                            //                        } label: {
                            //                            PrimaryButton(buttonText: "Buat Proyek")
                            //                        }.padding(.horizontal)
                            //                            .padding(.top, 50)
                            //                            .sheet(isPresented: $isChildViewPresented) {
                            //                                CreateProjectView(dismissParent: {
                            //                                    isChildViewPresented = false
                            //                                    presentationMode.wrappedValue.dismiss()
                            //                                }, project:
                            //                                                    Project(
                            //                                                        type: projectTemplate.type,
                            //                                                        name: projectTemplate.name,
                            //                                                        image: projectTemplate.image,
                            //                                                        description: "",
                            //                                                        preparation: projectTemplate.preparation,
                            //                                                        yarnType: projectTemplate.yarnType,
                            //                                                        yarnWeight: projectTemplate.yarnWeight,
                            //                                                        hookSize: projectTemplate.hookSize,
                            //                                                        stitchType: projectTemplate.stitchType,
                            //                                                        subParts: projectTemplate.subParts,
                            //                                                        sample: projectTemplate.sample),
                            //                                                  navigateToProfile: $navigateToProfile
                            //                                )
                            //                            }
                        }
                        .padding(.top, 120)
                        .padding()
                    }
                }
            }
            .ignoresSafeArea()
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
                        PostForumView()
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
