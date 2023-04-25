//
//  PostsList.swift
//  redex
//
//  Created by mosta on 25/04/23.
//

import Foundation

struct PostsList {
    var posts = [Post]()
}

// MARK: - Decodable

extension PostsList: Decodable {
    enum CodingKeys: String, CodingKey {
        case posts = "children"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        posts = try data.decode([Post].self, forKey: .posts)
    }
}
