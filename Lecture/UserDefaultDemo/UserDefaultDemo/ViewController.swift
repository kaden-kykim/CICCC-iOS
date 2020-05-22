//
//  ViewController.swift
//  UserDefaultDemo
//
//  Created by Kaden Kim on 2020-05-22.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var bluetoothSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if defaults.object(forKey: Constants.UserDefalut.bluetoothSwitch) != nil {
            bluetoothSwitch.isOn = defaults.bool(forKey: Constants.UserDefalut.bluetoothSwitch)
        }
        
    }

    @IBAction func saveSwitchState(_ sender: UISwitch) {
        // save the state of switch
        // -> "UserDefault"
        
        // 1. get the userDefaults object
        let defaults = UserDefaults.standard
        
        // 2. save the state
        defaults.set(sender.isOn, forKey: Constants.UserDefalut.bluetoothSwitch)
    }
    
}
