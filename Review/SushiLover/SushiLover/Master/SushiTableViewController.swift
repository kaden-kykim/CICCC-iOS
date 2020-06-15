//
//  SushiTableViewController.swift
//  SushiLover
//
//  Created by Derrick Park on 5/20/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit

class SushiTableViewController: UITableViewController {
    private let cellId = "SushiCell"
    private var sushis: [Sushi] = Sushi.sushis()
    private var filteredSushis: [Sushi] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isSearchbarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchbarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Navigation title view
        let titleImageView = UIImageView(image: UIImage(named: "banner"))
        titleImageView.contentMode = .scaleAspectFill
        titleImageView.constraintWidth(equalToConstant: 150, heightEqualToConstant: 33)
        navigationItem.titleView = titleImageView
        
        /// Table view
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: cellId)
        
        /// Search Controller
        setupSearchController()
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Sushi"
        // ensure that the search bar doesn't remain on the screen if the user navigates to another view controller
        // while the UISearchController is active
        definesPresentationContext = true
    }
    
    private func filterSushiFor(searchText: String, category: Sushi.Category? = nil) {
        filteredSushis = sushis.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredSushis.count : sushis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SubtitleCell
        let sushi = isFiltering ? filteredSushis[indexPath.row] : sushis[indexPath.row]
        cell.textLabel?.text = sushi.name
        cell.detailTextLabel?.text = sushi.category.rawValue
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sushiDetailVC = SushiDetailViewController()
        sushiDetailVC.sushi = isFiltering ? filteredSushis[indexPath.row] : sushis[indexPath.row]
        navigationController?.pushViewController(sushiDetailVC, animated: true)
    }
}

extension SushiTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterSushiFor(searchText: searchBar.text!)
    }
}
