//
//  GithubContributorResponse.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/2/22.
//

import Foundation

struct GithubContributorResponse: Codable {
    let id: Int
    let url: String
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case url
        case avatarUrl = "avatar_url"
    }
}
