//
//  ViewController.swift
//  NetworkingDemo
//
//  Created by Kaden Kim on 2020-05-14.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 1. url
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")!
        
        // 2. URLSession data task
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let string = String(data: data, encoding: .utf8) {
                print(string)
            }
        }
        
        // 3. resume
        task.resume()
    }

}
