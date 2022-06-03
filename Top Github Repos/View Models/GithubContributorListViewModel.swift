//
//  GithubContributorListViewModel.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/2/22.
//

import Foundation

protocol GithubContributorListViewModelDelegate: AnyObject {
    func fetchCompleted(with indexPathsToReload: [IndexPath]?)
}

class GithubContributorListViewModel {

    var contributors = [Contributor]()
    var repository: Repository

    private var repositoryManager: RepositoryManaging
    private weak var delegate: GithubContributorListViewModelDelegate?

    init(repository: Repository, delegate: GithubContributorListViewModelDelegate, repositoryManager: RepositoryManaging? = nil) {
        self.repository = repository
        self.delegate = delegate
        if let repositoryManager = repositoryManager {
            self.repositoryManager = repositoryManager
        } else {
            self.repositoryManager = RepositoryManager()
        }
    }

    func getContributors() {
        repositoryManager.fetchContributors(repositoryName: repository.fullName, pageNumber: 1, pageSize: 30) { [weak self] contributors in
            if let contributors = contributors {
                self?.contributors = contributors
                self?.delegate?.fetchCompleted(with: .none)
            }
        }
    }

}
