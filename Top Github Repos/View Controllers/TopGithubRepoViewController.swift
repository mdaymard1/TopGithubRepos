//
//  ViewController.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/2/22.
//

import UIKit

class TopGithubRepoViewController: UITableViewController {

    @IBOutlet var indicatorView: UIActivityIndicatorView!

    private var viewModel: TopGithubRepoViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
        tableView.prefetchDataSource = self

        viewModel = TopGithubRepoViewModel(delegate: self)
        viewModel.getTopRepos()
        ProgressHUD.show()
    }

    private func setAppearance() {
        title = "Top 100 Github Repositories"
        navigationItem.clearBackButtonText()
    }

    private func launchContributorVC(for repository: Repository) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let contributorListVC = storyboard.instantiateViewController(withIdentifier: "GithubContributorListViewController") as! GithubContributorListViewController
        contributorListVC.setupRepository(repository)
        navigationController?.pushViewController(contributorListVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < viewModel.repositories.count, let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        let repository = viewModel.repositories[indexPath.row]
        cell.textLabel?.text = repository.url
        cell.detailTextLabel?.text = repository.description
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRepository = viewModel.repositories[indexPath.row]
        launchContributorVC(for: selectedRepository)
    }
}

extension TopGithubRepoViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if viewModel.areMoreRepositoriesNeeded(for: indexPaths) {
            ProgressHUD.show()
        }
    }
}

extension TopGithubRepoViewController: TopGithubRepoViewModelDelegate {
    func fetchCompleted(with indexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = indexPathsToReload else {
            tableView.reloadData()
            ProgressHUD.dismiss()
            return
        }
        tableView.beginUpdates()
        tableView.insertRows(at: newIndexPathsToReload, with: .automatic)
        tableView.endUpdates()
        ProgressHUD.dismiss()
    }
}
