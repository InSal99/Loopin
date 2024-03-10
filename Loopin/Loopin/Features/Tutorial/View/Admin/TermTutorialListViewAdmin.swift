//
//  TermTutorialListViewAdmin.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 06/03/24.
//

import SwiftUI

struct TermTutorialListViewAdmin: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isAddTermTutorialViewPresented = false
    @State private var termData: [Term] = []
    @State private var showDeleteAlert = false
    @State private var isEditTermViewPresented = false
    
    var cardImage: String = "image"
    var cardText: String = "text"
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack (spacing: 10){
                    ForEach(termData, id: \.self) { termItem in
                        NavigationLink(destination: TermTutorialView(term: termItem)) {
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 20)
                                HStack(alignment: .center) {
                                    Image(termItem.image)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(15)
                                    Text(termItem.title)
                                        .font(.outfit(.semiBold, size: .body2))
                                        .foregroundColor(Color("Black"))
                                        .padding(.horizontal, 10)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                    Button(action: {}) {
                                        Menu {
                                            Button(action: {
                                                isEditTermViewPresented.toggle()
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
                        .sheet(isPresented: $isEditTermViewPresented) {
                            //edit page
                        }
                        .alert(isPresented: $showDeleteAlert) {
                            Alert(
                                title: Text("Hapus Glosarium"),
                                message: Text("Apakah anda yakin ingin menghapus glosarium?"),
                                primaryButton: .destructive(Text("Batal")),
                                secondaryButton: .default(Text("Hapus")) {
                                    //delete term action
                                }
                            )
                        }
                    }
                }
            }
            .background(Color("White"))
            .navigationTitle("Daftar Glosarium")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadTermData()
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
                        isAddTermTutorialViewPresented.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    })
                    .sheet(isPresented: $isAddTermTutorialViewPresented) {
                        AddTermTutorialView()
                    }.edgesIgnoringSafeArea(.bottom)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func loadTermData() {
        let viewModel = JSONDataViewModel()
        termData = viewModel.loadTermData()
    }
}

#Preview {
    TermTutorialListViewAdmin()
}
