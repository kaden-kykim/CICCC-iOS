//
//  SubtitleCell.swift
//  SushiLover
//
//  Created by Derrick Park on 5/21/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit

class SubtitleCell: UITableViewCell {
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    textLabel?.textColor = .darkGray
    detailTextLabel?.textColor = .mainRed
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}
