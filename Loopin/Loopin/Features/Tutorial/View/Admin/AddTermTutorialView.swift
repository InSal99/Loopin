//
//  AddTermTutorialView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 06/03/24.
//

import SwiftUI

struct AddTermTutorialView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String = ""
    @State private var message: String = ""
    
    @State private var selectedImage: UIImage? = nil
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .center){
                VStack {
                    ShortTextField(placeholder: "judul glosarium", field: $title)
                        .padding(.top, 25)
                    LongTextField(placeholder: "tambahkan deskripsi...", field: $message)
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
                        if (message.isEmpty || title.isEmpty || selectedImage == nil) {
                            return Alert(title: Text("Gagal Menambahkan Glosarium"), message: Text("Detail glosarium harus diisi."), dismissButton: .default(Text("OK")) {
                                showAlert = false
                            })
                        }
                        else {
                            return Alert(title: Text("Glosarium Berhasil Ditambahkan"), message: Text(""), dismissButton: .default(Text("OK")) {
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
    AddTermTutorialView()
}
