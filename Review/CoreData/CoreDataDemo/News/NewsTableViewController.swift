//
//  NewsTableViewController.swift
//  CoreData
//
//  Created by Kaden Kim on 2020-06-15.
//  Copyright © 2020 Kaden Kim. All rights reserved.
//

import UIKit
import SafariServices
import CoreData

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
    
    var container: NSPersistentContainer!
    
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
        let sourcesTVC = SourcesTableViewController(container)
        sourcesTVC.searchText = searchText
        self.navigationController?.pushViewController(sourcesTVC, animated: true)
    }
    
    private func searchForArticles() {
        guard let searchText = searchText else {
            refreshControl?.endRefreshing()
            return
        }
        NewsAPI.getTopHeadlines(with: searchText) { [weak self] (articles) in
            if let articles = articles?.articles {
                DispatchQueue.main.async {
                    if let diffs = self?.diffWithTheMostRecentArticles(articles) {
                        self?.articles.insert(diffs, at: 0)
                        self?.tableView.insertSections([0], with: .fade)
                        self?.updateDatabase(with: diffs, for: searchText)
                    }
                    self?.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    private func updateDatabase(with articles: [Article], for searchText: String) {
        container.performBackgroundTask { [weak self] context in
            for article in articles {
                _ = try? ManagedArticle.findOrCreateArticle(matching: article, with: searchText, in: context)
            }
            try? context.save()
            self?.printDatabaseStatistics()
        }
    }
    
    private func printDatabaseStatistics() {
        let context = container.viewContext // viewContext == main context on main thread (queue)
        context.perform { // better be sure this is executed on main thread
            if Thread.isMainThread {
                print("on main thread")
            } else {
                print("off main thread")
            }
            
            if let articleCount = (try? context.fetch(ManagedArticle.fetchRequest()))?.count {
                print("\(articleCount) articles")
            }
            // a better way to count ... context.count(for: )
            if let sourceCount = try? context.count(for: ManagedSource.fetchRequest()) {
                print("\(sourceCount) sources")
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NewsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            self.searchText = searchText
        }
    }
}
