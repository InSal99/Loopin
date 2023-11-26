//
//  TextField.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct ShortTextField: View {
    let placeholder:String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 358, height: 55)
                .foregroundColor(Color("White"))
            Text(placeholder)
                .foregroundColor(Color("Black"))
                .padding(.horizontal)
                .font(.outfit(.regular, size: .body3))
                .opacity(0.5)
        }
    }
}

struct ShortTextField_Previews: PreviewProvider {
    static var previews: some View {
        ShortTextField(placeholder: "placeholder")
    }
}
