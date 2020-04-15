//
//  ViewController.swift
//  IBBasics
//
//  Created by Kaden Kim on 2020-04-14.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myButton.setTitleColor(.red, for: .normal)
        
        let label = UILabel(frame: CGRect(x: 160, y: 160, width: 200, height: 44))
        label.text = "Hello IBBasics"
        view.addSubview(label)
    }

    @IBAction func buttonPressed(_ sender: Any) {
        print("The button was pressed")
    }
    
}

