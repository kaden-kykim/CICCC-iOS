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
    private lazy var navHeight: CGFloat = hasNotch ? NAV_BAR_HEIGHT * 2 : NAV_BAR_HEIGHT + STAT_BAR_HEIGHT
    private var navNormalHeightConstraint: NSLayoutConstraint!
    private var navExtHeightConstraint: NSLayoutConstraint!
    private var navTitleNormalPosition: NSLayoutConstraint!
    private var navTitleExtPosition: NSLayoutConstraint!
    
    private let navBar: UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: CGFloat(0xDD / 255.0), green: CGFloat(0xDD / 255.0), blue: CGFloat(0xDD / 255.0), alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var navBarTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SNACKS"
        return label
    }()
    
    private lazy var plusIconBarItem: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("＋", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: NAV_BAR_HEIGHT)
        btn.addTarget(self, action: #selector(plusItemTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let snackImageViews = [
        UIImageView(image: UIImage(named: "oreos")),
        UIImageView(image: UIImage(named: "pizza_pockets")),
        UIImageView(image: UIImage(named: "pop_tarts")),
        UIImageView(image: UIImage(named: "popsicle")),
        UIImageView(image: UIImage(named: "ramen"))
    ]
    private lazy var snackImages: HorizontalStackView = {
        for imgView in snackImageViews {
            imgView.isUserInteractionEnabled = true
            imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(snackImageTapped(_:))))
        }
        
        let hsv = HorizontalStackView(arrangedSubviews: snackImageViews, spacing: 5, alignment: .fill, distribution: .fillEqually)
        hsv.translatesAutoresizingMaskIntoConstraints = false
        hsv.isHidden = true
        return hsv
    }()
    
    private let snackCellId = "SnackCell"
    private var snacks = [String]()
    private let snackListTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navNormalHeightConstraint = navBar.heightAnchor.constraint(equalToConstant: navHeight)
        navExtHeightConstraint = navBar.heightAnchor.constraint(equalToConstant: NAV_BAR_EXT_HEIGHT)
        navTitleNormalPosition = navBarTitle.centerYAnchor.constraint(equalTo: navBar.centerYAnchor, constant: hasNotch ? 20 : 10)
        navTitleExtPosition = navBarTitle.centerYAnchor.constraint(equalTo: navBar.centerYAnchor, constant: hasNotch ? -30 : -60)
        
        view.addSubview(navBar)
        navBar.constraintWidth(equalToConstant: view.frame.size.width)
        navNormalHeightConstraint.isActive = true
        navBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        navBar.addSubview(plusIconBarItem)
        plusIconBarItem.topAnchor.constraint(equalTo: navBar.topAnchor, constant: hasNotch ? NAV_BAR_HEIGHT : STAT_BAR_HEIGHT).isActive = true
        plusIconBarItem.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -5).isActive = true
        plusIconBarItem.constraintWidth(equalToConstant: NAV_BAR_HEIGHT, heightEqualToConstant: NAV_BAR_HEIGHT)
        
        navBar.addSubview(navBarTitle)
        navBarTitle.centerXAnchor.constraint(equalTo: navBar.centerXAnchor).isActive = true
        navTitleNormalPosition.isActive = true
        
        navBar.addSubview(snackImages)
        snackImages.widthAnchor.constraint(equalTo: navBar.widthAnchor, constant: -10).isActive = true
        snackImages.heightAnchor.constraint(equalToConstant: NAV_BAR_EXT_HEIGHT - navHeight - 5).isActive = true
        snackImages.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 5).isActive = true
        snackImages.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -5).isActive = true
        
        view.addSubview(snackListTableView)
        snackListTableView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        snackListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        snackListTableView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        snackListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        snackListTableView.dataSource = self
        snackListTableView.register(UITableViewCell.self, forCellReuseIdentifier: snackCellId)
    }
    
    private let rotation45DTransform = CGAffineTransform(rotationAngle: .pi / 4)
    @objc private func plusItemTapped(_ sender: UIButton) {
        if navBar.frame.size.height < NAV_BAR_EXT_HEIGHT {
            self.snackImages.isHidden = false
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.navNormalHeightConstraint.isActive = false
                self.navExtHeightConstraint.isActive = true
                self.navTitleNormalPosition.isActive = false
                self.navTitleExtPosition.isActive = true
                self.view.layoutIfNeeded()
                self.plusIconBarItem.transform = self.rotation45DTransform
                self.navBarTitle.text = "Add a SNACK"
            })
        } else {
            self.snackImages.isHidden = true
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.navExtHeightConstraint.isActive = false
                self.navNormalHeightConstraint.isActive = true
                self.navTitleExtPosition.isActive = false
                self.navTitleNormalPosition.isActive = true
                self.view.layoutIfNeeded()
                self.plusIconBarItem.transform = .identity
                self.navBarTitle.text = "SNACKS"
            })
        }
    }
    
    @objc private func snackImageTapped(_ recognizer: UITapGestureRecognizer) {
        if recognizer.view == snackImageViews[0] {
            snacks.insert("Oreos", at: 0)
        } else if recognizer.view == snackImageViews[1] {
            snacks.insert("Pizza Pockets", at: 0)
        } else if recognizer.view == snackImageViews[2] {
            snacks.insert("Pop Tarts", at: 0)
        } else if recognizer.view == snackImageViews[3] {
            snacks.insert("Popsicle", at: 0)
        } else if recognizer.view == snackImageViews[4] {
            snacks.insert("Ramen", at: 0)
        }
        snackListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
//        snackListTableView.reloadData()
    }
    
}


extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snacks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = snackListTableView.dequeueReusableCell(withIdentifier: snackCellId, for: indexPath)
        cell.textLabel?.text = snacks[indexPath.row]
        return cell
    }
    
}
