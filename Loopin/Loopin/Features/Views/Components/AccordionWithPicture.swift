//
//  AccordionWithPicture.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 11/01/24.
//

import SwiftUI

struct AccordionWithPicture: View {
    @State var isOpened: Bool = true
    let step: Step
    let multiplier: Int
    
    var body: some View {
        
        if step.guidances.isEmpty {
            let num = step.nums * multiplier
            Button {
            } label: {
                HStack() {
                    Text(step.text.replacingOccurrences(of: "#", with: "\(num)"))
                        .font(.outfit(.semiBold, size: .body2))
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, 15)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.05)
                        .frame(width: 342, height: 44)
                )
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            }
            .foregroundColor(Color("Black"))
            .disabled(true)
        } else {
            Button {
                withAnimation(.spring()) {
                    isOpened.toggle()
                }
            } label: {
                if !isOpened {
                    HStack() {
                        Text(step.text.replacingOccurrences(of: "#", with: "\(step.nums * multiplier)"))
                            .font(.outfit(.semiBold, size: .body2))
                            .multilineTextAlignment(.leading)
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
                            Text(step.text.replacingOccurrences(of: "#", with: "\(step.nums * multiplier)"))
                                .font(.outfit(.semiBold, size: .body2))
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        ScrollView(.horizontal) {
                            HStack() {
                                ForEach(step.guidances.indices) { item in
                                    SquareCard(cardText: "\(item + 1)", cardImage: step.guidances[item])
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
