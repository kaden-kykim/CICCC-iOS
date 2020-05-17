//
//  MenuTableViewController.swift
//  Restaurant
//
//  Created by Kaden Kim on 2020-05-16.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    var category: String!
    
    private let cellId = "MenuCellIdentifier"
    private var menuItems = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.capitalized
        MenuController.shared.fetchMenuItems(forCategory: category) {
            if let menuItems = $0 {
                self.menuItems = menuItems
                self.updateUI(with: menuItems)
            }
        }
    }
    
    private func updateUI(with menuItems: [MenuItem]) {
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    private func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$ %.2f", menuItem.price)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuDetailSegue" {
            let menuItemDetailVC = segue.destination as! MenuItemDetailViewController
            menuItemDetailVC.menuItem = menuItems[tableView.indexPathForSelectedRow!.row]
        }
    }
    
}
