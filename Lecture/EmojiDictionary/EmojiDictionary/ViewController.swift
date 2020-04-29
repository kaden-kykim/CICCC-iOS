//
//  ViewController.swift
//  EmojiDictionary
//
//  Created by Kaden Kim on 2020-04-29.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

struct Employee {
    let image: String
    let name: String
    let position: String
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
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
        // data source - data
        tableView.dataSource = self
        // delegate - action
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. ask for the cell (dequeue some resuable cell for me)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.detailTextLabel?.text = positions[indexPath.row % positions.count]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(names[indexPath.row])
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "Detail" {
            let destVC = segue.destination as! DetailViewController
            // where did we select?
            if let indexPath = tableView.indexPathForSelectedRow {
                destVC.employee = Employee(image: images[indexPath.row % positions.count], name: names[indexPath.row], position: positions[indexPath.row % positions.count])
            }
        }
    }

}
