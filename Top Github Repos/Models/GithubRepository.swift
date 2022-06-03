//
//  GithubRepository.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/2/22.
//

import Foundation

struct GithubRepository: Codable {
    let id: Int
    let fullName: String
    let url: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case url
        case description
    }
}
