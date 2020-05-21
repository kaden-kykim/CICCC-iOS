//
//  FoodieController.swift
//  Foodie
//
//  Created by Kaden Kim on 2020-05-20.
//  Copyright © 2020 CICCC. All rights reserved.
//

import Foundation

class FoodieController {
    
    static let shared = FoodieController()
    
    // MARK: - Getters
    
    var timeCategories: [String] {
        get {
            return [ "Breakfast and Brunch", "Lunch", "Dinner" ]
        }
    }
    
    var foodCategories: [String] {
        get {
            return [ "Korean", "Canadian", "Asian", "Cafe" ].sorted()
        }
    }
    
}
