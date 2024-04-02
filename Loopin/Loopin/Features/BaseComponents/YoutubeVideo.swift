//
//  YoutubeVideo.swift
//  Loopin
//
//  Created by Celine Margaretha on 11/03/24.
//

import SwiftUI
import WebKit

struct YoutubeVideo: View {
    let id : String

    var body: some View {
        Video(videoId: id)
            .frame(width: 320, height: 190)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    YoutubeVideo(id: "3uEbkUmS29A")
}

// MARK: UIKit View Wrapper
struct Video : UIViewRepresentable {
    let videoId : String
    
    func makeUIView(context: Context) -> some WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}
