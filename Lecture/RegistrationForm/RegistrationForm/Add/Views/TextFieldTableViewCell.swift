//
//  TextFieldTableViewCell.swift
//  RegistrationForm
//
//  Created by Kaden Kim on 2020-05-11.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    private let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var textStr: String? {
        return textField.text
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(placeholder: String) {
        self.init()
        textField.placeholder = placeholder
        contentView.addSubview(textField)
        textField.matchParent(padding: .init(top: 5, left: 16, bottom: 5, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
