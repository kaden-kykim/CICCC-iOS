//
//  GrayViewController.swift
//  TrafficSegues
//
//  Created by Kaden Kim on 2020-04-20.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class GrayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "unwindToFirst" {
            
        }
        
        if let identifier = segue.identifier {
            switch identifier {
            case "unwindToRed":
                if let destinationVC = segue.destination as? ViewController {
                    destinationVC.navigationItem.title = "Popped Green"
                }
            case "GoToPurple":
//                if let destinationVC = segue.destination as? PurpleViewController {
                    // do the same as forward segue
//                }
                print("prepareForPurple")
            case "GoToOrange":
//                if let destinationVC = segue.destination as? OrangeViewController {
                    // do the same as forward segue
//                }
                print("prepareForOrange")
            default:
                fatalError("Wrong segue identifier")
            }
        }
    }
    
    @IBAction func purpleButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToPurple", sender: sender)
    }
    
    @IBAction func orangeButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToOrange", sender: sender)
    }
}
