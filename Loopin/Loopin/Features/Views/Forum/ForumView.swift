//
//  ForumView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct ForumView: View {
    @State private var isPostForumViewPresented = false
    @ObservedObject var postListViewModel = PostListViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView {
                ScrollView(.vertical){
                    VStack (spacing: 15){
                        ForEach(postListViewModel.postViewModels) { postViewModel in
                            NavigationLink {
                                //                                CommentView(postId: 1)
                            } label: {
                                ForumCard(postViewModel:postViewModel)
                                
                                //                                ForumCard(sender: "Marvin", content: "Lorem ipsum dolor sit amet consectetur adipiscin elit Ut et massa mi.", likeCount: 5, commentCount: 0)
                            }
                            
                        }
                        
                        //                        ForEach(1...5, id: \.self) { item in
                        ////                            ForumCard()
                        //                            NavigationLink {
                        //                                CommentView(postId: item)
                        //                            } label: {
                        //                                let post = testData[0]
                        //                                ForumCard(postViewModel: PostViewModel(post: post))
                        ////                                ForumCard(sender: "Marvin", content: "Lorem ipsum dolor sit amet consectetur adipiscin elit Ut et massa mi.", likeCount: 5, commentCount: 0)
                        //                            }
                        //                        }
                    }
                }
                .navigationTitle("Forum")
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarBackButtonHidden(true)
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
