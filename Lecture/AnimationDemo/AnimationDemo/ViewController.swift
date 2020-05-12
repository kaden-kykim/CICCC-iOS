//
//  ViewController.swift
//  AnimationDemo
//
//  Created by Kaden Kim on 2020-05-12.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        example1()
        example2()
    }

    // change the background color of the square view
    func example1() {
        let square = UIView(frame: .init(x: 0, y: 44, width: 100, height: 100))
        square.backgroundColor = .purple
        view.addSubview(square)
        UIView.animate(withDuration: 3.0) {
            square.backgroundColor = .black
        }
    }
    
    // make the square larger and move it to the center of the view
    func example2() {
        let square = UIView(frame: .init(x: 0, y: 44, width: 100, height: 100))
        square.backgroundColor = .purple
        view.addSubview(square)
        UIView.animate(withDuration: 3.0) {
            square.backgroundColor = .orange
            square.frame = CGRect(x: self.view.frame.size.width / 2 - 100, y: self.view.frame.size.height / 2 - 100, width: 200, height: 200)
        }
    }

}
