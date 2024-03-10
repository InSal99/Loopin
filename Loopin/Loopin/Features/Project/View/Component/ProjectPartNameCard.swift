//
//  ProjectPartNameCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 10/03/24.
//

import SwiftUI

struct ProjectPartNameCard: View {
    let subPart: SubPart
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 358, height: 50)
                .foregroundColor(Color.white)
            Text("\(subPart.name)")
                .font(.outfit(.medium, size: .body2))
                .padding(.horizontal)
        }
        .padding(.horizontal)

    }
}

#Preview {
    ProjectPartNameCard(subPart: SubPart(name: "name", steps: [], gauge: Gauges(length: 0, width: 0, stitch: 0, row: 0)))
}
