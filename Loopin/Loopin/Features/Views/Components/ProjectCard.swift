//
//  ProjectCard.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 24/12/23.
//

import SwiftUI

struct ProjectCard: View {
    let projectName: String
    let projectDesc: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(projectName)
                .font(.outfit(.semiBold, size: .body2))
            Text(projectDesc)
                .font(.outfit(.regular, size: .body2))
        }
        .padding(.horizontal)
        .foregroundColor(Color("Black"))
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color.white)
                .padding(.horizontal)
        )
        .shadow(color:.black .opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

struct ProjectCard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCard(projectName: "Project Name", projectDesc: "Project Description")
    }
}
