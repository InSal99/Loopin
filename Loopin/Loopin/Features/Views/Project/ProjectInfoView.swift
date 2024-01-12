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

//    @State private var yarnType = ""
//    @State private var yarnSize = ""
//    @State private var hakpenSize = ""
//    @State private var stitchType = ""
    
    var body: some View {
        VStack(spacing: 20) {
            ProgressBar(value: 1, maximum: 2)
                .padding()
            ShortTextField(placeholder: "nama", field: $project.name)
            LongTextField(placeholder: "deskripsi proyek", field: $project.description)
//            ShortTextField(placeholder: "jenis benang", field: $yarnType)
//            ShortTextField(placeholder: "ketebalan benang", field: $yarnSize)
//            ShortTextField(placeholder: "ukuran hakpen", field: $hakpenSize)
//            ShortTextField(placeholder: "jenis jahitan", field: $stitchType)
            Spacer()
            NavigationLink {
                ProjectPartView(project: $project)
            } label: {
                PrimaryButton(buttonText: "Lanjut")
            }
            

//            NavigationLink {
////                SampleInfoView(project: project)
//                ProjectPartView(project: project, index: project.subParts.count, inputWidths: Array(repeating: "", count: project.subParts.count), inputLengths: Array(repeating: "", count: project.subParts.count))
//            } label: {
//                PrimaryButton(buttonText: "Lanjut")
//            }
//            .onAppear(perform: {
//                print("name \(project.name)")
//                print("sample \(project.samples.count)")
//                print("count \(project.subParts.count)")
//            })
            
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
