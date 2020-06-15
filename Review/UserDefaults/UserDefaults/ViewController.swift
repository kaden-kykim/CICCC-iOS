//
//  ViewController.swift
//  UserDefaults
//
//  Created by Kaden Kim on 2020-06-14.
//  Copyright © 2020 Kaden Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bluetoothSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "switch") != nil {
            bluetoothSwitch.isOn = defaults.bool(forKey: "switch")
        }
    }

    @IBAction func saveSwitchState(_ sender: UISwitch) {
        // save the state of the switch
        // -> "UserDefaults"
        
        // 1. get the userDefaults object
        let defaults = UserDefaults.standard
        
        // 2. save the state
        defaults.set(sender.isOn, forKey: "switch")
    }
    
}

