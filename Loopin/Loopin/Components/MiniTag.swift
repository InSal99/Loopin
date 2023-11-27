//
//  MiniTag.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 27/11/23.
//

import SwiftUI

struct MiniTag: View {
    let value: String
    
    var body: some View {
        Text(value)
            .font(.outfit(.regular, size: .label1))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("Peach"))
            }
    }
}

struct MiniTag_Previews: PreviewProvider {
    static var previews: some View {
        MiniTag(value: "Proyek")
    }
}
