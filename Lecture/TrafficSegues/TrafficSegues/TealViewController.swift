//
//  TealViewController.swift
//  TrafficSegues
//
//  Created by Kaden Kim on 2020-04-20.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class TealViewController: UIViewController {
    // dependency injection
    var user: User! // implicitly unwrapped optional ("There will be an user! 100%")

    @IBOutlet var userInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(user.name) is \(user.hobby)"
        userInfoLabel.text = "Name: \(user.name), Hobby: \(user.hobby)"
    }
}
