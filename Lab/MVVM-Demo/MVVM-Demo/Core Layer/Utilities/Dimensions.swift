//
//  Dimensions.swift
//  MVVM-Demo
//
//  Created by Kaden Kim on 2020-05-30.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

struct Dimensions {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    static let photosItemSize = CGSize(width: Dimensions.screenWidth * 0.45, height: Dimensions.screenWidth * 0.45)
}
