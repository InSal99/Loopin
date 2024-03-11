//
//  ProjectPartInputCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProjectPartInputCard: View {
    let subPart: SubPart
    
    @Binding var inputWidth: String
    @Binding var inputLength: String
    
    let placeholder:String = "..."
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 358, height: 105)
                .foregroundColor(Color("White"))
            VStack(alignment: .leading) {
                Text(subPart.name)
                    .font(.outfit(.medium, size: .body2))
                HStack {
                    Text("Panjang")
                        .font(.outfit(.ligth, size: .body2))
                    Spacer()
                    HStack {
                        TextField(placeholder, text: $inputLength)
                            .font(.outfit(.regular, size: .body2))
                            .frame(maxWidth: 52)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: inputLength) { newValue in
                                /// Update the inputLength binding with the converted integer value
                                inputLength = String(Double(newValue) ?? 0)
                            }
                        Text("cm")
                            .font(.outfit(.regular, size: .body2))
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing, 13)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .foregroundColor(.white)
                    )
                }
                HStack {
                    Text("Lebar")
                        .font(.outfit(.ligth, size: .body2))
                    Spacer()
                    HStack {
                        TextField(placeholder, text: $inputWidth)
                            .font(.outfit(.regular, size: .body2))
                            .frame(maxWidth: 52)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: inputWidth) { newValue in
                                // Update the inputWidth binding with the converted integer value
                                inputWidth = String(Double(newValue) ?? 0)
                            }
                        Text("cm")
                            .font(.outfit(.regular, size: .body2))
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing, 13)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .foregroundColor(.white)
                    )
                }
                
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

struct ProjectPartInputCard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPartInputCard(subPart: SubPart(name: "name", steps: [], gauge: Gauges(length: 0, width: 0, stitch: 0, row: 0)), inputWidth: .constant(""), inputLength: .constant(""))
    }
}
