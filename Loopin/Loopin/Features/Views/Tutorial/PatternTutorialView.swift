//
//  PatternTutorialView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 22/11/23.
//

import SwiftUI

struct PatternTutorialView: View {
    @Environment(\.presentationMode) var presentationMode
    let title: String = "Hakpen"
    let content: String =  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos."
    let images = ["test", "test"]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                ZStack(alignment: .top) {
                    ImageSlider(images: images)
                        .frame(maxWidth: 390, maxHeight: 290)
                    RoundedRectangle(cornerRadius: 30)
                        .frame(minHeight: 571)
                        .foregroundColor(Color(.white))
                        .padding(.top, 273)
                    VStack(alignment: .leading, spacing: 20) {
                        Text(title)
                            .font(.outfit(.semiBold, size: .heading3))
                        Text(content)
                            .font(.outfit(.regular, size: .body2))
                    }
                    .padding(.top, 300)
                    .padding()
                }
            }
            .ignoresSafeArea()
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

struct PatternTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        PatternTutorialView()
    }
}
