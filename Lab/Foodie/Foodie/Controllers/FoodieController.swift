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
    
    func fetchCategories(completion: @escaping ((Categories) -> Void)) {
        let categories = Categories()
        completion(categories)
    }
    
}
