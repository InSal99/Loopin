//
//  AssYarnTutorialView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 06/03/24.
//

import SwiftUI

struct AddYarnTutorialView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var message: String = ""
    @State private var recommendedProject: String = ""
    @State private var notRecommendedProject: String = ""
    
    @State private var selectedImage: UIImage? = nil
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                ZStack (alignment: .center){
                    VStack {
                        ShortTextField(placeholder: "nama benang", field: $name)
                            .padding(.top, 25)
                        LongTextField(placeholder: "tambahkan deskripsi...", field: $message)
                        LongTextField(placeholder: "proyek direkomendasikan: dipisah dengan koma (,)", field: $recommendedProject)
                        LongTextField(placeholder: "proyek tidak direkomendasikan: dipisah dengan koma (,)", field: $notRecommendedProject)
                        ImagePickerView(selectedImage: $selectedImage) {
                            print("image clear")
                        }
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
                            if (message.isEmpty || name.isEmpty || recommendedProject.isEmpty || notRecommendedProject.isEmpty || selectedImage == nil) {
                                return Alert(title: Text("Gagal Menambahkan Benang"), message: Text("Detail benang harus diisi."), dismissButton: .default(Text("OK")) {
                                    showAlert = false
                                })
                            }
                            else {
                                return Alert(title: Text("Benang Berhasil Ditambahkan"), message: Text(""), dismissButton: .default(Text("OK")) {
                                    showAlert = false
                                    presentationMode.wrappedValue.dismiss()
                                })
                            }
                        }
                    }
                }
            }
            .background(Color("White"))
            .navigationTitle("Tambah Benang")
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
    AddYarnTutorialView()
}
