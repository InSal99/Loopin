//
//  ProjectOverviewView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProjectOverviewView: View {
    let projectName: String
    let projectDescription: String
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .frame(width: 390)
                    .foregroundColor(Color("Peach"))
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: 600)
                        .offset(y: 120)
                        .foregroundColor(Color(.white))
                    VStack(alignment: .leading, spacing: 20) {
                        Spacer()
                        Text(projectName)
                            .font(.outfit(.semiBold, size: .heading3))
                        Text(projectDescription)
                            .font(.outfit(.regular, size: .body2))
                        Spacer()
                        NavigationLink {
                            ProjectInfoView()
                        } label: {
                            PrimaryButton(buttonText: "Buat Proyek")
                        }
                        
                    }
                    .padding()
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct ProjectOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOverviewView(projectName: "Lorem Ipsum", projectDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.  ")
    }
}
