//
//  StudentsTableViewController.swift
//  TableViewDemoCode
//
//  Created by Kaden Kim on 2020-05-01.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController, AddTableViewControllerDelegate {
    
    struct CellIdentifier {
        static let add = "AddCell"
        static let student = "StudentsCell"
    }
    
    private let cellId = "StudentsCell"
    
    private var students = ["Derrick", "Aaron", "Daniel", "Hotsuma", "Rick", "Kaden", "Naoki", "Mika"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Students"
        tableView.register(StudentTableViewCell.self, forCellReuseIdentifier: CellIdentifier.student)
        tableView.register(AddTableViewCell.self, forCellReuseIdentifier: CellIdentifier.add)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAddStudent))
    }
    
    func add(student: String) {
        students.append(student)
        tableView.insertRows(at: [IndexPath(row: students.count - 1, section: 0)], with: .automatic)
    }
    
    @objc func goToAddStudent(_ sender: UIBarButtonItem) {
        let addVC = AddTableViewController(style: .grouped)
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    // MARK: - table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! StudentTableViewCell
        cell.textLabel?.text = students[indexPath.row]
        return cell
    }
    
    // MARK: - table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.name = students[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
