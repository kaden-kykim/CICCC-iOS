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
    @IBOutlet var tipPercentageSlider: UISlider!
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var totalAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tabGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tabGestureRecognizer)
    }
    
    @IBAction func adjustTipPercentage(_ sender: UISlider) {
        tipPercentageTextField.text = String(Int(sender.value))
        calculateTip()
    }
    
    func calculateTip() {
        if let amountText = billAmountTextField.text, let amount = Float(amountText), let tipPercentText = tipPercentageTextField.text, let tipPercent = Float(tipPercentText) {
            let tip = Float(amount) * (tipPercent / 100)
            tipAmountLabel.text = String.init(format: "$ %.2f", tip)
            totalAmountLabel.text = String.init(format: "$ %.2f", amount + tip)
        } else {
            tipAmountLabel.text = "$ 0.00"
            totalAmountLabel.text = "$ 0.00"
        }
    }
    
    @IBAction func changedAmount(_ sender: UITextField) {
        calculateTip()
    }
    
    @IBAction func changedTipPercentage(_ sender: UITextField) {
        if let tipPercentageText = tipPercentageTextField.text, let tipPercent = Float(tipPercentageText) {
            tipPercentageSlider.value = tipPercent
        } else {
            tipPercentageSlider.value = 0
        }
        calculateTip()
    }
    
    @IBAction func textFieldTapped(_ sender: UITextField) {
        DispatchQueue.main.async {
            let newPosition = sender.endOfDocument
            sender.selectedTextRange = sender.textRange(from: newPosition, to: newPosition)
        }
    }
    
    var keyboardHalfHeight: CGFloat = 0
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height / 2
                keyboardHalfHeight = keyboardSize.height / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y += keyboardHalfHeight
        }
    }
    
    @objc func dismissKeyboard(_ recognizer: UITapGestureRecognizer) {
        billAmountTextField.resignFirstResponder()
        tipPercentageTextField.resignFirstResponder()
    }
    
}
