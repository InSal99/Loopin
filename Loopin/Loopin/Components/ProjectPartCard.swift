//
//  ProjectPartCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProjectPartCard: View {
    let placeholder1: String
    let placeholder2: Int
    let placeholder3: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 358, height: 90)
                .foregroundColor(Color.white)
            VStack(alignment: .leading) {
                Text("nama bagian")
                    .font(.outfit(.medium, size: .body2))
                HStack {
                    Text(placeholder1)
                        .font(.outfit(.ligth, size: .body2))
                    Spacer()
                    Text("\(placeholder2) row")
                        .font(.outfit(.regular, size: .body2))
                        .multilineTextAlignment(.trailing)
                    Text("\(placeholder3) cm")
                        .font(.outfit(.regular, size: .body2))
                        .multilineTextAlignment(.trailing)
                        .frame(width: 61)
                }
                HStack {
                    Text(placeholder1)
                        .font(.outfit(.ligth, size: .body2))
                    Spacer()
                    Text("\(placeholder2) st")
                        .font(.outfit(.regular, size: .body2))
                        .multilineTextAlignment(.trailing)
                    Text("\(placeholder3) cm")
                        .font(.outfit(.regular, size: .body2))
                        .multilineTextAlignment(.trailing)
                        .frame(width: 61)
                }
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

struct ProjectPartCard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPartCard(placeholder1: "lorem ipsum", placeholder2: 70, placeholder3: 30)
    }
}
