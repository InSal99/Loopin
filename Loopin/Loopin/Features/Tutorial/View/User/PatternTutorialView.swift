//
//  PatternTutorialView.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 22/11/23.
//

import SwiftUI
import UIKit

struct PatternTutorialView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedImage: String? = nil
    @State private var showOverlay = false
    @State private var showAlert = false
    let pattern: Pattern
    
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
                VStack (spacing: 20) {
                    Spacer()
                    Spacer()
                    Spacer()
                    HStack(content: {
                        Image(pattern.symbol)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                        Text(pattern.abbreviation)
                            .font(.outfit(.medium, size: .heading2))
                            .padding(.horizontal, 20)
                    })
                    YoutubeVideo(id: pattern.link)
                    TabView {
                        ForEach(pattern.content, id: \.self) { contentItem in
                            VStack(spacing: 20) {
                                Image(contentItem.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300)
                                    .cornerRadius(30)
                                    .onTapGesture {
                                        selectedImage = contentItem.image
                                        showOverlay = true
                                    }
                                Text(contentItem.description)
                                    .font(.outfit(.regular, size: .body2))
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    .frame(maxWidth: 345, maxHeight: 700)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .background(Color("White"))
                    .onAppear {
                        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("Guava"))
                        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("Peach"))
                    }
                    Spacer()
                    Spacer()
                }
            }

            .navigationTitle(pattern.name)
            .navigationBarTitleDisplayMode(.inline)
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
        .overlay(
            ZStack {
                if let selectedImage = selectedImage {
                    Color.black.opacity(0.5)
                    Image(selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showOverlay = false
                        }
                }
            }
            .opacity(showOverlay ? 1 : 0)
            .animation(.easeInOut)
        )
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

struct PatternTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        PatternTutorialView(pattern: Pattern(name: "name", symbol: "test", abbreviation: "abb", link: "id", content: []))
    }
}
