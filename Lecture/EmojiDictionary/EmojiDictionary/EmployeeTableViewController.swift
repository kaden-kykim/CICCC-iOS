//
//  EmployeeTableTableViewController.swift
//  EmojiDictionary
//
//  Created by Kaden Kim on 2020-04-29.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class EmployeeTableViewController: UITableViewController {
    
    private let cellId = "Name Cell"

    let names = ["Aaron", "Diego", "Naoki", "Richard",
                 "Kaden", "Andre", "Carlos", "Vlad",
                 "Yuka", "Mika", "Yusuke", "Shohei",
                 "Hotsuma", "Rick", "Wenda", "Daniel",
                 "Douglas"]
    let positions = ["Professional Clown", "Software Developer", "Designer", "Animal Trainer", "Uber Driver"]
    let images = ["Clown", "SoftwareDeveloper", "Designer", "AnimalTrainer", "UberDriver"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.detailTextLabel?.text = positions[indexPath.row % positions.count]
        return cell
    }

}
