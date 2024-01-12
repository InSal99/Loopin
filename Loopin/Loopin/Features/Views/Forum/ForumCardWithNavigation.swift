//
//  ForumCardWithNavigation.swift
//  Loopin
//
//  Created by Celine Margaretha on 13/01/24.
//

import SwiftUI

struct ForumCardWithNavigation: View {
    @StateObject var postViewModel: PostViewModel
    
    var body: some View {
        NavigationLink {
            CommentView(postViewModel: postViewModel)
        } label: {
            ForumCard(postViewModel: postViewModel)
        }
    }
}
