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
    
    @State private var selectedImage: UIImage? = nil
    @State private var showAlert = false
    
    var postModelToEdit: PostViewModel?
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var postListViewModel : PostListViewModel
//    @ObservedObject var postListViewModel = PostListViewModel.shared
    
    init(isOnEdit: Bool? = nil, postToEdit: PostViewModel? = nil) {
        self.postModelToEdit = postToEdit
        _message = State(initialValue: postToEdit?.post.content ?? "")
        _image = State(initialValue: postToEdit?.post.content ?? "")
        _isOnEdit = State(initialValue: isOnEdit ?? false)
        
    }
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .center){
                //                RoundedRectangle(cornerRadius: 30)
                //                    .frame(height: 750)
                //                    .foregroundColor(Color(.white))
                VStack {
                    if !isOnEdit {
                        ImagePickerView(selectedImage: $selectedImage) {
                            print("image clear")
                        }
                    }
                    
                    LongTextField(placeholder: "tulis sesuatu...", field: $message)
                    //                    ShortTextField(placeholder: "tambah gambar", field: $image)
                    
                    Spacer()
                    Button{
                        showAlert = true
                    } label: {
                        PrimaryButton(buttonText: "Kirim")
                    }
                    .onTapGesture(perform: {
                        showAlert = true
                    })
                    .alert(isPresented: $showAlert) {
                        if (message.isEmpty) {
                            return Alert(title: Text("Gagal Mengirim Unggahan"), message: Text("Deskripsi unggahan harus diisi."), dismissButton: .default(Text("OK")) {
                                showAlert = false
                            })
                        }
                        else {
                            return Alert(title: Text("Unggahan Terkirim"), message: Text(""), dismissButton: .default(Text("OK")) {
                                showAlert = false
                                if isOnEdit {
                                    updatePost()
                                } else {
                                    addPost()
                                }
                                presentationMode.wrappedValue.dismiss()
                            })
                        }
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
    
    private func addPost() {
        let newPost = Post(
            userId: authViewModel.authService.user?.id ?? "",
            username: authViewModel.authService.user?.username ?? "",
            content: message,
            time: Date.now,
            totLikes: 0,
            totComments: 0
        )
        if let selectedImage = selectedImage {
            postListViewModel.add(newPost, withImages: [selectedImage])
        } else {
            postListViewModel.add(newPost)
        }
    }
    
    private func updatePost() {
        guard var post = postModelToEdit?.post else { return }
        post.content = message
        postModelToEdit?.update(post: post)
    }
}


struct PostForumView_Previews: PreviewProvider {
    static var previews: some View {
        PostForumView()
    }
}
