//
//  ContentView.swift
//  redex
//
//  Created by mosta on 24/04/23.
//

import SwiftUI

struct PostsListView: View {
    @ObservedObject var postsListViewModel: PostsListViewModel
    
    @State private var query = "all"
    @State private var subredditTitle = "r/all"
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search subReddit", text: $query) {
                    subredditTitle = "r/\(query.lowercased())"
                    postsListViewModel.getPosts(for: query)
                }
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .padding()
                
                List {
                    ForEach($postsListViewModel.posts) { $post in
                        NavigationLink(destination: WebView(request: URLRequest(url: URL(string: post.url)!))) {
                            PostRowView(post: $post)
                        }
                    }
                    .alignmentGuide(
                        .listRowSeparatorLeading
                    ) { dimensions in
                        0
                    }
                }
                .listStyle(.plain)
                .navigationTitle(subredditTitle)
            }
        }
        .onAppear {
            print("DBG >>> requesting posts")
            postsListViewModel.getPosts(for: query)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PostsListView(postsListViewModel: PostsListViewModel())
            .previewDisplayName("Posts list")
    }
}
