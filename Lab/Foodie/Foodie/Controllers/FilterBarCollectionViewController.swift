//
//  FilterBarCollectionViewController.swift
//  Foodie
//
//  Created by Kaden Kim on 2020-05-20.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

private let itemSpacing: CGFloat = 8
private let sectionInsets: UIEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)

class FilterBarCollectionView: UICollectionView {
    
    var foodieDelegate: FoodieDelegate?
    
    private var categories = [[String]]()
    private var filters = [[Bool]]()
    
    private let cellId = "FilterBarCell"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        NotificationCenter.default.addObserver(self, selector: #selector(initUI), name: FoodieController.restaurantsUpdatedNotification, object: nil)
    }
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = itemSpacing
        self.init(frame: .zero, collectionViewLayout: layout)
        dataSource = self
        delegate = self
        register(FilterBarCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        showsHorizontalScrollIndicator = false
        backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func initUI() {
        categories.append(FoodieController.shared.timeCategories)
        categories.append(FoodieController.shared.foodCategories)
        filters.append(.init(repeating: false, count: categories[FoodieController.TIME_INDEX].count))
        filters.append(.init(repeating: false, count: categories[FoodieController.FOOD_INDEX].count))
        reloadData()
    }
    
}

extension FilterBarCollectionView : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FilterBarCollectionViewCell
        cell.filterLabel.text = categories[indexPath.section][indexPath.row]
        cell.filtered = filters[indexPath.section][indexPath.row]
        return cell
    }
    
}

extension FilterBarCollectionView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filters[indexPath.section][indexPath.row] = !filters[indexPath.section][indexPath.row]
        reloadData()
        var filteredRestaurants = [Restaurant]()
        for (type, filter) in filters.enumerated() {
            for (index, filtered) in filter.enumerated() {
                if filtered, let restaurants = FoodieController.shared.restaurants(in: categories[type][index], of: type) {
                    filteredRestaurants.append(contentsOf: restaurants)
                }
            }
        }
        if filteredRestaurants.count != 0 {
            foodieDelegate?.filterItem(Array(Set(filteredRestaurants.map { $0 })).sorted())
        } else {
            foodieDelegate?.filterItem(FoodieController.shared.restaurants)
        }
    }
}

extension FilterBarCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = categories[indexPath.section][indexPath.row].size(withAttributes: [.font: UIFont.systemFont(ofSize: 15)]).width
        return CGSize.init(width: width + 25, height: 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}
