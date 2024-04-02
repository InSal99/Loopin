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
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 18) {
                    ForEach(patternData) { patternItem in
                        NavigationLink(destination: PatternTutorialView(pattern: patternItem)) {
                            SquareCard(cardText: patternItem.name, cardImage: patternItem.symbol)
                        }
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
