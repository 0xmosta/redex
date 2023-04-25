//
//  PostsListViewModel.swift
//  redex
//
//  Created by mosta on 24/04/23.
//

import Foundation
import Combine

class PostsListViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var subreddit = "r/all"
    @Published var posts: [Post] = []
    
    init() { }
    
    func getPosts(for query: String) {
        fetchPosts(for: query)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Error >>> \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] list in
                print("DBG >>> List \(list)")
                self?.posts = list.posts
            }
            .store(in: &cancellables)
    }
    
    private func fetchPosts(for query: String) -> AnyPublisher<PostsList, Error> {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: "https://www.reddit.com/\(trimmedQuery.count == 0 ? "" : "r/\(trimmedQuery)").json") else {
            preconditionFailure("Failed to construct search URL for query: \(query)")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            }
            .map({ $0.data })
            .decode(type: PostsList.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
