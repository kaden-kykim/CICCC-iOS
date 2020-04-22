//
//  ViewController.swift
//  RainbowTabs
//
//  Created by Kaden Kim on 2020-04-22.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let centerBtn = CenterButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Red"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .red
        view.addSubview(centerBtn)
        centerBtn.addTarget(self, action: #selector(goToNextViewController), for: .touchUpInside)
        centerBtn.centerInSuperView()
    }
    
    @objc func goToNextViewController(_ sender: UIButton) {
        // go to GoViewController
        let goVC = GoViewController()
        goVC.color = navigationItem.title
        navigationController?.pushViewController(goVC, animated: true)
    }
    
}
