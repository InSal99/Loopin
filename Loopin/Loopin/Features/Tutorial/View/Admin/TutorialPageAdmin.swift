//
//  TutorialPageAdmin.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 06/03/24.
//

import SwiftUI

struct TutorialPageAdmin: View {
    let tutorials: [(String, String)] = [
        ("Tutorial-2", "Glosarium Crochet"),
        ("Tutorial-1", "Cara Memegang Hakpen"),
        ("Tutorial-3", "Pola Crochet"),
        ("Tutorial-4", "Benang Crochet")
    ]
    
    var body: some View {
            VStack(alignment: .leading) {
                NavigationView {
                    ScrollView(.vertical){
                        VStack (spacing: 10){
                            ForEach(1...4, id: \.self) { item in
                                NavigationLink {
                                    switch(item) {
                                    case 1:
                                        TermTutorialListViewAdmin()
                                    case 2:
                                        //crochettermtutorialview
                                        HookTutorialViewAdmin()
                                    case 3:
                                        //patterntutorialview
                                        PatternTutorialListViewAdmin()
                                    case 4:
                                        //yarntutorialview
                                        YarnTutorialListViewAdmin()
                                    default: EmptyView()
                                    }
                                } label: {
                                    RectangleCard(cardImage: tutorials[item - 1].0, cardText: tutorials[item - 1].1)
                                }
                            }
                        }
                    }
                    .background(Color("White"))
                    .navigationTitle("Tutorial")
                }
                .navigationBarBackButtonHidden(true)
            }
    }
}

#Preview {
    TutorialPageAdmin()
}
