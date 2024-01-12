//
//  ProjectPartView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProjectPartView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var project: Project

    @State private var showAlert = false
    @State private var inputWidths: [String] = []
    @State private var inputLengths: [String] = []
    @State private var navigateToProfile = false
    @ObservedObject var projectListViewModel = ProjectListViewModel.shared

    var body: some View {
        VStack(spacing: 20) {
            ProgressBar(value: 3, maximum: 3)
                .padding()

            let endIndex = project.subParts.count
            
            ForEach(0 ..< endIndex) { index in
                let widthBinding = Binding<String>(
                    get: { String(project.subParts[index].gauge.width) },
                    set: { project.subParts[index].gauge.width = Double($0) ?? 0 }
                )

                let lengthBinding = Binding<String>(
                    get: { String(project.subParts[index].gauge.length) },
                    set: { project.subParts[index].gauge.length = Double($0) ?? 0 }
                )

                ProjectPartInputCard(subPart: project.subParts[index], inputWidth: widthBinding, inputLength: lengthBinding)
            }
          
            Spacer()
            Button(action: {
                showAlert = true
            }) {
                PrimaryButton(buttonText: "Simpan Proyek")
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Simpan Proyek"),
                    message: Text("Apakah anda yakin ingin menyimpan projek?"),
                    primaryButton: .default(Text("Yes")) {
//                        let project = Project(type: "Cardigan", name: "name", image: "test", description: "description", preparation: "preparation", yarnType: "yarn type", yarnWeight: "yarn weight", hookSize: "hook size", stitchType: "stitch type", subParts: [ SubPart(name: "Tangan", steps: [Step(text: "step1", nums: 0, isStitch: true, guidances: [])], gauge: Gauges(length: 5, width: 5, stitch: 5, row: 5))], samples: [Gauges(length: 6, width: 6, stitch: 6, row: 6)])
                        projectListViewModel.add(project) { isSuccess in
                            print("projectListViewModel - add = \(isSuccess)")
                        }
                        navigateToProfile = true
                        presentationMode.wrappedValue.dismiss()
                        
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationTitle("Info Sampel")
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToProfile, destination: {
            ProfileView()
        })
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
        .onAppear(perform: initializeArrays)
    }
    
    func initializeArrays() {
       guard !project.subParts.isEmpty else {
           print("yaah")
           return
       }

       inputWidths = Array(repeating: "", count: project.subParts.count)
       inputLengths = Array(repeating: "", count: project.subParts.count)
        
        print(inputWidths.count)

   }
}

//struct ProjectPartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectPartView(project: Project(type: "Cardigan", name: "name", image: "test", description: "description", preparation: "preparation", yarnType: "yarn type", yarnWeight: "yarn weight", hookSize: "hook size", stitchType: "stitch type", subParts: [], samples: []))
//    }
//}
