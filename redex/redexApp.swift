//
//  redexApp.swift
//  redex
//
//  Created by mosta on 24/04/23.
//

import SwiftUI

@main
struct redexApp: App {
    var body: some Scene {
        WindowGroup {
            PostsListView(postsListViewModel: PostsListViewModel())
        }
    }
}
