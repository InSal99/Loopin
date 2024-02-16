//
//  Accordion.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 23/12/23.
//

import SwiftUI

struct Accordion: View {
    @State var isOpened: Bool = false
    let title: String
    let content: String
    
    var body: some View {
        Button {
            withAnimation(.spring()) {
                            isOpened.toggle()
                        }
        } label: {
            if !isOpened {
                HStack() {
                    Text(title)
                    .font(.outfit(.semiBold, size: .body2))
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding(.horizontal, 15)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.05)
                        .frame(width: 342, height: 44)
                )
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            } else {
                VStack(alignment: .leading) {
                    HStack() {
                        Text(title)
                        .font(.outfit(.semiBold, size: .body2))
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    Text(content)
                        .font(.outfit(.regular, size: .body2))
                        .frame(alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.05)
                        .frame(width: 342)
                )
                .padding(.horizontal, 16)
            }
        }
        .foregroundColor(Color("Black"))
    }
}

struct Accordion_Previews: PreviewProvider {
    static var previews: some View {
        Accordion(isOpened: false, title: "Title", content: "Content")
    }
}
