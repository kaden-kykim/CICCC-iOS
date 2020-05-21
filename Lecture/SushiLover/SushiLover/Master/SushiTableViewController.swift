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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Navigation title view
        let titleImageView = UIImageView(image: UIImage(named: "banner"))
        titleImageView.contentMode = .scaleAspectFill
        titleImageView.constraintWidth(equalToConstant: 150, heightEqualToConstant: 33)
        navigationItem.titleView = titleImageView
        
        /// Table view
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: cellId)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sushis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SubtitleCell
        let sushi = sushis[indexPath.row]
        cell.textLabel?.text = sushi.name
        cell.detailTextLabel?.text = sushi.category.rawValue
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sushiDetailVC = SushiDetailViewController()
        sushiDetailVC.sushi = sushis[indexPath.row]
        navigationController?.pushViewController(sushiDetailVC, animated: true)
    }
}


