//
//  HookTutorialViewAdmin.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 06/03/24.
//

import SwiftUI

struct HookTutorialViewAdmin: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isAddHookTutorialViewPresented = false
    private let title: String = "Cara Memegang Hakpen"
    private let content: String =  "Pegang bagian datar dari hakpen dengan jari ibu jari dan jari telunjuk Anda, lihat posisi ibu jari pada hakpen, dan tempatkan ibu jari tangan dominan anda sambil mencubit sisi belakang dengan jari telunjuk anda. Letakkan hakpen di atas jari tengah seperti memegang pensil, dengan sisa jari Anda mengarah ke telapak tangan, dan biarkan hakpen berada di jari tengah seperti memegang pensil. Gunakan jari Anda untuk mengarahkan hakpen saat merajut, cocok untuk yang suka menjaga jari dekat dengan jahitan atau meletakkan jari telunjuk di atas ikatan yang sedang dirajut. Cara memegang ini adalah metode yang baik untuk pemula."
    private let images = ["HookTutorial-1", "HookTutorial-2", "HookTutorial-3"]
    @State private var accordionData: [Hook] = []
    @State private var showDeleteAlert = false
    @State private var isEditHookViewPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                ZStack(alignment: .top) {
                    ImageSlider(images: images)
                        .frame(maxWidth: 390, maxHeight: 290)
                    RoundedRectangle(cornerRadius: 30)
                        .frame(minHeight: 571)
                        .foregroundColor(Color(.white))
                        .padding(.top, 273)
                    VStack(alignment: .leading, spacing: 20) {
                        Text(title)
                            .font(.outfit(.semiBold, size: .heading3))
                        Text(content)
                            .font(.outfit(.regular, size: .body2))
                        Text("Rekomendasi")
                            .font(.outfit(.semiBold, size: .body3))
                        ForEach(accordionData, id: \.self) {
                            accordionItem in 
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(accordionItem.title)
                                        .font(.outfit(.semiBold, size: .body2))
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                    Button(action: {}) {
                                        Menu {
                                            Button(action: {
                                                isEditHookViewPresented.toggle()
                                            }) {
                                                Label("Edit", systemImage: "pencil")
                                            }
                                            .padding(.horizontal, 5)
                                            
                                            Button(action: {
                                                showDeleteAlert.toggle()
                                                print("heee")
                                            }) {
                                                Label("Hapus", systemImage: "trash")
                                                    .foregroundColor(.red)
                                            }
                                            .padding(.horizontal, 5)
                                        }
                                    label: {
                                        Image(systemName: "ellipsis.circle")
                                            .foregroundColor(.black)
                                            .scaleEffect(1.2)
                                    }
                                    .padding(.horizontal, 5)
                                    .padding(.leading, 8)
                                    .padding(.vertical, 5)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                Text(accordionItem.content)
                                    .font(.outfit(.regular, size: .body2))
                                    .frame(width: 327, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .opacity(0.05)
                            )
                        }
                    }
                    .padding(.top, 300)
                    .padding()
                    .sheet(isPresented: $isEditHookViewPresented) {
                        //edit page
                    }
                    .alert(isPresented: $showDeleteAlert) {
                        Alert(
                            title: Text("Hapus Hakpen"),
                            message: Text("Apakah anda yakin ingin menghapus hakpen?"),
                            primaryButton: .destructive(Text("Batal")),
                            secondaryButton: .default(Text("Hapus")) {
                                //delete yarn action
                            }
                        )
                    }
                }
            }
            .ignoresSafeArea()
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddHookTutorialViewPresented.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    })
                    .sheet(isPresented: $isAddHookTutorialViewPresented) {
                        AddHookTutorialView()
                    }.edgesIgnoringSafeArea(.bottom)
                }
            }
            .onAppear {
                loadAccordionData()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func loadAccordionData() {
        let viewModel = JSONDataViewModel()
        accordionData = viewModel.loadHookData()
    }
}

#Preview {
    HookTutorialViewAdmin()
}
