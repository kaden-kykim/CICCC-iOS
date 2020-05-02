//
//  AddTableViewController.swift
//  TableViewDemoCode
//
//  Created by Kaden Kim on 2020-05-01.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

protocol AddTableViewControllerDelegate: class {
    func add(student: String)
}

class AddTableViewController: UITableViewController {

    let addCell: AddTableViewCell = {
        let cell = AddTableViewCell()
        cell.accessoryType = .detailDisclosureButton
        return cell
    }()
    
    weak var delegate: AddTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNewStudent))
    }
    
    @objc func saveNewStudent(_ sender: UIBarButtonItem) {
        self.delegate?.add(student: addCell.nameTextField.text!)
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Student Name" : nil
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return addCell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print(#function)
    }
    
}
