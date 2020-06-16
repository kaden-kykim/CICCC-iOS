//
//  NewsTableViewController.swift
//  CoreData
//
//  Created by Kaden Kim on 2020-06-15.
//  Copyright © 2020 Kaden Kim. All rights reserved.
//

import UIKit
import SafariServices

class NewsTableViewController: UITableViewController {

    private let cellId = "NewsCell"
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.delegate = self
        sc.searchBar.placeholder = "Search News"
        definesPresentationContext = true
        return sc
    }()
    
    private var articles: [[Article]] = [] {
        didSet {
            navigationItem.rightBarButtonItem?.isEnabled = articles.count > 0
        }
    }
    
    var searchText: String? {
        didSet {
            navigationItem.searchController?.searchBar.text = searchText
            navigationItem.searchController?.searchBar.searchTextField.resignFirstResponder()
            articles.removeAll()
            tableView.reloadData()
            searchForArticles()
            title = searchText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Breaking News"
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(NewsCell.self, forCellReuseIdentifier: cellId)
        let refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshController
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(sortBySources(_:)))
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem?.isEnabled = false
        
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        searchForArticles()
    }
    
    @objc func sortBySources(_ sender: UIBarButtonItem) {
        print("Go to SourcesVC")
    }
    
    private func searchForArticles() {
        guard let searchText = searchText else { return }
        NewsAPI.getTopHeadlines(with: searchText) { [weak self] (articles) in
            if let articles = articles?.articles {
                DispatchQueue.main.async {
                    if let diffs = self?.diffWithTheMostRecentArticles(articles) {
                        self?.articles.insert(diffs, at: 0)
                        self?.tableView.insertSections([0], with: .fade)
                    }
                    self?.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    private func diffWithTheMostRecentArticles(_ articles: [Article]) -> [Article] {
        if self.articles.count == 0 {
            return articles
        }
        return self.articles[self.articles.count - 1].difference(from: articles)
    }
    
    private func viewInSafari(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
}

// MARK: - Table view data source
extension NewsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewsCell
        cell.article = articles[indexPath.section][indexPath.row]
        cell.viewMorePressed = { [weak self] (url) in self?.viewInSafari(with: url) }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(searchText ?? "") \(articles.count - section)"
    }
}

extension NewsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            self.searchText = searchText
        }
    }
}
