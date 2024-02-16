//
//  CreateProjectView.swift
//  Loopin
//
//  Created by Celine Margaretha on 14/01/24.
//

import SwiftUI

struct CreateProjectView: View {
    @Environment(\.presentationMode) var presentationMode
    var dismissParent: () -> Void

    @State private var showAlert = false
    @State private var inputWidths: [String] = []
    @State private var inputLengths: [String] = []
//    @State private var navigateToProfile = false
    @State var project: Project
    @Binding var navigateToProfile : Bool

//    @State var projectToEdit: ProjectViewModel
    
    @ObservedObject var projectListViewModel = ProjectListViewModel.shared

    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.vertical){
                ShortTextField(placeholder: "nama", field: $project.name)
                LongTextField(placeholder: "deskripsi proyek", field: $project.description)
                
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
            }
            
            
            Button(action: {
                showAlert = true
            }) {
                PrimaryButton(buttonText: "Simpan Proyek")
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Simpan Proyek"),
                    message: Text("Apakah anda yakin ingin menyimpan projek?"),
                    primaryButton: .default(Text("Ya")) {
                        projectListViewModel.add(project) { isSuccess in
                            print("projectListViewModel - add = \(isSuccess)")
                        }
                        navigateToProfile = true
//                        parent.presentationMode.wrappedValue.dismiss()
                        dismissParent()

                        
                    },
                    secondaryButton: .destructive(Text("Batal"))
                )
            }
            .padding(.top, 25)
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
            .onAppear(perform: initializeArrays)
        }
        .padding(.top, 25)
        .foregroundColor(.black)
        .edgesIgnoringSafeArea(.all)

    }
    
    private func initializeArrays() {
       guard !project.subParts.isEmpty else {
           return
       }

       inputWidths = Array(repeating: "", count: project.subParts.count)
       inputLengths = Array(repeating: "", count: project.subParts.count)
        
   }
}

//struct CreateProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateProjectView()
//    }
//}
