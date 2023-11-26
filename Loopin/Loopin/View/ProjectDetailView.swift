//
//  ProjectDetailView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ProjectDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let projectDescription:String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. "
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 25) {
                    Text(projectDescription)
                        .font(.outfit(.regular, size: .body2))
                        .padding(.horizontal)
                    VStack(spacing: 10) {
                        DetailProjectCard(placeholder1: "Jenis Benang", placeolder2: "Katun")
                        DetailProjectCard(placeholder1: "Ketebalan Benang", placeolder2: "Worsted")
                        DetailProjectCard(placeholder1: "Ukuran Hakpen", placeolder2: "5")
                        DetailProjectCard(placeholder1: "Jenis Tusukan", placeolder2: "Single Crochet")
                    }
                    Text("Bagian Proyek")
                        .font(.outfit(.semiBold, size: .body3))
                        .padding(.horizontal)
                    VStack(spacing: 10) {
                        ForEach(1...5, id: \.self) { item in
                            ProjectPartCard(placeholder1: "Panjang", placeholder2: 70, placeholder3: 10)
                        }
                    }
                    NavigationLink {
                        //ongoing project
                    } label: {
                        PrimaryButton(buttonText: "Mulai Proyek")
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color("White"))
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationTitle("Detail Proyek")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ProjectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDetailView()
    }
}
