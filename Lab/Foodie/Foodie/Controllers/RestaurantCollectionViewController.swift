//
//  RestaurantCollectionViewController.swift
//  Foodie
//
//  Created by Kaden Kim on 2020-05-26.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

private let itemSpacing: CGFloat = 8
private let sectionInsets: UIEdgeInsets = .init(top: 6, left: 12, bottom: 6, right: 12)

class RestaurantCollectionView: UICollectionView {
    
    var restaurants = [Restaurant]()
    
    private let cellId = "RestaurantCell"

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        NotificationCenter.default.addObserver(self, selector: #selector(initUI), name: FoodieController.restaurantsUpdatedNotification, object: nil)
    }
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
        self.init(frame: .zero, collectionViewLayout: layout)
        dataSource = self
        delegate = self
        register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateRestaurants(_ restaurants: [Restaurant]) {
        self.restaurants = restaurants
        reloadData()
    }
    
    @objc private func initUI() {
        restaurants = FoodieController.shared.restaurants
        reloadData()
    }
    
}

extension RestaurantCollectionView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RestaurantCollectionViewCell
        let restaurant = restaurants[indexPath.row]
        FoodieController.shared.fetchImage(url: restaurant.imageURL) {
            guard let image = $0 else { return }
            DispatchQueue.main.async {
                if let currentIndexPath = self.indexPath(for: cell), currentIndexPath != indexPath { return }
                cell.imageView.image = image
                cell.setNeedsLayout()
            }
        }
        cell.nameLabel.text = restaurant.name
        cell.costLabel.text = Array(repeating: "$", count: restaurant.cost).reduce("", +)
        cell.timeCategoriesLabel.text = restaurant.timeCategories.reduce("") { $0 + ", " + $1 }
        cell.foodCategoriesLabel.text = restaurant.foodCategories.reduce("") { $0 + ", " + $1 }
        return cell
    }
}

extension RestaurantCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}
