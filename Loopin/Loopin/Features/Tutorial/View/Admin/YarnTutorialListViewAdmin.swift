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
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 18) {
                    ForEach(yarnData) { yarnItem in
                        NavigationLink(destination: YarnTutorialView(yarn: yarnItem)) {
                            SquareCard(cardText: yarnItem.name, cardImage: yarnItem.image)
                        }
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
