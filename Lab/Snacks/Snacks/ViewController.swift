//
//  ViewController.swift
//  Snacks
//
//  Created by Kaden Kim on 2020-05-13.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private static let STAT_BAR_HEIGHT: CGFloat = 20
    private static let NAV_BAR_HEIGHT: CGFloat = 44
    private static let NAV_BAR_EXT_HEIGHT: CGFloat = 200
    
    private let hasNotch = UIDevice.current.hasNotch
    private var navHeight: CGFloat = 0
    
    private var navNormalHeightConstraint: NSLayoutConstraint!
    private var navExtHeightConstraint: NSLayoutConstraint!
    
    private let navBar: UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: CGFloat(0xDD / 255.0), green: CGFloat(0xDD / 255.0), blue: CGFloat(0xDD / 255.0), alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let plusIconBarItem: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("＋", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: NAV_BAR_HEIGHT)
        btn.constraintWidth(equalToConstant: NAV_BAR_HEIGHT, heightEqualToConstant: NAV_BAR_HEIGHT)
        btn.addTarget(self, action: #selector(plusItemTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let snackImages: HorizontalStackView = {
        let hsv = HorizontalStackView(arrangedSubviews: [
            UIImageView(image: UIImage(named: "oreos")),
            UIImageView(image: UIImage(named: "pizza_pockets")),
            UIImageView(image: UIImage(named: "pop_tarts")),
            UIImageView(image: UIImage(named: "popsicle")),
            UIImageView(image: UIImage(named: "ramen"))
        ], spacing: 5, alignment: .fill, distribution: .fillEqually)
        hsv.translatesAutoresizingMaskIntoConstraints = false
        hsv.isHidden = true
        return hsv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navHeight = hasNotch ? ViewController.NAV_BAR_HEIGHT * 2 : ViewController.NAV_BAR_HEIGHT + ViewController.STAT_BAR_HEIGHT
        
        navNormalHeightConstraint = navBar.heightAnchor.constraint(equalToConstant: navHeight)
        navExtHeightConstraint = navBar.heightAnchor.constraint(equalToConstant: ViewController.NAV_BAR_EXT_HEIGHT)
        
        view.addSubview(navBar)
        navBar.constraintWidth(equalToConstant: view.frame.size.width)
        navNormalHeightConstraint.isActive = true
        navBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        navBar.addSubview(plusIconBarItem)
        plusIconBarItem.topAnchor.constraint(equalTo: navBar.topAnchor, constant: hasNotch ? ViewController.NAV_BAR_HEIGHT : ViewController.STAT_BAR_HEIGHT).isActive = true
        plusIconBarItem.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -5).isActive = true
        
        navBar.addSubview(snackImages)
        snackImages.widthAnchor.constraint(equalTo: navBar.widthAnchor, constant: -10).isActive = true
        snackImages.heightAnchor.constraint(equalToConstant: ViewController.NAV_BAR_EXT_HEIGHT - navHeight).isActive = true
        snackImages.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 5).isActive = true
        snackImages.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -5).isActive = true
    }
    
    private let rotation45DTransform = CGAffineTransform(rotationAngle: .pi / 4)
    @objc func plusItemTapped(_ sender: UIButton) {
        if navBar.frame.size.height < ViewController.NAV_BAR_EXT_HEIGHT {
            self.snackImages.isHidden = false
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.navNormalHeightConstraint.isActive = false
                self.navExtHeightConstraint.isActive = true
                self.view.layoutIfNeeded()
                self.plusIconBarItem.transform = self.rotation45DTransform
            })
        } else {
            self.snackImages.isHidden = true
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.navExtHeightConstraint.isActive = false
                self.navNormalHeightConstraint.isActive = true
                self.view.layoutIfNeeded()
                self.plusIconBarItem.transform = .identity
            })
        }
    }
    
}
