//
//  AccordionWithPicture.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 11/01/24.
//

import SwiftUI

struct AccordionWithPicture: View {
    @State var isOpened: Bool = false
    let step: Step
    let multiplier: Int
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
                Button {
                    withAnimation(.spring()) {
                        isOpened.toggle()
                    }
                } label: {
                    HStack() {
                        Text(step.text.replacingOccurrences(of: "#", with: "\(step.nums * multiplier)"))
                            .font(.outfit(.semiBold, size: .body2))
                            .multilineTextAlignment(.leading)
                        
                        if !step.guidances.isEmpty {
                            Spacer()
                            Image(systemName: isOpened ? "chevron.down": "chevron.right")
                        }
                    }
                }
                .disabled(step.guidances.isEmpty ? true : false)
                
                if !isOpened {
                    ScrollView(.horizontal) {
                        HStack() {
                            ForEach(step.guidances.indices) { item in
                                SquareCard(cardText: "\(item + 1)", cardImage: step.guidances[item])
                            }
                        }
                    }
                }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .opacity(0.05)
                .frame(width: UIScreen.main.bounds.width - 20)
                .frame(minHeight: 10)
        )
        .foregroundColor(Color("Black"))
        
    }
}

//struct AccordionWithPicture_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            AccordionWithPicture(step: Step(text: "", nums: 0, isStitch: true), title: "title", content: ["content"])
//            AccordionWithPicture(step: Step(text: "", nums: 0, isStitch: true), title: "title", content: ["content"])
//
//               }
////        AccordionWithPicture(title: "title", content: ["content"])
//    }
//}

//#Preview {
//    AccordionWithPicture(title: "title", content: ["content"])
//}
