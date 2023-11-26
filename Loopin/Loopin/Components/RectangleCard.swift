//
//  RectangleCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct RectangleCard: View {
    let cardText: String = "Lorem ipsum dolor sit amet asdefcsgv  ede c s"
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color.white)
                .frame(width: 358, height: 120)
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.gray)
                    .frame(width: 100, height: 100)
                Text(cardText)
                    .font(.outfit(.semiBold, size: .body2))
                    .foregroundColor(Color("Black"))
                    .padding(.horizontal, 10)

            }
            .padding(.all, 10)
        }
        .shadow(color:.black .opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
