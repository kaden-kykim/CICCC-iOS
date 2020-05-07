//
//  TodoTableViewCell.swift
//  SimpleTodoApp
//
//  Created by Kaden Kim on 2020-05-04.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var deadlineLabel: UILabel!
    @IBOutlet var priorityTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(with todo: Todo) {
        let attrTitleString: NSMutableAttributedString = NSMutableAttributedString(string: todo.title)
        let attrDescString: NSMutableAttributedString = NSMutableAttributedString(string: todo.todoDescription)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let attrDeadlineString: NSMutableAttributedString = NSMutableAttributedString(string: dateFormatter.string(from: todo.deadline))
        let attrPriorityString: NSMutableAttributedString = NSMutableAttributedString(string: todo.priority.string().uppercased())
        if todo.isCompleted {
            attrTitleString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attrTitleString.length))
            attrTitleString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGray, range: NSMakeRange(0, attrTitleString.length))
            attrDeadlineString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGray, range: NSMakeRange(0, attrDeadlineString.length))
            priorityTextLabel.isHidden = true
        } else {
            attrDeadlineString.addAttribute(NSAttributedString.Key.foregroundColor,
                                            value: Date() < todo.deadline ? UIColor.systemBlue : UIColor.systemRed, range: NSMakeRange(0, attrDeadlineString.length))
            attrPriorityString.addAttribute(NSAttributedString.Key.foregroundColor,
                                            value: todo.priority == .high ? UIColor.label : (todo.priority == .medium ? UIColor.systemGray : UIColor.systemGray2),
                                            range: NSMakeRange(0, attrPriorityString.length))
        }
        titleLabel.attributedText = attrTitleString
        descLabel.attributedText = attrDescString
        deadlineLabel.attributedText = attrDeadlineString
        priorityTextLabel.attributedText = attrPriorityString
    }
}
