//
//  BlueViewController.swift
//  RainbowTabs
//
//  Created by Kaden Kim on 2020-04-22.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {

    let centerBtn = CenterButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(centerBtn)
        centerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
