//
//  GithubContributorListViewController.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/2/22.
//

import UIKit
import SDWebImage

class GithubContributorListViewController: UITableViewController {

    private let cellName = "ContributorCell"
    private var viewModel: GithubContributorListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
        viewModel?.getContributors()
    }

    func setupRepository(_ repository: Repository) {
        viewModel = GithubContributorListViewModel(repository: repository, delegate: self)
    }

    private func setAppearance() {
        title = viewModel?.repository.url
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.contributors.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel, let cell = tableView.dequeueReusableCell(withIdentifier: cellName) else {
            return UITableViewCell()
        }
        let contributor = viewModel.contributors[indexPath.row]
        cell.imageView?.sd_setImage(with: URL(string: contributor.avatarUrl), placeholderImage: UIImage(systemName: "photo"))
        cell.textLabel?.text = contributor.url
        return cell
    }
}

extension GithubContributorListViewController: GithubContributorListViewModelDelegate {
    func fetchCompleted(with indexPathsToReload: [IndexPath]?) {
        tableView.reloadData()
    }
}
