//
//  DetailTodoTableViewController.swift
//  SimpleTodoApp
//
//  Created by Kaden Kim on 2020-05-04.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class DetailTodoTableViewController: UITableViewController {
    
    @IBOutlet var priorityLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var completeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    private var titleStr: String!
    private var priorityStr: String!
    private var dateStr: String!
    private var completeStr: String!
    private var descriptionStr: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.titleStr
        priorityLabel.text = self.priorityStr
        dateLabel.text = self.dateStr
        completeLabel.text = self.completeStr
        descriptionLabel.text = self.descriptionStr
    }
    
    func setDetailItem(from todo: Todo) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        self.titleStr = todo.title
        self.priorityStr = { () -> String in
            switch todo.priority {
            case .high: return "High"
            case .medium: return "Medium"
            case .low: return "Low"
            }
        }()
        self.dateStr = dateFormatter.string(from: todo.deadline)
        self.completeStr = todo.isCompleted ? "Yes" : "No"
        self.descriptionStr = todo.todoDescription
    }

}
