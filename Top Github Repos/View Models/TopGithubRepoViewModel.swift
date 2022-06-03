//
//  TopGithubRepoViewModel.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/1/22.
//

import Foundation

protocol TopGithubRepoViewModelDelegate: AnyObject {
    func fetchCompleted(with indexPathsToReload: [IndexPath]?)
}

class TopGithubRepoViewModel {

    let maxRepositories = 100

    var repositories = [Repository]()
    var totalRepositories = 0

    private var repositoryManager: RepositoryManaging
    private var isFetching = false
    private var lastPageFetched = 0

    private var pageSize: Int {
        let defaultSize = 30
        let remainingRepositories = maxRepositories - repositories.count
        return remainingRepositories < defaultSize ? remainingRepositories : defaultSize
    }
    private weak var delegate: TopGithubRepoViewModelDelegate?

    init(delegate: TopGithubRepoViewModelDelegate, repositoryManager: RepositoryManaging? = nil) {
        self.delegate = delegate
        if let repositoryManager = repositoryManager {
            self.repositoryManager = repositoryManager
        } else {
            self.repositoryManager = RepositoryManager()
        }
    }

    func getTopRepos(pageNumber: Int = 1) {
        guard !isFetching else {
            return
        }
        isFetching = true
        repositoryManager.fetchTopRepositories(pageNumber: pageNumber, pageSize: pageSize) { [weak self] response in
            self?.isFetching = false
            if let response = response {
                self?.lastPageFetched = response.pageNumber
                self?.totalRepositories = response.totalCount
                self?.repositories += response.repositories
                if response.pageNumber > 1 {
                  let indexPathsToReload = self?.calculateIndexPathsToReload(from: response.repositories)
                    self?.delegate?.fetchCompleted(with: indexPathsToReload)
                } else {
                  self?.delegate?.fetchCompleted(with: .none)
                }
            }
        }
    }

    func areMoreRepositoriesNeeded(for indexPaths: [IndexPath]) -> Bool {
        guard repositories.count < maxRepositories else {
            return false
        }
        let numberOfReposFetched = lastPageFetched * pageSize
        for indexPath in indexPaths {
            /// If row coming into view is near the last fetched repo, request next page
            if indexPath.row + 10 > numberOfReposFetched {
                getTopRepos(pageNumber: lastPageFetched + 1)
                return true
            }
        }
        return false
    }

    private func calculateIndexPathsToReload(from newRepositories: [Repository]) -> [IndexPath] {
      let startIndex = repositories.count - newRepositories.count
      let endIndex = startIndex + newRepositories.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
