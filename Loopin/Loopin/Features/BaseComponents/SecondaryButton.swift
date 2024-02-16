//
//  SecondaryButton.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

import SwiftUI

struct SecondaryButton: View {
    let buttonText: String
    
    let font: Font = .outfit(.regular, size: .body3)
    let borderColor = Color("Guava")
    let backgroundColor = Color.white
    let textColor = Color("Black")
        
    var body: some View {
        
//        Button(action: {
//            action() // Call the provided action closure
//        }) {
//            HStack {
//                Spacer()
//                Text(buttonText)
//                    .font(font)
//                    .padding()
//                    .foregroundColor(textColor)
//                Spacer()
//            }
//            .frame(height: 68)
//            .overlay(
//                           RoundedRectangle(cornerRadius: 20)
//                            .stroke(borderColor, lineWidth: 2))
//        }
//        .background(backgroundColor)
//        .cornerRadius(20)
//        .padding(.horizontal)
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(borderColor, lineWidth: 1)
                        .frame(width: 358, height: 68)
            Text(buttonText)
                .font(font)
                .foregroundColor(textColor)
        }
    }
}


struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(buttonText: "button")
    }
}
