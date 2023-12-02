//
//  SquareCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct SquareCard: View {
    let cardText: String = "Lorem ipsum"
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color.white)
                .frame(width: 172, height: 191)
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.gray)
                    .frame(width: 152, height: 137)
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
        SquareCard()
    }
}
