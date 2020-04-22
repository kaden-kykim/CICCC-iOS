//
//  GoViewController.swift
//  RainbowTabs
//
//  Created by Kaden Kim on 2020-04-22.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class GoViewController: UIViewController {

    var color: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "from \(color ?? "Where?")"
    }
    
    @objc func goPrevViewController() {
        navigationController?.popViewController(animated: true)
    }
}
