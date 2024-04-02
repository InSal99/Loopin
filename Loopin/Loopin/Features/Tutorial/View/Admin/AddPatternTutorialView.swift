//
//  AddPatternTutorialView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 06/03/24.
//

import SwiftUI

struct AddPatternTutorialView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var abbrevation: String = ""
    @State private var patternDesc1: String = ""
    @State private var patternDesc2: String = ""
    @State private var patternDesc3: String = ""
    
    @State private var patternSymbol: UIImage? = nil
    @State private var patternStep1: UIImage? = nil
    @State private var patternStep2: UIImage? = nil
    @State private var patternStep3: UIImage? = nil
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                    VStack {
                        ShortTextField(placeholder: "nama pola", field: $name)
                            .padding(.top, 25)
                        ImagePickerView(selectedImage: $patternSymbol) {
                            print("image clear")
                        }
                        ShortTextField(placeholder: "singkatan pola", field: $abbrevation)
                        LongTextField(placeholder: "langkah pertama pola...", field: $patternDesc1)
                        ImagePickerView(selectedImage: $patternStep1) {
                            print("image clear")
                        }
                        LongTextField(placeholder: "langkah kedua pola...", field: $patternDesc2)
                        ImagePickerView(selectedImage: $patternStep1) {
                            print("image clear")
                        }
                        LongTextField(placeholder: "langkah ketiga pola...", field: $patternDesc3)
                        ImagePickerView(selectedImage: $patternStep1) {
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
                            if (name.isEmpty || patternSymbol == nil || abbrevation.isEmpty || patternDesc1.isEmpty || patternStep1 == nil || patternDesc2.isEmpty || patternStep2 == nil || patternDesc3.isEmpty || patternStep3 == nil) {
                                return Alert(title: Text("Gagal Menambahkan Pola"), message: Text("Detail Pola harus diisi."), dismissButton: .default(Text("OK")) {
                                    showAlert = false
                                })
                            }
                            else {
                                return Alert(title: Text("Pola Berhasil Ditambahkan"), message: Text(""), dismissButton: .default(Text("OK")) {
                                    showAlert = false
                                    presentationMode.wrappedValue.dismiss()
                                })
                            }
                    }
                    }
                }
                .background(Color("White"))
                .navigationTitle("Tambah Glosarium")
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
    AddPatternTutorialView()
}
