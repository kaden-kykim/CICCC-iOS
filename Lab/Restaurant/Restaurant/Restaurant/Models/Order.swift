//
//  Order.swift
//  Restaurant
//
//  Created by Kaden Kim on 2020-05-16.
//  Copyright © 2020 CICCC. All rights reserved.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
