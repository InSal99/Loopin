//
//  SquareCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct SquareCard: View {
    var cardText: String
    var cardImage: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color.white)
                .frame(width: 172, height: 191)
            VStack {
                Image(cardImage)
                    .resizable()
//                    .aspectRatio(contentMode: .fill)
                    .scaledToFill()
                    .frame(maxWidth: 152, maxHeight: 137)
                    .cornerRadius(25)
                Text(cardText)
                    .font(.outfit(.semiBold, size: .body2))
                    .foregroundColor(Color("Black"))

            }
            .padding(.all, 10)
        }
        .cornerRadius(30)
        .shadow(color:.black .opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

struct SquareCard_Previews: PreviewProvider {
    static var previews: some View {
        SquareCard(cardText: "Title", cardImage: "test")
    }
}
