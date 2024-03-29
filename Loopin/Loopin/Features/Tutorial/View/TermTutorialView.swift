//
//  TermTutorialView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 22/11/23.
//

import SwiftUI

struct TermTutorialView: View {
    @Environment(\.presentationMode) var presentationMode
    let term: Term
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                ZStack(alignment: .top) {
                    Image(term.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 390, maxHeight: 290)
                    RoundedRectangle(cornerRadius: 30)
                        .frame(minHeight: 571)
                        .foregroundColor(Color(.white))
                        .padding(.top, 273)
                    VStack(alignment: .leading, spacing: 20) {
                        Text(term.title)
                            .font(.outfit(.semiBold, size: .heading3))
                        Text(term.content)
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

struct TermTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TermTutorialView(term: Term(title: "title", content: "content", image: "test"))
    }
}
