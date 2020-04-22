//
//  SubViewController.swift
//  UINavigationController
//
//  Created by Kaden Kim on 2020-04-22.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rightButton = UIBarButtonItem()
        rightButton.title = "Doorway"
        rightButton.target = self
        rightButton.action = #selector(gotoDoorway(_:))
        self.navigationItem.setRightBarButton(rightButton, animated: false)
    }
    
    @IBAction func gotoDoorway(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToDoorway", sender: self)
    }
    
}
