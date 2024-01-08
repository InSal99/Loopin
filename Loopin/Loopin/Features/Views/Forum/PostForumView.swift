//
//  PostForumView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct PostForumView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var message: String
    @State private var image: String
    @State private var isOnEdit: Bool
    
    var postToEdit: Post?
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @ObservedObject var postListViewModel = PostListViewModel()
    
    init(isOnEdit: Bool? = nil, postToEdit: Post? = nil) {
        self.postToEdit = postToEdit
        _message = State(initialValue: postToEdit?.content ?? "")
        _image = State(initialValue: postToEdit?.content ?? "")
        _isOnEdit = State(initialValue: isOnEdit ?? false)

    }
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .center){
//                RoundedRectangle(cornerRadius: 30)
//                    .frame(height: 750)
//                    .foregroundColor(Color(.white))
                VStack {
                    LongTextField(placeholder: "tulis sesuatu...", field: $message)
                    ShortTextField(placeholder: "tambah gambar", field: $image)
                    Spacer()
                    Button{
                        if isOnEdit {
                            updatePost()
                        } else {
                            addPost()
                        }
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        PrimaryButton(buttonText: "Kirim")
                    }
                }
            }
            .background(Color("White"))
            .navigationTitle("Unggah Forum")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
    
    func addPost() {
        let newPost = Post(
            userId: authViewModel.authService.user?.id ?? "",
            username: authViewModel.authService.user?.username ?? "",
            content: message,
            time: Date.now,
            totLikes: 0,
            totComments: 0
        )
        postListViewModel.add(newPost)
    }
    
    func updatePost() {
        guard var post = postToEdit else { return }
        post.content = message
        postListViewModel.update(post)
    }
    
    
    
}


struct PostForumView_Previews: PreviewProvider {
    static var previews: some View {
        PostForumView()
    }
}
