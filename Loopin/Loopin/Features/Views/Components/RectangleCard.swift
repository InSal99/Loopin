//
//  RectangleCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct RectangleCard: View {
    var cardImage: String
    var cardText: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
            HStack {
                Image(cardImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                Text(cardText)
                    .font(.outfit(.semiBold, size: .body2))
                    .foregroundColor(Color("Black"))
                    .padding(.horizontal, 10)
                    .multilineTextAlignment(.leading)
                    .frame(minWidth: 228, alignment: .leading)

            }
            .padding(10)
        }
        .padding(10)
        .foregroundColor(.white)
        .shadow(color:.black .opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard(cardImage: "Image", cardText: "Text")
    }
}
