//
//  ViewController.swift
//  NotificationDemo
//
//  Created by Kaden Kim on 2020-04-24.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var amountTextField: UITextField!
    
    // for Simulator
    var keyboardHalfHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.delegate = self
        
        // Add observers to NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tabGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tabGestureRecognizer)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        // change the view frame (y) (moves up)
        // 1. get the keyboard size (height)
        // 2. change view.frame.y
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height / 2
                // for Simulator
                keyboardHalfHeight = keyboardSize.height / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        // Works well on Physical device, but having a problem on Simulator
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y != 0 {
                view.frame.origin.y += keyboardSize.height / 2
            }
        }
        
        // Able to use below codes on Simulator
//        if view.frame.origin.y != 0 {
//            view.frame.origin.y += keyboardHalfHeight
//            // or blow code
//            // view.frame.origin.y = 0
//        }
    }
    
    @objc func dismissKeyboard(_ recognizer: UITapGestureRecognizer) {
        amountTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

