//
//  RepositoryResponse.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/2/22.
//

import Foundation

struct RepositoryResponse {
    let totalCount: Int
    let pageNumber: Int
    let repositories: [Repository]
}
