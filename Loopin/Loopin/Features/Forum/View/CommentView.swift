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
    @StateObject var postViewModel: PostViewModel
    @StateObject var commentListViewModel: CommentListViewModel
    @State var textFieldLineLimit = 1
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 25) {
                        ForumCard(postViewModel: postViewModel)
                            .padding(.horizontal)
                        
                        if !commentListViewModel.commentViewModels.isEmpty {
                            ForEach(commentListViewModel.commentViewModels.indices, id: \.self) { index in
                                CommentCard(commentViewModel: commentListViewModel.commentViewModels[index])
                                    .id(commentListViewModel.commentViewModels[index].id)
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
                .onChange(of: commentListViewModel.commentViewModels.count) { _ in
                    // Scroll to the last comment when the comment list changes
                    if !commentListViewModel.commentViewModels.isEmpty {
                        withAnimation {
                            proxy.scrollTo(commentListViewModel.commentViewModels.last!.id)
                        }
                    }
                }
            }
            
            HStack {
                TextField("Tambahkan komentar", text: $commentListViewModel.commentTextInput, axis:.vertical)
                    .font(.outfit(.regular, size: .body2))
                    .textFieldStyle(PlainTextFieldStyle())
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .lineLimit(textFieldLineLimit...3)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .onSubmit {
                        if textFieldLineLimit <= 3 {
                            textFieldLineLimit += 1
                        }
                    }
                    
                Button {
                    addComment()
                    commentListViewModel.objectWillChange.send()
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
        .onAppear {
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
                "-", content: commentListViewModel.commentTextInput)
        
        postViewModel.commentListViewModel?.add(newComment) { isSuccess in
            
            DispatchQueue.main.async {
                postViewModel.post.totComments += 1
                print("add comment is success? \(isSuccess)")
            }
        }
        
        
        
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(postViewModel: PostViewModel(post: testData[0]), commentListViewModel: PostViewModel(post: testData[0]).commentListViewModel!)
    }
}
