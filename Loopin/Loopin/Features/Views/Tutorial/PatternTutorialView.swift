//
//  PatternTutorialView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 22/11/23.
//

import SwiftUI

struct PatternTutorialView: View {
    @Environment(\.presentationMode) var presentationMode
    let pattern: Pattern
    
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            ZStack (alignment: .center){
                Rectangle()
                    .fill(Color("Peach"))
                    .ignoresSafeArea()
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: 750)
                    .offset(y: 40)
                    .foregroundColor(Color("White"))
                VStack (spacing: 30) {
                    Spacer()
                    Spacer()
                    Spacer()
                    HStack(content: {
                        Image("test")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                        Text("abb")
                            .font(.outfit(.medium, size: .heading2))
                            .padding(.horizontal, 20)
                    })
                    TabView {
                        ForEach(1...3, id: \.self) { content in
                            VStack (spacing: 50) {
                                Image("test")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300)
                                    .cornerRadius(30)
                                Text("lorem ipsum")
                                    .font(.outfit(.regular, size: .body2))
                            }
                        }
                    }
                    .frame(maxWidth: 345, maxHeight: 800)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .background(Color("White"))
                    Spacer()
                    Spacer()
                }
            }
            .navigationTitle(pattern.name)
            .navigationBarTitleDisplayMode(.inline)
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
        PatternTutorialView(pattern: Pattern(name: "name", symbol: "test", abbreviation: "abb", content: []))
    }
}
