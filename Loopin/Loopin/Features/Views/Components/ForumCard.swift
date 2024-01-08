//
//  ForumCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct ForumCard: View {
    //    let sender: String
    //    let content: String
    //    let likeCount: Int
    //    let commentCount: Int
    
    @StateObject var postViewModel: PostViewModel
    
    @State var showDeleteAlert = false
    @State var isPostForumViewPresented = false
    //    @State var isCommentViewPresented = false
    @State var isLiked = false
    
    var body: some View {
        NavigationLink {
            CommentView(postViewModel: postViewModel)
        } label: {
            //        ZStack(alignment: .leading) {
            //            RoundedRectangle(cornerRadius: 30)
            //                .foregroundColor(Color.white)
            //                .frame(width: 358, height: 130)
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline) {
                    Text("\(postViewModel.post.username)")
                        .font(.outfit(.semiBold, size: .body2))
                        .padding(.vertical, 5)
                    
                    Spacer()
                    
                    if postViewModel.isAllowedToEdit {
                        HStack (spacing: 10) {
                            Menu {
                                Button(action: {
                                    isPostForumViewPresented.toggle()
                                }) {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .padding(.horizontal, 5)
                                .sheet(isPresented: $isPostForumViewPresented) {
                                    PostForumView(isOnEdit: true, postToEdit: postViewModel.post)
                                }
                                
                                Button(action: {
                                    showDeleteAlert.toggle()
                                }) {
                                    Label("Delete", systemImage: "trash")
                                        .foregroundColor(.red)
                                }
                                .padding(.horizontal, 5)
                                .alert(isPresented: $showDeleteAlert, content: {
                                    Alert(
                                        title: Text("Delete Post"),
                                        message: Text("Are you sure you want to remove this post?"),
                                        primaryButton: .destructive(Text("Delete")) {
                                            /// Handle delete action
                                            postViewModel.remove()
                                        },
                                        secondaryButton: .cancel()
                                    )
                                })
                            }
                        label: {
                            Image(systemName: "ellipsis.circle")
                                .foregroundColor(.black)
                                .scaleEffect(1.2)
                        }
                        .padding(.horizontal, 5)
                        }
                    }
                    
                }
                
                Text(postViewModel.post.content)
                    .font(.outfit(.regular, size: .body2))
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 1)
                
                Text("\(postViewModel.post.time.formattedDateWithTime())")
                    .font(.outfit(.extraLight, size: .label2))
                
                HStack {
                    Button(action: {
                        postViewModel.updatePostLike()
                        print("like button tapped:\(isLiked)")
                        
                    }, label: {
                        HStack {
                            if postViewModel.isLiked {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(Color("Guava"))
                            } else {
                                Image("heart")
                            }
                            
                            Text("\(postViewModel.post.totLikes) likes")
                                .font(.outfit(.regular, size: .label1))
                        }
                        .padding(.trailing, 9)
                    })
                    
                    Spacer()
                    
                    //                    Button(action: {
                    //                        isCommentViewPresented.toggle()
                    //                    }, label: {
                    HStack {
                        Image("chat")
                        Text("\(postViewModel.commentListViewModel?.commentViewModels.count ?? 0) Comments")
                            .font(.outfit(.regular, size: .label1))
                    }
                    //                    })
                    //                    .sheet(isPresented: $isCommentViewPresented) {
                    //                        CommentView(postViewModel: postViewModel)
                    //                            .presentationDetents([.large])
                    //                            .presentationDragIndicator(.visible)
                    //                            .padding(.top, 18)
                    //                            .background(Color("White"))
                    
                    //                    }
                }
                .padding(.vertical, 3)
            }
            .foregroundColor(Color("Black"))
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color.white)
                //                    .frame(width: 327)
            )
            .padding(.horizontal)
            .shadow(color:.black .opacity(0.05), radius: 10, x: 0, y: 4)
            //        }
            //        .padding(.horizontal)
            //        .shadow(color:.black .opacity(0.05), radius: 10, x: 0, y: 4)        }
            
        }
    }
}

//struct ForumCard_Previews: PreviewProvider {
//    static var previews: some View {
//        let post = testData[0]
////        return CardView(cardViewModel: CardViewModel(card: card))
//
//        return ForumCard(postViewModel: PostViewModel(post: post))
//    }
//}
