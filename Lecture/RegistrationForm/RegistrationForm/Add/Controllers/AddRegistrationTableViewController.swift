//
//  AddRegistrationTableViewController.swift
//  RegistrationForm
//
//  Created by Kaden Kim on 2020-05-11.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    
    private let firstNameCell = TextFieldTableViewCell(placeholder: "First Name")
    private let lastNameCell = TextFieldTableViewCell(placeholder: "Last name")
    private let emailNameCell = TextFieldTableViewCell(placeholder: "E-mail")
    
    private let checkInCell = RightDetailTableViewCell(title: "Check-In Date")
    private let checkOutCell = RightDetailTableViewCell(title: "Check-Out Date")
    private let checkInDatePickerCell = DatePickerTableViewCell()
    private let checkOutDatePickerCell = DatePickerTableViewCell()
    
    private var isCheckInDatePickerShown: Bool = false {
        didSet { checkInDatePickerCell.datePicker.isHidden = !isCheckInDatePickerShown }
    }
    private var isCheckOutDatePickerShown: Bool = false {
        didSet { checkOutDatePickerCell.datePicker.isHidden = !isCheckOutDatePickerShown }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Registrations"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped(_:)))
        checkInDatePickerCell.datePickerValueChanged = { [unowned self] in
            self.updateDateViews()
        }
        checkOutDatePickerCell.datePickerValueChanged = { [weak self] in
            self?.updateDateViews()
        }
        updateDateViews()
    }
    
    private func updateDateViews() {
        checkInDatePickerCell.datePicker.minimumDate = Date()
        checkOutDatePickerCell.datePicker.minimumDate = checkInDatePickerCell.datePicker.date.addingTimeInterval(86400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        checkInCell.detailTextLabel?.text = dateFormatter.string(from: checkInDatePickerCell.datePicker.date)
        checkOutCell.detailTextLabel?.text = dateFormatter.string(from: checkOutDatePickerCell.datePicker.date)
    }

    @objc func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneTapped(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 4
        case 2:
            return 2
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            return firstNameCell
        case (0, 1):
            return lastNameCell
        case (0, 2):
            return emailNameCell
        case (1, 0):
            return checkInCell
        case (1, 1):
            return checkInDatePickerCell
        case (1, 2):
            return checkOutCell
        case (1, 3):
            return checkOutDatePickerCell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (1, 1):
            return isCheckInDatePickerShown ? 216 : 0
        case (1, 3):
            return isCheckOutDatePickerShown ? 216 : 0
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (1, 0):
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else {
                isCheckInDatePickerShown = true
            }
        case (1, 2):
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
        default:
            break
        }
        // Update the table view with a pair of beginUpdates and endUpdates calls.
        // These calls tell the table view to re-query its attributes - including cell height
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    deinit {
        print("\(String(describing: type(of: self))) \(#function)")
    }

}
