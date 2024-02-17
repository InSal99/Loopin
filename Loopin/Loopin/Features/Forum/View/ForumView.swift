//
//  ForumView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct ForumView: View {
    @State private var isPostForumViewPresented = false
    @ObservedObject var postListViewModel = PostListViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView {
                ScrollView(.vertical){
                    VStack (spacing: 15){
                        ForEach(postListViewModel.postViewModels) { postViewModel in
                            ForumCardWithNavigation(postViewModel:postViewModel)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                }
                .navigationTitle("Forum")
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarBackButtonHidden(true)
                .background(Color("White"))
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
                        }.edgesIgnoringSafeArea(.bottom)
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
