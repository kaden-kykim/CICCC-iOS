//
//  RegistrationTableViewController.swift
//  RegistrationForm
//
//  Created by Kaden Kim on 2020-05-11.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    private let cellId = "RegistrationCell"
    
    private var registrations = [Registration]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Registrations"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewRegistrationTVC(_:)))
        tableView.register(RegistrationTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    @objc func addNewRegistrationTVC(_ sender: UIBarButtonItem) {
        let addRegistrationTVC = AddRegistrationTableViewController(style: .grouped) // static table view
        let embedNav = UINavigationController(rootViewController: addRegistrationTVC)
        present(embedNav, animated: true, completion: nil) // modally (bottom up)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return registrations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RegistrationTableViewCell
        let registration = registrations[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = "\(registration.firstName) \(registration.lastName)"
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: registration.checkInDate)) - \(dateFormatter.string(from: registration.checkOutDate)): \(registration.roomType.name)"
        return cell
    }

}
