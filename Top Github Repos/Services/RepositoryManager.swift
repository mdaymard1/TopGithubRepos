//
//  RepositoryManager.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/2/22.
//

import Foundation

struct RepositoryManager: RepositoryManaging {

    let githubBasePath = "https://api.github.com/"
    let searchPath = "search/repositories"
    let reposPath = "repos/"
    let contributorsPath = "/contributors"

    func fetchTopRepositories(pageNumber: Int, pageSize: Int, completion: @escaping (RepositoryResponse?) -> Void) {

        let networkRequestManager = NetworkRequestManager()
        let requestPath = githubBasePath + searchPath

        networkRequestManager.sendRequest(requestPath: requestPath,
                                          requestMethod: .get,
                                          headers: nil,
                                          queryParams: ["q": "stars:>0",
                                                        "per_page": pageSize,
                                                        "page": pageNumber],
                                          body: nil,
                                          responseModel: GithubRepositoryResponse.self) { response in
            
            DispatchQueue.main.async {
                switch response {
                case .success(let repositoryReponse):
                    var repositories = [Repository]()
                    for gitRepository in repositoryReponse.items {
                        let repository = Repository(id: gitRepository.id, fullName: gitRepository.fullName, url: gitRepository.url, description: gitRepository.description)
                        repositories.append(repository)
                    }
                    completion(RepositoryResponse(totalCount: repositoryReponse.totalCount, pageNumber: pageNumber, repositories: repositories))
                case .failure(let error):
                    print("An error was returned while fetching the top git repositories: \(error)")
                    completion(nil)
                }
            }
        }
    }

    func fetchContributors(repositoryName: String, pageNumber: Int, pageSize: Int, completion: @escaping ([Contributor]?) -> Void) {
        let networkRequestManager = NetworkRequestManager()
        let requestPath = githubBasePath + reposPath + repositoryName + contributorsPath

        networkRequestManager.sendRequest(requestPath: requestPath,
                                          requestMethod: .get,
                                          headers: nil,
                                          queryParams: nil,
                                          body: nil,
                                          responseModel: [GithubContributorResponse].self) { response in

            DispatchQueue.main.async {
                switch response {
                case .success(let contributorReponses):
                    var contributors = [Contributor]()
                    for contributorResponse in contributorReponses {
                        let contributor = Contributor(id: contributorResponse.id, url: contributorResponse.url, avatarUrl: contributorResponse.avatarUrl)
                        contributors.append(contributor)
                    }
                    completion(contributors)
                case .failure(let error):
                    print("An error was returned while fetching the top git contributors: \(error)")
                    completion(nil)
                }
            }
        }
    }

}
