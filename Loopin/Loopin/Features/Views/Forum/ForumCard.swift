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
    
    var postViewModel: PostViewModel

    @State var showDeleteAlert = false
    @State var isPostForumViewPresented = false
    @State var isCommentViewPresented = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color.white)
                .frame(width: 358, height: 130)
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline) {
                    Text("\(postViewModel.post.username)")
                        .font(.outfit(.semiBold, size: .body2))
                    Spacer()
                    
                    if postViewModel.isAllowedToEdit {
                        HStack (spacing: 10) {
                         
                            Button(action: {
                                isPostForumViewPresented.toggle()
                            }, label: {
                                Image(systemName: "pencil")
                                    .foregroundColor(.black)
                            })
                            .padding(5)
                            .sheet(isPresented: $isPostForumViewPresented) {
                                PostForumView(isOnEdit: true, postToEdit: postViewModel.post)
                            }
                            
                            Button(action: {
                                showDeleteAlert.toggle()
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .padding(5)
                            .alert(isPresented: $showDeleteAlert, content: {
                                Alert(
                                    title: Text("Delete Post"),
                                    message: Text("Are you sure you want to remove this post?"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        // Handle delete action
                                        postViewModel.remove()
                                    },
                                    secondaryButton: .cancel()
                                )
                            })
                        }

                    }
                  
                }
               
                Text(postViewModel.post.content)
                    .font(.outfit(.regular, size: .body2))
                    .padding(.bottom, 1)
                    .multilineTextAlignment(.leading)
                
                Text("\(postViewModel.post.time.formattedDateWithTime())")
                    .font(.outfit(.extraLight, size: .label2))
                HStack {
                    HStack {
                        Image("Heart")
                        Text("\(postViewModel.post.totLikes) likes")
                            .font(.outfit(.regular, size: .label1))
                    }
                    .padding(.trailing, 9)
                    .onTapGesture {
                        print("like button tapped")
                    }
                    
                    Button(action: {
                        isCommentViewPresented.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "bubble.right")
                            Text("\(postViewModel.post.totComments) Comments")
                                .font(.outfit(.regular, size: .label1))
                        }
                    })
                    .sheet(isPresented: $isCommentViewPresented) {
                        CommentView(postId: 0)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                            .padding(.top, 18)
                            .background(Color("White"))

                    }
                    
                   
                }
                .padding(.bottom, 5)
            }
            .foregroundColor(Color("Black"))
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
        }
        .padding(.horizontal)
        .shadow(color:.black .opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

struct ForumCard_Previews: PreviewProvider {
    static var previews: some View {
        let post = testData[0]
//        return CardView(cardViewModel: CardViewModel(card: card))
        
        return ForumCard(postViewModel: PostViewModel(post: post))
    }
}
