//
//  TarnTutorialListView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 08/01/24.
//

import SwiftUI

struct YarnTutorialListView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var yarnData: [Yarn] = []
    @State private var selectedYarnItem: Yarn?
    
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
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func loadYarnData() {
        let viewModel = JSONDataViewModel()
        yarnData = viewModel.loadYarnData()
    }
    
}

//#Preview {
//    YarnTutorialListView()
//}
