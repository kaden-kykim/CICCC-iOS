//
//  SourceCell.swift
//  CoreDataDemo
//
//  Created by Kaden Kim on 2020-06-15.
//  Copyright © 2020 Kaden Kim. All rights reserved.
//

import UIKit

class SourceCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
