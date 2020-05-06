//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Kaden Kim on 2020-05-06.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func shareButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func safariButtonTapped(_ sender: UIButton) {
        // 1. url
        if let url = URL(string: "https://www.google.ca") {
            // 2. create safari view controller
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func camaraButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        
    }
    
}
