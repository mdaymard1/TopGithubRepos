//
//  GithubRepositoryResponse.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/2/22.
//

import Foundation

struct GithubRepositoryResponse: Codable {
    let totalCount: Int
    let items: [GithubRepository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
