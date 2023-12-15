//
//  TextField.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct ShortTextField: View {
    let placeholder:String
    
    let font: Font = .outfit(.regular, size: .body3)
    let backgroundColor = Color("Black").opacity(0.05)
    let textColor = Color("Black")
    
    // The @State Object
    @Binding var field: String
    
    var body: some View {
        if placeholder.contains("password"){
            SecureField(placeholder, text: $field)
                .font(font)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(backgroundColor))
                .foregroundColor(textColor)
                .frame(height: 55)
                .padding([.horizontal])
        } else {
            TextField(placeholder, text: $field)
                .font(font)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(backgroundColor))
                .foregroundColor(textColor)
                .frame(height: 55)
                .padding([.horizontal])
        }
    }
    
}

struct ShortTextField_Previews: PreviewProvider {
    static var previews: some View {
        ShortTextField(placeholder: "placeholder", field: .constant(""))
    }
}
