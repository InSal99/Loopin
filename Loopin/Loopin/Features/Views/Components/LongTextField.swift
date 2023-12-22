//
//  LongTextField.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct LongTextField: View {
    let placeholder:String
    
    let font: Font = .outfit(.regular, size: .body3)
    let backgroundColor = Color("Black").opacity(0.05)
    let textColor = Color("Black")
    
    // The @State Object
    @Binding var field: String
    
    var body: some View {
        TextField(placeholder, text: $field)
            .font(font)
            .padding()
            .frame(height: 197)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(textColor)
            .background(RoundedRectangle(cornerRadius: 20).fill(backgroundColor))
            .lineLimit(nil)
            .padding([.horizontal])
        
    }
}

struct LongTextField_Previews: PreviewProvider {
    static var previews: some View {
        LongTextField(placeholder: "placeholder", field: .constant("test"))
    }
}
