//
//  ViewController.swift
//  UIViewDemo
//
//  Created by Kaden Kim on 2020-04-16.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let redView: UIView = {
       let rView = UIView()
        rView.backgroundColor = .red
        rView.translatesAutoresizingMaskIntoConstraints = false
        return rView
    }()
    
    let profileIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "van")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("frame (\(redView.frame.origin.x), \(redView.frame.origin.y))")
//        print("bounds (\(redView.bounds.origin.x), \(redView.bounds.origin.y))")
//        print(redView.bounds.size.width)
        
        let width = view.bounds.size.width * 0.7
        redView.widthAnchor.constraint(equalToConstant: width).isActive = true
        redView.heightAnchor.constraint(equalToConstant: width).isActive = true
        profileIV.widthAnchor.constraint(equalToConstant: width).isActive = true
        profileIV.heightAnchor.constraint(equalToConstant: width).isActive = true
        
        let vStackView = UIStackView(arrangedSubviews: [redView, profileIV])
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.distribution = .equalSpacing
        vStackView.alignment = .center
        vStackView.spacing = 20
        
        view.addSubview(vStackView)
        vStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        vStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }


}

