//
//  RepositoryManaging.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/2/22.
//

import Foundation

protocol RepositoryManaging {
    func fetchTopRepositories(pageNumber: Int, pageSize: Int, completion: @escaping (RepositoryResponse?) -> Void)
    func fetchContributors(repositoryName: String, pageNumber: Int, pageSize: Int, completion: @escaping ([Contributor]?) -> Void)
}
