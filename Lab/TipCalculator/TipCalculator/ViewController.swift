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
    @IBOutlet var tipPercentageTextField: UITextField!
    @IBOutlet var tipAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func calculateTip(_ sender: UIButton) {
        if let amountText = billAmountTextField.text, let amount = Float(amountText), let tipPercentText = tipPercentageTextField.text, let tipPercent = Float(tipPercentText) {
            let tip = Float(amount) * (tipPercent / 100)
            tipAmountLabel.text = String.init(format: "%.2f", tip)
        }
    }
}
