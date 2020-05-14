//
//  ViewController.swift
//  Snacks
//
//  Created by Kaden Kim on 2020-05-13.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let navBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(red: CGFloat(0xDD / 255.0), green: CGFloat(0xDD / 255.0), blue: CGFloat(0xDD / 255.0), alpha: 1)
        view.heightAnchor.constraint(equalToConstant: UIDevice.current.hasNotch ? 88 : 64).isActive = true
        return view
    }()
    
    private let plusIconBarItem: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("＋", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        btn.addTarget(self, action: #selector(plusItemTapped(_:)), for: .touchUpInside)
        btn.constraintWidth(equalToConstant: 44, heightEqualToConstant: 44)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(navBar)
        navBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navBar.addSubview(plusIconBarItem)
        plusIconBarItem.bottomAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        plusIconBarItem.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -5).isActive = true
    }
    
    @objc func plusItemTapped(_ sender: UIButton) {
        print("plus icon pressed")
    }
    
}
