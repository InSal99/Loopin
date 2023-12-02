//
//  LongTextField.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct LongTextField: View {
    let placeholder:String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 358, height: 197)
                .foregroundColor(Color("White"))
            Text(placeholder)
                .foregroundColor(Color("Black"))
                .padding()
                .font(.outfit(.regular, size: .body3))
                .opacity(0.5)
        }    }
}

struct LongTextField_Previews: PreviewProvider {
    static var previews: some View {
        LongTextField(placeholder: "placeholder")
    }
}
