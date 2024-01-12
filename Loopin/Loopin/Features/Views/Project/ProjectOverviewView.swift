//
//  ProjectOverviewView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProjectOverviewView: View {
    @Environment(\.presentationMode) var presentationMode
    let projectTemplate: ProjectTemplateJSON
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                ZStack(alignment: .top) {
                    Image(projectTemplate.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 390, maxHeight: 290)
                    RoundedRectangle(cornerRadius: 30)
                        .frame(minHeight: 571)
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
                        NavigationLink {
                            ProjectInfoView(project:
                                    Project(
                                        type: projectTemplate.type,
                                        name: projectTemplate.name,
                                        image: projectTemplate.image,
                                        description: "",
                                        preparation: projectTemplate.preparation,
                                        yarnType: projectTemplate.yarnType,
                                        yarnWeight: projectTemplate.yarnWeight,
                                        hookSize: projectTemplate.hookSize,
                                        stitchType: projectTemplate.stitchType,
                                        subParts: projectTemplate.subParts,
                                        samples: projectTemplate.samples)

                            )
                        } label: {
                            PrimaryButton(buttonText: "Buat Proyek")
                        }
                        .padding(.horizontal)
                        .padding(.top, 50)
                    }
                    .padding(.top, 280)
                    .padding()
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
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ProjectOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOverviewView(projectTemplate: ProjectTemplateJSON(type: "Cardigan", name: "name", image: "test", description: "description", preparation: "preparation", yarnType: "yarn type", yarnWeight: "yarn weight", hookSize: "hook size", stitchType: "stitch type", subParts: [], samples: []))
    }
}
