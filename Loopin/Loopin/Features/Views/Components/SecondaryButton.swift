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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("Guava"), lineWidth: 1)
                        .frame(width: 358, height: 68)
            Text(buttonText)
                .font(.outfit(.medium, size: .body1))
                .foregroundColor(Color("Black"))
        }
    }
}


struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(buttonText: "button")
    }
}
