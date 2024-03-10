//
//  YernTutorialListViewAdmin.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 06/03/24.
//

import SwiftUI

struct YarnTutorialListViewAdmin: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isAddYarnTutorialViewPresented = false
    @State private var yarnData: [Yarn] = []
    @State private var showDeleteAlert = false
    @State private var isEditYarnViewPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ForEach(yarnData) { yarnItem in
                    NavigationLink(destination: YarnTutorialView(yarn: yarnItem)) {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 20)
                            HStack(alignment: .center) {
                                Image(yarnItem.image)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                                Text(yarnItem.name)
                                    .font(.outfit(.semiBold, size: .body2))
                                    .foregroundColor(Color("Black"))
                                    .padding(.horizontal, 10)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                Button(action: {}) {
                                    Menu {
                                        Button(action: {
                                            isEditYarnViewPresented.toggle()
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
                            .padding()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .shadow(color:.black .opacity(0.05), radius: 10, x: 0, y: 4)
                    }
                    .sheet(isPresented: $isEditYarnViewPresented) {
                        //edit page
                    }
                    .alert(isPresented: $showDeleteAlert) {
                        Alert(
                            title: Text("Hapus Benang"),
                            message: Text("Apakah anda yakin ingin menghapus benang?"),
                            primaryButton: .destructive(Text("Batal")),
                            secondaryButton: .default(Text("Hapus")) {
                                //delete yarn action
                            }
                        )
                    }
                    
                }
            }
            .background(Color("White"))
            .navigationTitle("Daftar Benang")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadYarnData()
            }
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
                        isAddYarnTutorialViewPresented.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    })
                    .sheet(isPresented: $isAddYarnTutorialViewPresented) {
                        AddYarnTutorialView()
                    }.edgesIgnoringSafeArea(.bottom)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func loadYarnData() {
        let viewModel = JSONDataViewModel()
        yarnData = viewModel.loadYarnData()
    }
    
}

#Preview {
    YarnTutorialListViewAdmin()
}
