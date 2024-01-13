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
//                            NavigationLink {
//                                CommentView(postId: 1)
//                                CommentView(postViewModel: postViewModel)
//                            } label: {
//                                ForumCard(postViewModel:postViewModel)
                                ForumCardWithNavigation(postViewModel:postViewModel)
                                
//                                ForumCard(sender: "Marvin", content: "Lorem ipsum dolor sit amet consectetur adipiscin elit Ut et massa mi.", likeCount: 5, commentCount: 0)
//                            }
                            
                        }
                        
//                        ForEach(1...5, id: \.self) { item in
//                            //                            ForumCard()
//                            NavigationLink {
//                                CommentView(postId: item)
//                            } label: {
//                                let post = testData[0]
//                                ForumCard(postViewModel: PostViewModel(post: post))
//                                //                                ForumCard(sender: "Marvin", content: "Lorem ipsum dolor sit amet consectetur adipiscin elit Ut et massa mi.", likeCount: 5, commentCount: 0)
//                            }
//                        }
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
