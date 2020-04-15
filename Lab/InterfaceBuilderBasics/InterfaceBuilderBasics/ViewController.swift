//
//  ViewController.swift
//  InterfaceBuilderBasics
//
//  Created by Kaden Kim on 2020-04-14.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeTitle(_ sender: Any) {
        mainLabel.text = "This app rocks!"
    }
}
