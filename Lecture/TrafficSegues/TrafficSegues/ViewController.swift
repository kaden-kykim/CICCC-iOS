//
//  ViewController.swift
//  TrafficSegues
//
//  Created by Kaden Kim on 2020-04-20.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

struct User {
    let name: String
    let hobby: String
}

class ViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var hobbyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // this method gets called right before the segue happens
        
        // Below line: For the double-checking and practice ID
        if let identifier = segue.identifier, identifier == "Teal" {
            if let destinationVC = segue.destination as? TealViewController {
                destinationVC.navigationItem.title = nameTextField.text
                let user = User(name: nameTextField.text!, hobby: hobbyTextField.text!)
                destinationVC.user = user
            }
        }
    }
    
    @IBAction func unwindToFirst(unwindSegue: UIStoryboardSegue) {
        print("Unwind to First")
    }
}

