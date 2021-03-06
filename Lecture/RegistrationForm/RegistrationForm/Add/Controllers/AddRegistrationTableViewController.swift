//
//  AddRegistrationTableViewController.swift
//  RegistrationForm
//
//  Created by Kaden Kim on 2020-05-11.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    
    private let firstNameCell = TextFieldTableViewCell(placeholder: "First Name")
    private let lastNameCell = TextFieldTableViewCell(placeholder: "Last name")
    private let emailNameCell = TextFieldTableViewCell(placeholder: "E-mail")
    
    private let checkInCell = RightDetailTableViewCell(title: "Check-In Date")
    private let checkOutCell = RightDetailTableViewCell(title: "Check-Out Date")
    private let checkInDatePickerCell = DatePickerTableViewCell()
    private let checkOutDatePickerCell = DatePickerTableViewCell()
    
    private let adultGuestCell = StepperTableViewCell(guestType: "Adults")
    private let childGuestCell = StepperTableViewCell(guestType: "Children")
    
    private let wifiCell = SwitchTableViewCell(category: "Wi-Fi (per day)", price: Registration.wifiCost)
    
    private let roomTypeCell: RightDetailTableViewCell = {
        let cell = RightDetailTableViewCell(title: "Room Type")
        cell.accessoryType = .disclosureIndicator
        return cell
    }()
    
    private var isCheckInDatePickerShown: Bool = false {
        didSet { checkInDatePickerCell.datePicker.isHidden = !isCheckInDatePickerShown }
    }
    private var isCheckOutDatePickerShown: Bool = false {
        didSet { checkOutDatePickerCell.datePicker.isHidden = !isCheckOutDatePickerShown }
    }
    
    private var roomType: RoomType?
    
    var addRegistration: ((Registration) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Guest Registration"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped(_:)))
        checkInDatePickerCell.datePickerValueChanged = { [unowned self] in
            self.updateDateViews()
        }
        checkOutDatePickerCell.datePickerValueChanged = { [weak self] in
            self?.updateDateViews()
        }
        updateDateViews()
        updateRoomType()
    }
    
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    private func updateRoomType() {
        if let roomType = self.roomType {
            roomTypeCell.detailTextLabel?.text = roomType.name
        } else {
            roomTypeCell.detailTextLabel?.text = "Not Set"
        }
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
        guard let roomType = roomType else {
            roomTypeCell.detailTextLabel?.textColor = .red
            return
        }
        
        let firstName = firstNameCell.textStr ?? ""
        let lastName = lastNameCell.textStr ?? ""
        let email = emailNameCell.textStr ?? ""
        let checkInDate = checkInDatePickerCell.datePicker.date
        let checkOutDate = checkOutDatePickerCell.datePicker.date
        let adults = adultGuestCell.getNumberOfGuests
        let children = childGuestCell.getNumberOfGuests
        let hasWifi = wifiCell.isOn
        
        let registration = Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate,
                                        numberOfAdults: adults, numberOfChildren: children, roomType: roomType, wifi: hasWifi)
        addRegistration?(registration)
        dismiss(animated: true, completion: nil)
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
        case (2, 0):
            return adultGuestCell
        case (2, 1):
            return childGuestCell
        case (3, 0):
            return wifiCell
        case (4, 0):
            return roomTypeCell
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
            isCheckInDatePickerShown = !isCheckInDatePickerShown
            isCheckOutDatePickerShown = false
        case (1, 2):
            isCheckOutDatePickerShown = !isCheckOutDatePickerShown
            isCheckInDatePickerShown = false
        case (4, 0):
            let selectRoomTVC = SelectRoomTypeTableViewController()
            selectRoomTVC.delegate = self
            selectRoomTVC.roomType = roomType
            navigationController?.pushViewController(selectRoomTVC, animated: true)
        default:
            break
        }
        // Update the table view with a pair of beginUpdates and endUpdates calls.
        // These calls tell the table view to re-query its attributes - including cell height
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    //    deinit { print("\(String(describing: type(of: self))) \(#function)" }
    
}
