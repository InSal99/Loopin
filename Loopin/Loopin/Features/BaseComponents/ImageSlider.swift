//
//  ImageSlider.swift
//  Loopin
//
//  Created by Intan Saliya Utomo on 21/11/23.
//

import SwiftUI

struct ImageSlider: View {
    @State private var currentPage = 0
    var images: [String]

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(images.indices, id: \.self) { index in
                Image(images[index])
                    .resizable()
                    .scaledToFill()
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea()
        .overlay(
            PageControl(numberOfPages: images.count, currentPage: $currentPage)
                .padding(.top, 220)
        )
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("Guava"))
            UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("Peach"))
        }
    }
}

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int

    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
        return pageControl
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}


struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        ImageSlider(images: ["test","test"])
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
