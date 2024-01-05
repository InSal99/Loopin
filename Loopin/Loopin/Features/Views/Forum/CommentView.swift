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
    let postId: Int
    let commentCount: Int = 3
    
    var body: some View {
        VStack {
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 25) {
                    let post = testData[0]
                    ForumCard(postViewModel: PostViewModel(post: post))

    //                ForumCard(sender: "Marvin", content: "Lorem ipsum dolor sit amet consectetur adipiscin elit Ut et massa mi.", likeCount: 5, commentCount: 0)
                    
                    if(commentCount != 0) {
                        ForEach(1...5, id: \.self) { item in
                            CommentCard(sender: "Moonshine", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus.")
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

            HStack{
                TextField("Tambahkan komentar", text: $comment)
                    .font(.outfit(.regular, size: .body2))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                
                Button {
                    
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                }
                .buttonStyle(.borderedProminent)
                
            }
            .padding()

        
            
        }
        .navigationTitle("Komentar")
        .navigationBarTitleDisplayMode(.inline)
        
    }

    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(postId: 0)
    }
}
