//
//  CommentView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 23/12/23.
//

import SwiftUI

struct CommentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var comment: String = ""
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @ObservedObject var postViewModel: PostViewModel
    @State var isLiked = false
    
    
    var body: some View {
        VStack {
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 25) {
                    
//                    ForumCard(postViewModel:postViewModel)
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .firstTextBaseline) {
                            Text("\(postViewModel.post.username)")
                                .font(.outfit(.semiBold, size: .body2))
                                .padding(.vertical, 5)
                            Spacer()
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

    //                ForumCard(sender: "Marvin", content: "Lorem ipsum dolor sit amet consectetur adipiscin elit Ut et massa mi.", likeCount: 5, commentCount: 0)
                    
                    if(postViewModel.commentListViewModel!.commentViewModels.count != 0) {
                        ForEach(postViewModel.commentListViewModel!.commentViewModels) { commentViewModel in
                            CommentCard(commentViewModel: commentViewModel)
                            
                        }
//                        ForEach(1...5, id: \.self) { item in
//                            CommentCard(sender: "Moonshine", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus.")
//                        }
                        
                    } else {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .opacity(0)
                            Text("Belum ada komentar")
                                .padding(.top, 200)
                                .font(.outfit(.regular, size: .body2))
                                .opacity(0.5)
                        }
                    }
                }
                .padding(.bottom)
            }
            
            .background(Color("White"))

            HStack {
                TextField("Tambahkan komentar", text: $comment)
                    .font(.outfit(.regular, size: .body2))
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textFieldStyle(PlainTextFieldStyle())
                    .background(Color.white)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .padding(.leading)
                
                Button {
                    addComment()
                } label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .foregroundColor(.black)
                }
                .buttonStyle(.plain)
                .padding(.trailing)
                
            }
            .padding()

        
            
        }
        .navigationTitle("Komentar")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Set the presentation mode for PostViewModel
            postViewModel.presentationMode = presentationMode
        }
//        .onReceive(postViewModel.commentListViewModel?.$comments) { _ in
//            // Handle changes in comments and update the view
//            print("okela")
//        }
        
    }

    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
        }
    }
    
    func addComment() {
        let newComment =
        Comment(userId: authViewModel.authService.user?.id ??
                "-", time: Date.now, username: authViewModel.authService.user?.username ??
                "-", content: comment)
    
        postViewModel.commentListViewModel?.add(newComment)
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView(postViewModel: PostViewModel(post: testData[0]))
//    }
//}
