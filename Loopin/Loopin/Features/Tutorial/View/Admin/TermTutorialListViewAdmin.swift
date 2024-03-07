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
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 18) {
                    ForEach(termData, id: \.self) { termItem in
                        NavigationLink(destination: TermTutorialView(term: termItem)) {
                            SquareCard(cardText: termItem.title, cardImage: termItem.image)
                        }
                    }
                }
            }
            .background(Color("White"))
            .navigationTitle("Daftar Istilah")
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
