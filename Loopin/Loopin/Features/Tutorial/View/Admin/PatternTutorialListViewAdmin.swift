//
//  PatternTutorialListViewAdmin.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 06/03/24.
//

import SwiftUI

struct PatternTutorialListViewAdmin: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isAddPatternTutorialViewPresented = false
    @State private var patternData: [Pattern] = []
    @State private var showDeleteAlert = false
    @State private var isEditPatternViewPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ForEach(patternData) { patternItem in
                    NavigationLink(destination: PatternTutorialView(pattern: patternItem)) {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 20)
                            HStack(alignment: .center) {
                                Image(patternItem.symbol)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                                Text(patternItem.name)
                                    .font(.outfit(.semiBold, size: .body2))
                                    .foregroundColor(Color("Black"))
                                    .padding(.horizontal, 10)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                Button(action: {}) {
                                    Menu {
                                        Button(action: {
                                            isEditPatternViewPresented.toggle()
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
                    .sheet(isPresented: $isEditPatternViewPresented) {
                        //edit page
                    }
                    .alert(isPresented: $showDeleteAlert) {
                        Alert(
                            title: Text("Hapus Pola"),
                            message: Text("Apakah anda yakin ingin menghapus pola?"),
                            primaryButton: .destructive(Text("Batal")),
                            secondaryButton: .default(Text("Hapus")) {
                                //delete pattern action
                            }
                        )
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .background(Color("White"))
            .navigationTitle("Daftar Pola")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadPatternData()
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
                        isAddPatternTutorialViewPresented.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    })
                    .sheet(isPresented: $isAddPatternTutorialViewPresented) {
                        AddPatternTutorialView()
                    }.edgesIgnoringSafeArea(.bottom)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func loadPatternData() {
        let viewModel = JSONDataViewModel()
        patternData = viewModel.loadPatternData()
    }
}

#Preview {
    PatternTutorialListViewAdmin()
}
