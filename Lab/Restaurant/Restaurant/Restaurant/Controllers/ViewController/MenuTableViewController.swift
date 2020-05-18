//
//  MenuTableViewController.swift
//  Restaurant
//
//  Created by Kaden Kim on 2020-05-16.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    var category: String?
    
    private let categoryId = "category"
    private let cellId = "MenuCellIdentifier"
    private var menuItems = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: MenuController.menuDataUpdatedNotification, object: nil)
        updateUI()
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        guard let category = category else { return }
        coder.encode(category, forKey: categoryId)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        category = coder.decodeObject(forKey: categoryId) as? String
        updateUI()
    }
    
    @objc private func updateUI() {
        guard let category = category else { return }
        title = category.capitalized
        menuItems = MenuController.shared.items(forCategory: category) ?? []
        tableView.reloadData()
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
        MenuController.shared.fetchImage(url: menuItem.imageURL) {
            guard let image = $0 else { return }
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath { return }
                /// TODO: Below, resizing an image could be burden if there are too many entries
                cell.imageView?.image = image.resized(toWidth: cell.bounds.size.height)
                cell.setNeedsLayout()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuDetailSegue" {
            let menuItemDetailVC = segue.destination as! MenuItemDetailViewController
            menuItemDetailVC.menuItem = menuItems[tableView.indexPathForSelectedRow!.row]
        }
    }
    
}
