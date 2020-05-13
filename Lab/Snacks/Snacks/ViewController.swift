//
//  ViewController.swift
//  Snacks
//
//  Created by Kaden Kim on 2020-05-13.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let navBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(red: CGFloat(0xDD / 255.0), green: CGFloat(0xDD / 255.0), blue: CGFloat(0xDD / 255.0), alpha: 1)
        view.heightAnchor.constraint(equalToConstant: UIDevice.current.hasNotch ? 88 : 64).isActive = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(navBar)
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

}
