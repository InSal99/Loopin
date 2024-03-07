//
//  AddHookTutorialPage.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 06/03/24.
//

import SwiftUI

struct AddHookTutorialView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var size: String = ""
    @State private var message: String = ""
    
    @State private var selectedImage: UIImage? = nil
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .center){
                VStack {
                    ShortTextField(placeholder: "ukuran hakpen", field: $size)
                        .padding(.top, 25)
                    LongTextField(placeholder: "tambahkan deskripsi...", field: $message)
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
                        if (message.isEmpty || size.isEmpty) {
                            return Alert(title: Text("Gagal Menambahkan Hakpen"), message: Text("Detail hakpen harus diisi."), dismissButton: .default(Text("OK")) {
                                showAlert = false
                            })
                        }
                        else {
                            return Alert(title: Text("Hakpen Berhasil Ditambahkan"), message: Text(""), dismissButton: .default(Text("OK")) {
                                showAlert = false
                                presentationMode.wrappedValue.dismiss()
                            })
                        }
                    }
                }
            }
            .background(Color("White"))
            .navigationTitle("Tambah Hakpen")
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
    AddHookTutorialView()
}
