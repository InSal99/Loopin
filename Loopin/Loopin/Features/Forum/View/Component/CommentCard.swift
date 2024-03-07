//
//  CommentCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 23/12/23.
//

import SwiftUI

struct CommentCard: View {
//    let sender: String
//    let content: String
    
    @ObservedObject var commentViewModel: CommentViewModel
    @State private var showDeleteAlert = false
    @State private var isPostForumViewPresented = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image("arrow-down-right")
                
            HStack(spacing: 5) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(commentViewModel.comment.username)
                            .font(.outfit(.bold, size: .heading4))
                        Spacer()
                    }
                   
                    Text(commentViewModel.comment.content)
                        .font(.outfit(.regular, size: .body2))
                        .multilineTextAlignment(.leading)
                }
                
                if commentViewModel.isAllowedToEdit {
                    HStack (spacing: 10) {
                        Button(action: {
                            showDeleteAlert.toggle()
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .padding(5)
                        .alert(isPresented: $showDeleteAlert, content: {
                            Alert(
                                title: Text("Hapus Komentar"),
                                message: Text("Apakah anda yakin ingin menghapus komentar?"),
                                primaryButton: .destructive(Text("Batal")),
                                secondaryButton: .default(Text("Hapus")) {
                                    // Handle delete action
                                    commentViewModel.remove()
                                }
                            )
                        })
                    }

                }
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
        }
        .padding(.horizontal)
    }
}

//struct CommentCard_Previews: PreviewProvider {
//    static var previews: some View {
//        let comment = testComment[0]
////        return CardView(cardViewModel: CardViewModel(card: card))
//        
//        return CommentCard(commentViewModel: CommentViewModel(comment: comment, commentRepository: CommentRepository(postId: <#String#>)))
//    }
//}
