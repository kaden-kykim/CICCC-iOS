//
//  ViewController.swift
//  Foodie
//
//  Created by Kaden Kim on 2020-05-20.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .systemFill
        
        navigationItem.title = "Foodie"
        navigationItem.largeTitleDisplayMode = .never
                
    }

}
