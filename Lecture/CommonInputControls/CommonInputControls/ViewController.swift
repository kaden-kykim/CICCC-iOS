//
//  ViewController.swift
//  CommonInputControls
//
//  Created by Kaden Kim on 2020-04-17.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var toggle: UISwitch!
    @IBOutlet var slider: UISlider!
    @IBOutlet var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameField.resignFirstResponder()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("Button was tapped!")
        
        if toggle.isOn {
            print("Toggle on!")
        } else {
            print("Toggle off!")
        }
        print("The slider is set to \(slider.value)")
        print("The name is \(nameField.text!)")
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            print("The switch is on!")
        } else {
            print("The switch is off!")
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
    }
    
    @IBAction func keyboardReturnKeyTapped(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
        }
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
        }
    }
}

