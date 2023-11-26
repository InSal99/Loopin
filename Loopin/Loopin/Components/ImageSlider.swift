//
//  ImageSlider.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ImageSlider: View {
    var images: [String]
    
    var body: some View {
        TabView {
            ForEach(images, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea()
        .overlay(
            HStack(spacing: 8) {
                ForEach(0..<images.count, id: \.self) { page in
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.white)
                }
            }
                .padding(.top, 220)
        )
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        ImageSlider(images: ["test","test"])
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
