//
//  Numbering.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 23/12/23.
//

import SwiftUI

struct Numbering: View {
    let number: String
    let content: String
    
    var body: some View {
        HStack(spacing: 30) {
            Text(number)
                .font(.outfit(.semiBold, size: .body2))
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .frame(minWidth: 40, minHeight: 40)
                        .foregroundColor(Color("Black"))
                        .opacity(0.05)
                )
            Text(content)
                .font(.outfit(.regular, size: .body2))
        }
        .padding(.horizontal)
    }
}

struct Numbering_Previews: PreviewProvider {
    static var previews: some View {
        Numbering(number: "0", content: "Content")
    }
}
