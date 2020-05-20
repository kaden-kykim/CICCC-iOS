//
//  CategoryTableViewController.swift
//  Restaurant
//
//  Created by Kaden Kim on 2020-05-16.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    private let cellId = "CategoryCellIdentifier"
    private var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuController.shared.fetchCategories {
            if let categories = $0 {
                self.categories = categories
                self.updateUI(with: categories)
            }
        }
    }
    
    private func updateUI(with categories: [String]) {
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    private func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        cell.textLabel?.text = categories[indexPath.row].capitalized
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSegue" {
            let menuTVC = segue.destination as! MenuTableViewController
            menuTVC.category = categories[tableView.indexPathForSelectedRow!.row]
        }
    }
    
}
