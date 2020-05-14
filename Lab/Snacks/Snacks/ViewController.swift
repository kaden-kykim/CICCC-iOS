//
//  ViewController.swift
//  Snacks
//
//  Created by Kaden Kim on 2020-05-13.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private static let NAV_BAR_HEIGHT: CGFloat = 44
    private static let STAT_BAR_HEIGHT: CGFloat = 20
    
    private let navBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(red: CGFloat(0xDD / 255.0), green: CGFloat(0xDD / 255.0), blue: CGFloat(0xDD / 255.0), alpha: 1)
        view.heightAnchor.constraint(equalToConstant: UIDevice.current.hasNotch ? NAV_BAR_HEIGHT * 2 : NAV_BAR_HEIGHT + STAT_BAR_HEIGHT).isActive = true
        return view
    }()
    
    private let plusIconBarItem: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("＋", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: NAV_BAR_HEIGHT)
        btn.addTarget(self, action: #selector(plusItemTapped(_:)), for: .touchUpInside)
        btn.constraintWidth(equalToConstant: NAV_BAR_HEIGHT, heightEqualToConstant: NAV_BAR_HEIGHT)
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
