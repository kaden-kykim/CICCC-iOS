//
//  ViewController.swift
//  Hello
//
//  Created by Kaden Kim on 2020-04-14.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myButton: UIButton!
    let nameLabel: UILabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // initialize properties (subviews or view)

        // for example, set background color to red
        // view.backgroundColor = .red
        myButton.setTitle("YES!", for: .normal)
        
        view.addSubview(nameLabel)
        nameLabel.text = "Hello"
        nameLabel.backgroundColor = .green
        nameLabel.textAlignment = .center
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("Button tapped!")
    }
    
}
