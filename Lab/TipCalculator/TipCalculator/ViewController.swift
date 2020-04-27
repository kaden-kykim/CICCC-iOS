//
//  ViewController.swift
//  TipCalculator
//
//  Created by Kaden Kim on 2020-04-27.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var billAmountTextField: UITextField!
    @IBOutlet var tipAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateTip(_ sender: UIButton) {
        if let amountText = billAmountTextField.text, let amount = Float(amountText) {
            let tip = Float(amount) * 0.15
            tipAmountLabel.text = String(tip)
        }
    }
}
