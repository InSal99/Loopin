//
//  ProjectPartCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProjectPartCard: View {
    let subPart: SubPart
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 358, height: 90)
                .foregroundColor(Color.white)
            VStack(alignment: .leading) {
                Text("\(subPart.name)")
                    .font(.outfit(.medium, size: .body2))
                HStack {
                    Text("Lebar")
                        .font(.outfit(.ligth, size: .body2))
                    Spacer()
                    Text("\(Int(subPart.gauge.stitch)) st")
                        .font(.outfit(.regular, size: .body2))
                        .multilineTextAlignment(.trailing)
                    Text("\(Int(subPart.gauge.width)) cm")
                        .font(.outfit(.regular, size: .body2))
                        .multilineTextAlignment(.trailing)
                        .frame(width: 61)
                }
                HStack {
                    Text("Panjang")
                        .font(.outfit(.ligth, size: .body2))
                    Spacer()
                    Text("\(Int(subPart.gauge.row)) row")
                        .font(.outfit(.regular, size: .body2))
                        .multilineTextAlignment(.trailing)
                    Text("\(Int(subPart.gauge.length)) cm")
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
        ProjectPartCard(subPart: SubPart(name: "name", steps: [], gauge: Gauges(length: 0, width: 0, stitch: 0, row: 0)))
    }
}
