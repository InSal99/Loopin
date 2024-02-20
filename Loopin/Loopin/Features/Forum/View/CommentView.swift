//
//  CommentView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 23/12/23.
//

import SwiftUI

struct CommentView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @ObservedObject var postViewModel: PostViewModel
    @State private var comment: String = ""
    
    var body: some View {
        VStack {
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 25) {
                    
                    ForumCard(postViewModel:postViewModel)
                        .padding(.horizontal)
                    
                    
                    if(postViewModel.commentListViewModel!.commentViewModels.count != 0) {
                        ForEach(postViewModel.commentListViewModel!.commentViewModels) { commentViewModel in
                            CommentCard(commentViewModel: commentViewModel)
                            
                        }
                        
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
                    .textFieldStyle(PlainTextFieldStyle())
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
            .background(Color.white)

            
        }
        .navigationTitle("Komentar")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Set the presentation mode for PostViewModel
            postViewModel.presentationMode = presentationMode
        }
        
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