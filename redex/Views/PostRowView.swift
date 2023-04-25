//
//  PostRowView.swift
//  redex
//
//  Created by mosta on 24/04/23.
//

import SwiftUI

struct PostRowView: View {
    
    @Binding var post: Post
    
    var body: some View {
        HStack() {
            Image(systemName: "photo.fill")
                .font(.largeTitle)
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.headline)
                Text(post.subredditNamePrefixed)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
    }
}

struct PostRowView_Previews: PreviewProvider {
    
    static let post = Post(
        id: "001",
        title: "Fantastic beasts movie",
        author: "Author",
        url: "",
        subredditNamePrefixed: "r/all")
    
    static var previews: some View {
        PostRowView(post: .constant(post))
            .previewDisplayName("Post Row")
            .previewLayout(.fixed(width: 400, height: 70))
    }
}
