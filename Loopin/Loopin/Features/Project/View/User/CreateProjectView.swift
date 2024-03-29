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
    @State var project: Project
    
    @Binding var navigateToProfile : Bool

//    @ObservedObject var projectListViewModel = ProjectListViewModel.shared
    @EnvironmentObject var projectListViewModel : ProjectListViewModel
    @EnvironmentObject var appManager : AppManager

    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.vertical){
                ShortTextField(placeholder: "nama", field: $project.name)
                LongTextField(placeholder: "deskripsi proyek", field: $project.description)
                
                let endIndex = project.subParts.count
                VStack {
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
                .padding(.bottom, 250)
                Spacer()
            }
            
            Button(action: {
                showAlert = true
            }) {
                PrimaryButton(buttonText: "Simpan Proyek")
            }
            .onTapGesture(perform: {
                showAlert = true
            })
            .alert(isPresented: $showAlert) {
                if (project.name.isEmpty || project.description.isEmpty) {
                    var message: String = ""
                    if(project.name.isEmpty) {
                        message = "Nama proyek perlu diisi."
                    } else if(project.description.isEmpty) {
                        message = "Deskripsi proyek perlu diisi."
                    }
                    return Alert(title: Text("Gagal menyimpan proyek"), message: Text(message), dismissButton: .default(Text("OK")) {
                        showAlert = false
                    })
                } else {
                    return Alert(
                        title: Text("Simpan Proyek"),
                        message: Text("Apakah anda yakin ingin menyimpan projek?"),
                        primaryButton: .destructive(Text("Batal")),
                        secondaryButton: .default(Text("Simpan")) {
                            projectListViewModel.add(project) { isSuccess in
                                print("projectListViewModel - add = \(isSuccess)")
                            }
                            navigateToProfile = true
                            dismissParent()
                        }
                    )
                }
            }
            .padding([.top, .bottom], 20)
//            .navigationTitle("Info Proyek")
            .navigationBarBackButtonHidden(true)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        presentationMode.wrappedValue.dismiss()
//                    } label: {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(.black)
//                    }
//                }
//            }
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
