//
//  TutorialPage.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct TutorialPage: View {
    var body: some View {
            VStack(alignment: .leading) {
                NavigationView {
                    ScrollView(.vertical){
                        VStack (spacing: 10){
                            ForEach(1...5, id: \.self) { item in
                                NavigationLink {
                                    switch(item) {
                                    case 1:
                                        HookTutorialView()
                                    case 2:
                                        //crochettermtutorialview
                                        TermTutorialView()
                                    case 3:
                                        //patterntutorialview
                                        HookTutorialView()
                                    case 4:
                                        //yarntutorialview
                                        HookTutorialView()
                                    default: EmptyView()
                                    }
                                } label: {
                                    RectangleCard()
                                }
                            }
                        }
                    }
                    .navigationTitle("Tutorial")
                }
            }
    }
}

struct TutorialPage_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPage()
    }
}
