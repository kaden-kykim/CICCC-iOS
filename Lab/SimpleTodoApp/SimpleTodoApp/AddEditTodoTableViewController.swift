//
//  AddEditTodoTableViewController.swift
//  SimpleTodoApp
//
//  Created by Kaden Kim on 2020-05-04.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class AddEditTodoTableViewController: UITableViewController, SetDateDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var prioritySegCtrl: UISegmentedControl!
    @IBOutlet var deadlineDateLabel: UILabel!
    @IBOutlet var completeSwitch: UISwitch!
    @IBOutlet var descriptionTextView: UITextView!
    
    @IBOutlet var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet var descriptionView: UIView!

    static let unwindSegueAddEditId = "addEditUnwind"
    
    var todo: Todo?
    var selectedIndexPath: IndexPath?
    var date: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
        
        if let todo = todo {
            navigationItem.title = "Edit Todo"
            rightBarButtonItem.title = "Edit"
            titleTextField.text = todo.title
            prioritySegCtrl.selectedSegmentIndex = todo.priority.rawValue
            date = todo.deadline
            completeSwitch.isOn = todo.isCompleted
            descriptionTextView.text = todo.todoDescription
        } else {
            navigationItem.title = "Add Todo"
            rightBarButtonItem.title = "Add"
            date = Calendar.current.startOfDay(for: Date()).addingTimeInterval(DAY_IN_SEC)
        }
        todo = nil
        
        deadlineDateLabel.isUserInteractionEnabled = true
        deadlineDateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.deadlineDateTapped(_:))))
        descriptionView.layer.cornerRadius = 8
        descriptionView.clipsToBounds = true
        descriptionView.layer.borderWidth = 1
        descriptionView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        
        updateDeadlineText()
        updateAddEditButtonState()
    }
    
    func setDate(date: Date) {
        self.date = date
        updateDeadlineText()
    }
    
    func updateAddEditButtonState() {
        rightBarButtonItem.isEnabled = !(titleTextField.text ?? "").isEmpty
    }
    
    func updateDeadlineText() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        deadlineDateLabel.text = dateFormatter.string(from: date)
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateAddEditButtonState()
    }
    
    @objc func deadlineDateTapped(_ sender: UITapGestureRecognizer) {
        let deadlinePickerVC = DeadlinePickerViewController()
        deadlinePickerVC.modalPresentationStyle = .custom
        deadlinePickerVC.delegate = self
        deadlinePickerVC.date = self.date
        dismissKeyboard()
        present(deadlinePickerVC, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        titleTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == AddEditTodoTableViewController.unwindSegueAddEditId else { return }
        todo = Todo(title: titleTextField.text ?? "", todoDescription: descriptionTextView.text, deadline: self.date,
                    priority: Priority.init(rawValue: prioritySegCtrl.selectedSegmentIndex) ?? .low, isCompleted: completeSwitch.isOn)
    }

}
