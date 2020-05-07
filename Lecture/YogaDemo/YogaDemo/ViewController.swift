//
//  ViewController.swift
//  YogaDemo
//
//  Created by Kaden Kim on 2020-05-07.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit
import YogaKit

class ViewController: UIViewController {
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        v.configureLayout {
            $0.isEnabled = true
            $0.flexDirection = .row
            $0.width = 320
            $0.height = 80
            $0.padding = 10
        }
        v.addSubview(child1)
        v.addSubview(child2)
        return v
    }()
    
    let child1: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        v.configureLayout {
            $0.isEnabled = true
            $0.width = 80
            $0.marginRight = 10
        }
        return v
    }()
    
    let child2: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        v.configureLayout {
            $0.isEnabled = true
            $0.width = 80
            $0.height = 40
            $0.flexGrow = 1
            $0.alignSelf = .center
        }
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let width = view.bounds.size.width
        let height = view.bounds.size.height
        
        view.configureLayout {
            $0.isEnabled = true
            $0.width = YGValue(width)
            $0.height = YGValue(height)
            $0.alignItems = .center
            $0.justifyContent = .center
        }
        view.addSubview(contentView)
        view.yoga.applyLayout(preservingOrigin: true)
    }
    
}
