//
//  AccordionWithPicture.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 11/01/24.
//

import SwiftUI

struct AccordionWithPicture: View {
    @State var isOpened: Bool = true
    let title: String
    let content: [String]
    
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
                    ScrollView(.horizontal) {
                        HStack() {
                            ForEach(content.indices) { item in
                                SquareCard(cardText: "\(item + 1)", cardImage: content[item])
                            }
                        }
                    }
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

//#Preview {
//    AccordionWithPicture(title: "title", content: ["content"])
//}
