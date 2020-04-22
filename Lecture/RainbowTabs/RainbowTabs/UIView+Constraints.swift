//
//  UIView+Constraints.swift
//  RainbowTabs
//
//  Created by Kaden Kim on 2020-04-22.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

extension UIView {
    
    func centerInSuperView() {
        if let superView = self.superview {
            self.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        }
    }
}
