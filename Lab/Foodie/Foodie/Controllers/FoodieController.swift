//
//  FoodieController.swift
//  Foodie
//
//  Created by Kaden Kim on 2020-05-20.
//  Copyright © 2020 CICCC. All rights reserved.
//

import Foundation

class FoodieController {
    
    static let restaurantsUpdatedNotification = Notification.Name("FoodieController.restaurantDataUpdated")
    static let shared = FoodieController()
    
    private var restaurantByID = [Int: Restaurant]()
    private var restaurantByTimeCategory = [String: [Restaurant]]()
    private var restaurantByFoodCategory = [String: [Restaurant]]()
    
    // MARK: - Getters
    
    var timeCategories: [String] {
        get { return restaurantByTimeCategory.keys.sorted() }
    }
    
    var foodCategories: [String] {
        get { return restaurantByFoodCategory.keys.sorted() }
    }
    
    func restaurant(withID restaurantID: Int) -> Restaurant? {
        return restaurantByID[restaurantID]
    }
    
    func restaurant(forTimeCategory category: String) -> [Restaurant]? {
        return restaurantByTimeCategory[category]
    }
    
    func restaurant(forFoodCategory category: String) -> [Restaurant]? {
        return restaurantByFoodCategory[category]
    }
    
    // MARK: - Data Interface
    
    func loadData() {
        FoodieController.shared.fetchRestaurants {
            self.processData($0)
        }
    }
    
    private func processData(_ restaurants: [Restaurant]) {
        restaurantByID.removeAll()
        restaurantByTimeCategory.removeAll()
        restaurantByFoodCategory.removeAll()
        
        for restaurant in restaurants {
            restaurantByID[restaurant.id] = restaurant
            for time in restaurant.timeCategories {
                restaurantByTimeCategory[time, default: []].append(restaurant)
            }
            for food in restaurant.foodCategories {
                restaurantByFoodCategory[food, default: []].append(restaurant)
            }
        }
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: FoodieController.restaurantsUpdatedNotification, object: nil)
        }
    }
    
    func fetchRestaurants(completion: @escaping (([Restaurant]) -> Void)) {
        completion(sampleRestaurants())
    }
    
}
