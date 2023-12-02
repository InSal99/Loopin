//
//  ProjectPartInputCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProjectPartInputCard: View {
    let placeholder1: String
    let placeholder2: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 358, height: 90)
                .foregroundColor(Color("White"))
            VStack(alignment: .leading) {
                Text("nama bagian")
                    .font(.outfit(.medium, size: .body2))
                HStack {
                    Text(placeholder1)
                        .font(.outfit(.ligth, size: .body2))
                    Spacer()
                    Text("\(placeholder2) cm")
                        .font(.outfit(.regular, size: .body2))
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text(placeholder1)
                        .font(.outfit(.ligth, size: .body2))
                    Spacer()
                    Text("\(placeholder2) cm")
                        .font(.outfit(.regular, size: .body2))
                        .multilineTextAlignment(.trailing)
                }
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

struct ProjectPartInputCard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPartInputCard(placeholder1: "Panjang", placeholder2: 70)
    }
}
