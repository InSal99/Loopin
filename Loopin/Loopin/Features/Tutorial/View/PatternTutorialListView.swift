//
//  PatternTutorialListView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 07/01/24.
//

import SwiftUI
import SwiftUI

struct PatternTutorialListView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var patternData: [Pattern] = []
//    @State private var selectedPatternItem: Pattern?
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 18) {
                    ForEach(patternData) { patternItem in
                        NavigationLink(destination: PatternTutorialView(pattern: patternItem)) {
                            SquareCard(cardText: patternItem.name, cardImage: patternItem.symbol)
                        }
                        //                        Button(action: {
                        //                            selectedPatternItem = patternItem
                        //                            isPatternViewPresented.toggle()
                        //                        }, label: {
                        //                            SquareCard(cardText: patternItem.name , cardImage: patternItem.symbol )
                        //                        })
                        //                        .sheet(isPresented: $isPatternViewPresented) {
                        //                            if let selectedPatternItem = selectedPatternItem {
                        //                                PatternTutorialView(pattern: selectedPatternItem)
                        //                            }
                        //                        }
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
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func loadPatternData() {
        let viewModel = JSONDataViewModel()
        patternData = viewModel.loadPatternData()
    }
}


//#Preview {
//    PatternTutorialListView()
//}
