//
//  Button.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct PrimaryButton: View {
    let buttonText: String
    
    let font: Font = .outfit(.regular, size: .body3)
    let backgroundColor = Color("Guava")
    let textColor = Color.white
    
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
//        }
//        .background(backgroundColor)
//        .cornerRadius(20)
//        .padding(.horizontal)
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 358, height: 68)
                .foregroundColor(backgroundColor)
            Text(buttonText)
                .font(font)
                .foregroundColor(textColor)
        }
        
    }
}


struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(buttonText: "button")
    }
}
