//
//  Button.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 20/11/23.
//

import SwiftUI

struct PrimaryButton: View {
    let buttonText: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 358, height: 68)
                .foregroundColor(Color("Guava"))
            Text(buttonText)
                .font(.outfit(.medium, size: .body1))
                .foregroundColor(.white)
        }
    }
}


struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(buttonText: "button")
    }
}
