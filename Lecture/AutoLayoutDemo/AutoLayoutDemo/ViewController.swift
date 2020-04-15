//
//  ViewController.swift
//  AutoLayoutDemo
//
//  Created by Kaden Kim on 2020-04-15.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let w = view.bounds.size.width / 3
        let btn1 = UIButton()
        btn1.setTitle("Let's Go", for: .normal)
        btn1.backgroundColor = .red
        btn1.translatesAutoresizingMaskIntoConstraints = false
        btn1.widthAnchor.constraint(equalToConstant: w).isActive = true
        
        let btn2 = UIButton()
        btn2.setTitle("Bye", for: .normal)
        btn2.backgroundColor = .green
        btn2.translatesAutoresizingMaskIntoConstraints = false
        btn2.widthAnchor.constraint(equalToConstant: w).isActive = true
        
        let vStackView = UIStackView(arrangedSubviews: [btn1, btn2])
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        vStackView.alignment = .center
        vStackView.spacing = 30
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(vStackView)
        
        vStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //        btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        //        btn.topAnchor.constraint(equalTo: view.topAnchor, constant: 350).isActive = true
        //        btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
        //        btn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350).isActive = true
    }
    
    
}

