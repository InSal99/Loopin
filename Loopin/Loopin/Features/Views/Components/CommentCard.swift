//
//  CommentCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 23/12/23.
//

import SwiftUI

struct CommentCard: View {
    let sender:String
    let content: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            Image("Arrow-down-right")
            VStack(alignment: .leading, spacing: 10) {
                Text(sender)
                    .font(.outfit(.semiBold, size: .body2))
                Text(content)
                    .font(.outfit(.regular, size: .body2))
            }
            .foregroundColor(Color("Black"))
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color.white)
                    .frame(width: 327)
            )
            .shadow(color:.black .opacity(0.05), radius: 10, x: 0, y: 4)
        }
        .padding(.horizontal)
    }
}

struct CommentCard_Previews: PreviewProvider {
    static var previews: some View {
        CommentCard(sender: "Sender", content: "Content")
    }
}
