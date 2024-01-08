//
//  ProjectOverviewView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProjectOverviewView: View {
    let projectTemplate: Project
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                ImageSlider(images: [projectTemplate.image])
                    .frame(maxWidth: 390, maxHeight: 290)
                ZStack (alignment: .top) {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(minHeight: 571)
                        .foregroundColor(Color(.white))
                        .padding(.top, 273)
                    VStack(alignment: .leading, spacing: 20) {
                        Spacer()
                        Text(projectTemplate.name)
                            .font(.outfit(.semiBold, size: .heading3))
                        Text(projectTemplate.description)
                            .font(.outfit(.regular, size: .body2))
                        Spacer()
                        NavigationLink {
                            ProjectInfoView()
                        } label: {
                            PrimaryButton(buttonText: "Buat Proyek")
                        }
                        
                    }
                    .padding()
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct ProjectOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOverviewView(projectTemplate: Project(name: "name", image: "test", description: "description", preparation: "preparation", yarntType: "yarn type", yarnWeight: "yarn weight", hookSize: "hook size", stitchType: "stitch type", subPart: [], gauge: []))
    }
}
