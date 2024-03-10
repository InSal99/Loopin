//
//  AddProjectTemplateView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 10/03/24.
//

import SwiftUI

struct AddProjectTemplateView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var projectdesc: String = ""
    @State private var yarnType: String = ""
    @State private var yarnWeight: String = ""
    @State private var hookSize: String = ""
    @State private var stitchType: String = ""
    
    @State private var projectImage: UIImage? = nil
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                    VStack {
                        ShortTextField(placeholder: "nama proyek", field: $name)
                            .padding(.top, 25)
                        ImagePickerView(selectedImage: $projectImage) {
                            print("image clear")
                        }
                        LongTextField(placeholder: "tambahkan deskripsi...", field: $projectdesc)
                        ShortTextField(placeholder: "jenis benang", field: $yarnType)
                            .padding(.bottom,15)
                        ShortTextField(placeholder: "ketebalan benang", field: $yarnWeight)
                            .padding(.bottom,15)
                        ShortTextField(placeholder: "ukuran hakpen", field: $hookSize)
                            .padding(.bottom,15)
                        ShortTextField(placeholder: "jenis tusukan", field: $stitchType)
                            .padding(.bottom,15)
                        Spacer()
                        Button{
                            showAlert = true
                        } label: {
                            PrimaryButton(buttonText: "Tambah")
                        }
                        .onTapGesture(perform: {
                            showAlert = true
                        })
                        .alert(isPresented: $showAlert) {
                            if (name.isEmpty || projectImage == nil || projectdesc.isEmpty || yarnType.isEmpty || yarnWeight.isEmpty || hookSize.isEmpty || stitchType.isEmpty) {
                                return Alert(title: Text("Gagal Menambahkan Proyek"), message: Text("Detail Proyek harus diisi."), dismissButton: .default(Text("OK")) {
                                    showAlert = false
                                })
                            }
                            else {
                                return Alert(title: Text("Proyek Berhasil Ditambahkan"), message: Text(""), dismissButton: .default(Text("OK")) {
                                    showAlert = false
                                    presentationMode.wrappedValue.dismiss()
                                })
                            }
                    }
                    }
                }
                .background(Color("White"))
                .navigationTitle("Tambah Proyek")
                .navigationBarTitleDisplayMode(.inline)
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
    }
}

#Preview {
    AddProjectTemplateView()
}
