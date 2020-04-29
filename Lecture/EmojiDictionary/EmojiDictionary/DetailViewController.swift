//
//  DetailViewController.swift
//  EmojiDictionary
//
//  Created by Kaden Kim on 2020-04-29.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var idImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    
    var employee: Employee!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idImageView.image = UIImage(named: employee.image)
        nameLabel.text = employee.name
        positionLabel.text = employee.position
    }

}
