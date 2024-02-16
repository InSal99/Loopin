//
//  ForumCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage

struct ForumCard: View {
    
    @ObservedObject var postViewModel: PostViewModel
    
    @State private var showDeleteAlert = false
    @State private var isPostForumViewPresented = false
    @State private var isLiked = false
    
    @State private var imageURL = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("\(postViewModel.post.username)")
                    .font(.outfit(.semiBold, size: .body2))
                    .padding(.vertical, 5)
                
                Spacer()
                
                if postViewModel.isAllowedToEdit {
                    Button(action: {}) {
                        Menu {
                            Button(action: {
                                isPostForumViewPresented.toggle()
                            }) {
                                Label("Edit", systemImage: "pencil")
                            }
                            .padding(.horizontal, 5)
                            
                            Button(action: {
                                showDeleteAlert.toggle()
                                print("heee")
                            }) {
                                Label("Delete", systemImage: "trash")
                                    .foregroundColor(.red)
                            }
                            .padding(.horizontal, 5)
                        }
                    label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.black)
                            .scaleEffect(1.2)
                    }
                    .padding(.horizontal, 5)
                    .padding(.leading, 8)
                    .padding(.vertical, 5)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
            }
            
            Text(postViewModel.post.content)
                .font(.outfit(.regular, size: .body2))
                .multilineTextAlignment(.leading)
                .padding(.bottom, 1)
            
            if imageURL != "" {
                VStack(alignment: .center){
                    
                    if let imageURL = URL(string: postViewModel.post.images[0]) {
                        AnimatedImage(url: imageURL)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width)
                            .cornerRadius(10)
                            .clipped()
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(10)
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            
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
                
                HStack {
                    Image("chat")
                    Text("\(postViewModel.commentListViewModel?.commentViewModels.count ?? 0) Comments")
                        .font(.outfit(.regular, size: .label1))
                }
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
        .shadow(color:.black .opacity(0.05), radius: 10, x: 0, y: 4)
        .sheet(isPresented: $isPostForumViewPresented) {
            PostForumView(isOnEdit: true, postToEdit: postViewModel)
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Menghapus Unggahan"),
                message: Text("Apakah anda yakin ingin menghapus unggahan?"),
                primaryButton: .destructive(Text("Hapus")) {
                    /// Handle delete action
                    postViewModel.remove()
                },
                secondaryButton: .default(Text("Batal"))
            )
        }
        .onAppear {
            if !postViewModel.post.images.isEmpty {
                let storage = Storage.storage().reference()
                
                //                print("STORAGE \(storage.bucket)")
                //                print("STORAGE \(storage.child("\(URL(string: postViewModel.post.images[0])!)"))")
                self.imageURL = "\(storage.child("\(URL(string: postViewModel.post.images[0])!)"))"
                //                print(self.imageURL)
            }
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
