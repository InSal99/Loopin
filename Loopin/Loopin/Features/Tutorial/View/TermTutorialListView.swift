//
//  TermTutorialListView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 06/01/24.
//

import SwiftUI

struct TermTutorialListView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var appManager: AppManager
    @State private var termData: [Term] = []
//    @State private var selectedTermItem: Term?
    
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
                appManager.showNavigationTabBar = false
            }
            .onDisappear {
                appManager.showNavigationTabBar = true
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
    
    func loadTermData() {
        let viewModel = JSONDataViewModel()
        termData = viewModel.loadTermData()
    }
}


//#Preview {
//    TermTutorialListView()
//}
