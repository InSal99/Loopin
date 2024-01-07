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
    
    
    var body: some View {
        VStack {
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 25) {
                    
                    ForumCard(postViewModel:postViewModel)

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
