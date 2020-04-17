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
    
    let moneyButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .blue
        btn.setTitle("😛", for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(moneyButton)
        moneyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        moneyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64).isActive = true
        moneyButton.addTarget(self, action: #selector(moneyButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapRecognized))
        view.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panRecognized))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func tapRecognized(_ recognizer: UITapGestureRecognizer) {
        print("Tap Recognized!")
    }
    
    @objc func panRecognized(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .changed:
            print(recognizer.translation(in: view))
        default:
            break;
        }
    }
    
    @objc func moneyButtonTapped(_ sender: UIButton) {
        print("Get money 💰")
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

