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
//=======
//    var project: Project
//        var index: Int
//
//        @State private var inputWidths: [String]
//        @State private var inputLengths: [String]
//
//        init(project: Project, index: Int, inputWidths: [String], inputLengths: [String]) {
//            self.project = project
//            self.index = index
//            self._inputWidths = State(initialValue: inputWidths)
//            self._inputLengths = State(initialValue: inputLengths)
//        }
//>>>>>>> View3

//    init(index: Int, inputWidths: [String], inputLengths: [String]){
//        self.index = project.subParts.count
//        self.inputWidths = Array(repeating: "", count: index)
//        self.inputLengths = Array(repeating: "", count: index)
//        
//    }
    
    @State private var showAlert = false
    @State private var inputWidths: [String] = []
    @State private var inputLengths: [String] = []
    @State private var navigateToProfile = false
    @ObservedObject var projectListViewModel = ProjectListViewModel.shared


    var body: some View {
        VStack(spacing: 20) {
            ProgressBar(value: 2, maximum: 2)
                .padding()

            let endIndex = project.subParts.count
            
            ForEach(0 ..< endIndex) { index in
                let sample = project.sample
                let widthBinding = Binding<String>(
                    get: { String(project.subParts[index].gauge.width) },
                    set: {
                        project.subParts[index].gauge.width = Double($0) ?? 0
                        project.subParts[index].gauge.updateStitch(sample: sample)
                    }
                )

                let lengthBinding = Binding<String>(
                    get: { String(project.subParts[index].gauge.length) },
                    set: {
                        project.subParts[index].gauge.length = Double($0) ?? 0
                        project.subParts[index].gauge.updateRow(sample: sample)
                    }
                )

                ProjectPartInputCard(subPart: project.subParts[index], inputWidth: widthBinding, inputLength: lengthBinding)
            }
//                    ForEach(0...index, id: \.self) { item in
//                        ProjectPartInputCard(
//                            subPart: project.subParts[item],
//                            inputWidth: $inputWidths[item],
//                            inputLength: $inputLengths[item]
//                        )
          
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
//                        let project = Project(type: "Cardigan", name: "name", image: "test", description: "description", preparation: "preparation", yarnType: "yarn type", yarnWeight: "yarn weight", hookSize: "hook size", stitchType: "stitch type", subParts: [ SubPart(name: "Tangan", steps: [Step(text: "step1", nums: 0, isStitch: true, guidances: [])], gauge: Gauges(length: 5, width: 5, stitch: 5, row: 5))], sample: [Gauges(length: 6, width: 6, stitch: 6, row: 6)])
                        projectListViewModel.add(project) { isSuccess in
                            print("projectListViewModel - add = \(isSuccess)")
                        }
                        navigateToProfile = true

                        presentationMode.wrappedValue.dismiss()
                        ProfileView()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationTitle("Info Sampel")
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
//        ProjectPartView(project: Project(type: "Cardigan", name: "name", image: "test", description: "description", preparation: "preparation", yarnType: "yarn type", yarnWeight: "yarn weight", hookSize: "hook size", stitchType: "stitch type", subParts: [], sample: Gauges(length: 6, width: 6, stitch: 6, row: 6)))
//    }
//}

                    
//MARK: DUMP
//struct ProjectPartView: View {
//    @Environment(\.presentationMode) var presentationMode
//    
//    var project: Project
//    var index: Int
//
//    @State private var showAlert = false
//    @State private var inputWidths: [String] = []
//    @State private var inputLengths: [String] = []
//    @State private var navigateToProfile = false
//    @ObservedObject var projectListViewModel = ProjectListViewModel.shared
//
//    var body: some View {
//        VStack(spacing: 20) {
//            ProgressBar(value: 3, maximum: 3)
//                .padding()
//
//            ForEach(project.subParts.indices, id: \.self) { item in
//                ProjectPartInputCard(
//                    subPart: project.subParts[item],
//                    inputWidth: Binding(
//                        get: { inputWidths[item] },
//                        set: { inputWidths[item] = $0 }
//                    ),
//                    inputLength: Binding(
//                        get: { inputLengths[item] },
//                        set: { inputLengths[item] = $0 }
//                    )
//                )
//                .onAppear(perform: {
//                    print(project.subParts[item].name)
//                })
//            }
//            .onAppear(perform: {
//                print(project.subParts.count)
//            })
//
//            Spacer()
//
//            Button(action: {
//                showAlert = true
//            }) {
//                PrimaryButton(buttonText: "Simpan Proyek")
//            }
//            .alert(isPresented: $showAlert) {
//                Alert(
//                    title: Text("Simpan Proyek"),
//                    message: Text("Apakah anda yakin ingin menyimpan projek?"),
//                    primaryButton: .default(Text("Yes")) {
//                        let project = Project(type: "Cardigan", name: "name", image: "test", description: "description", preparation: "preparation", yarnType: "yarn type", yarnWeight: "yarn weight", hookSize: "hook size", stitchType: "stitch type", subParts: [ SubPart(name: "Tangan", steps: [Step(text: "step1", nums: 0, isStitch: true, guidances: [])], gauge: Gauges(length: 5, width: 5, stitch: 5, row: 5))], sample: [Gauges(length: 6, width: 6, stitch: 6, row: 6)])
//                        projectListViewModel.add(project) { isSuccess in
//                            print("projectListViewModel - add = \(isSuccess)")
//                        }
//                        navigateToProfile = true
//                        presentationMode.wrappedValue.dismiss()
//                        
//                    },
//                    secondaryButton: .cancel()
//                )
//            }
//        }
//        .onAppear {
//            self.inputWidths = Array(repeating: "", count: self.project.subParts.count)
//            self.inputLengths = Array(repeating: "", count: self.project.subParts.count)
//        }
//        .navigationTitle("Info Sampel")
//        .navigationBarBackButtonHidden(true)
//        .navigationDestination(isPresented: $navigateToProfile, destination: {
//            ProfileView()
//        })
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    presentationMode.wrappedValue.dismiss()
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(.black)
//                }
//            }
//        }
//    }
//    }
//


//struct ProjectPartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectPartView(project: Project(type: "type", name: "name", image: "test", description: "description", preparation: "preparation", yarnType: "yarnType", yarnWeight: "yarnWeight", hookSize: "hookSize", stitchType: "stitchType"), index: 0, inputWidths: [], inputLengths: [])
//    }
//}
