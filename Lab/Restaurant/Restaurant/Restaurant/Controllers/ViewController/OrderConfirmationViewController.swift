//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Kaden Kim on 2020-05-16.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    @IBOutlet var timeRemainingLabel: UILabel!
    
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes"
    }
    
}
