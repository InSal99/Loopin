//
//  ProjectInfoView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProjectInfoView: View {
    @Environment(\.presentationMode) var presentationMode
   
    @State var project: Project

    @State private var name = ""
    @State private var desc = ""
    @State private var yarnType = "0"
    @State private var yarnSize = "0"
    @State private var hakpenSize = "0"
    @State private var stitchType = "0"

    var body: some View {
        VStack(spacing: 20) {
            ProgressBar(value: 1, maximum: 3)
                .padding()
            ShortTextField(placeholder: "nama", field: $project.name)
            LongTextField(placeholder: "deskripsi proyek", field: $project.description)
            ShortTextField(placeholder: "jenis benang", field: $yarnType)
            ShortTextField(placeholder: "ketebalan benang", field: $yarnSize)
            ShortTextField(placeholder: "ukuran hakpen", field: $hakpenSize)
            ShortTextField(placeholder: "jenis jahitan", field: $stitchType)
            Spacer()
            NavigationLink {
                ProjectPartView(project: $project)
            } label: {
                PrimaryButton(buttonText: "Lanjut")
            }
            

        }
        .navigationTitle("Info Proyek")
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
    
//    func setProjectValue() {
//        project.name = name
//        project.description = desc
//    }
}

struct ProjectInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectInfoView(project: Project(type: "Cardigan", name: "name", image: "test", description: "description", preparation: "preparation", yarnType: "yarn type", yarnWeight: "yarn weight", hookSize: "hook size", stitchType: "stitch type", subParts: [], samples: []))
    }
}
