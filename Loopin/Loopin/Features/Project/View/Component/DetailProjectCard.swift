//
//  DetailProjectCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct DetailProjectCard: View {
    let placeholder1: String
    let placeolder2: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 358, height: 55)
                .foregroundColor(Color.white)
            HStack {
                Text(placeholder1)
                    .font(.outfit(.ligth, size: .body2))
                Spacer()
                Text(placeolder2)
                    .font(.outfit(.regular, size: .body2))
                    .multilineTextAlignment(.trailing)
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

struct DetailProjectCard_Previews: PreviewProvider {
    static var previews: some View {
        DetailProjectCard(placeholder1: "lorem ipsum", placeolder2: "lorem ipsum")
    }
}
