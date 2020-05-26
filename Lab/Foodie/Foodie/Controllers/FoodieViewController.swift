//
//  ViewController.swift
//  Foodie
//
//  Created by Kaden Kim on 2020-05-20.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

protocol FoodieDelegate {
    func filterItem(_ restaurants: [Restaurant])
}

class FoodieViewController: UIViewController {
    
    private let filterBarCollectionView: FilterBarCollectionView = {
        let filterBarCV = FilterBarCollectionView()
        filterBarCV.translatesAutoresizingMaskIntoConstraints = false
        filterBarCV.constraintHeight(equalToConstant: 60)
        return filterBarCV
    }()
    
    private let restaurantCollectionView: RestaurantCollectionView = {
        let restaurantCV = RestaurantCollectionView()
        restaurantCV.translatesAutoresizingMaskIntoConstraints = false
        return restaurantCV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = .tertiarySystemBackground
        
        navigationItem.title = "Foodie"
        navigationItem.largeTitleDisplayMode = .never
        
        setupFilterBarCollectionView()
        setupRestaurantCollectionView()
    }
    
    private func setupFilterBarCollectionView() {
        view.addSubview(filterBarCollectionView)
        filterBarCollectionView.foodieDelegate = self
        filterBarCollectionView.anchors(topAnchor: view.safeAreaLayoutGuide.topAnchor, leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor, trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor, bottomAnchor: nil)
    }
    
    private func setupRestaurantCollectionView() {
        view.addSubview(restaurantCollectionView)
        restaurantCollectionView.anchors(topAnchor: filterBarCollectionView.bottomAnchor, leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor, trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
}

extension FoodieViewController : FoodieDelegate {
    
    func filterItem(_ restaurants: [Restaurant]) {
        restaurantCollectionView.updateRestaurants(restaurants)
    }
    
}
