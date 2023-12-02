//
//  ForumView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct ForumView: View {
    @State private var isPostForumViewPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView {
                ScrollView(.vertical){
                    VStack (spacing: 15){
                        ForEach(1...5, id: \.self) { item in
                            ForumCard()
                        }
                    }
                }
                .navigationTitle("Forum")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isPostForumViewPresented.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                        })
                        .sheet(isPresented: $isPostForumViewPresented) {
                            PostForumView()
                        }
                    }
                }
            }
        }
    }
}

struct ForumView_Previews: PreviewProvider {
    static var previews: some View {
        ForumView()
    }
}
