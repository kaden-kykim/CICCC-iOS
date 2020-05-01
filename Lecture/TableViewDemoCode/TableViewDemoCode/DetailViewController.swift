//
//  DetailViewController.swift
//  TableViewDemoCode
//
//  Created by Kaden Kim on 2020-05-01.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var name: String! {
        didSet {
            updateUI(name)
        }
    }
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 50)
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func updateUI(_ name: String) {
        navigationItem.title = name
        nameLabel.text = name
    }
    
}
