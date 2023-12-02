//
//  ForumCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct ForumCard: View {
    let sender: String = "Jeff Satur"
    let content: String = "Lorem ipsum dolor sit amet consectetur adipiscin elit Ut et massa mi."
    let likeCount: Int = 0
    let commentCount: Int = 0
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color.white)
                .frame(width: 358, height: 130)
            VStack(alignment: .leading) {
                Text(sender)
                    .font(.outfit(.semiBold, size: .body2))
                Text(content)
                    .font(.outfit(.regular, size: .body2))
                HStack {
                    HStack {
                        Image("Heart")
                        Text("\(likeCount) likes")
                            .font(.outfit(.regular, size: .label1))
                    }
                    HStack {
                        Image("Heart")
                        Text("\(likeCount) Comments")
                            .font(.outfit(.regular, size: .label1))
                    }
                    .padding(.leading, 18)
                }
            }
            .foregroundColor(Color("Black"))
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
        }
        .padding(.horizontal)
        .shadow(color:.black .opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

struct ForumCard_Previews: PreviewProvider {
    static var previews: some View {
        ForumCard()
    }
}
