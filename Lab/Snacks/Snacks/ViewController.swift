//
//  ViewController.swift
//  Snacks
//
//  Created by Kaden Kim on 2020-05-13.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let STAT_BAR_HEIGHT: CGFloat = 20
    private let NAV_BAR_HEIGHT: CGFloat = 44
    private let NAV_BAR_EXT_HEIGHT: CGFloat = 200
    
    private let hasNotch = UIDevice.current.hasNotch
    private var navHeight: CGFloat = 0
    
    private let navBar: UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: CGFloat(0xDD / 255.0), green: CGFloat(0xDD / 255.0), blue: CGFloat(0xDD / 255.0), alpha: 1)
        return view
    }()
    
    private let plusIconBarItem: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("＋", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.addTarget(self, action: #selector(plusItemTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navHeight = hasNotch ? NAV_BAR_HEIGHT * 2 : NAV_BAR_HEIGHT + STAT_BAR_HEIGHT
        view.addSubview(navBar)
        navBar.frame = .init(x: 0, y: 0, width: view.frame.size.width, height: navHeight)
        navBar.addSubview(plusIconBarItem)
        plusIconBarItem.titleLabel?.font = UIFont.systemFont(ofSize: NAV_BAR_HEIGHT)
        plusIconBarItem.constraintWidth(equalToConstant: NAV_BAR_HEIGHT, heightEqualToConstant: NAV_BAR_HEIGHT)
        plusIconBarItem.topAnchor.constraint(equalTo: navBar.topAnchor, constant: hasNotch ? NAV_BAR_HEIGHT : STAT_BAR_HEIGHT).isActive = true
        plusIconBarItem.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -5).isActive = true
    }
    
    let rotation45DTransform = CGAffineTransform(rotationAngle: .pi / 4)
    @objc func plusItemTapped(_ sender: UIButton) {
        if navBar.frame.size.height < NAV_BAR_EXT_HEIGHT {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.NAV_BAR_EXT_HEIGHT)
                self.plusIconBarItem.transform = self.rotation45DTransform
            })
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.navHeight)
                self.plusIconBarItem.transform = .identity
            })
        }
    }
    
}
