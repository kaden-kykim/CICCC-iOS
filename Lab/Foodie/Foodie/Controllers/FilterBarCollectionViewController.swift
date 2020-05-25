//
//  FilterBarCollectionViewController.swift
//  Foodie
//
//  Created by Kaden Kim on 2020-05-20.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

private let itemSpacing: CGFloat = 8

class FilterBarCollectionView: UICollectionView {
    
    var foodieDelegate: FoodieDelegate?
        
    private var categories: [[String]?] = .init(repeating: nil, count: 2)
    private var filters: [[Bool]?] = .init(repeating: nil, count: 2)
    
    private let cellId = "FilterBarCell"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: FoodieController.restaurantsUpdatedNotification, object: nil)
    }
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
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
    
    func setFoodieDelegate(foodieDelegate: FoodieDelegate) {
        self.foodieDelegate = foodieDelegate
    }
    
    @objc private func updateUI() {
        categories[0] = FoodieController.shared.timeCategories
        categories[1] = FoodieController.shared.foodCategories
        filters[0] = .init(repeating: false, count: categories[0]?.count ?? 0)
        filters[1] = .init(repeating: false, count: categories[1]?.count ?? 0)
        reloadData()
    }
    
}

extension FilterBarCollectionView : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories[section]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FilterBarCollectionViewCell
        cell.filterLabel.text = categories[indexPath.section]?[indexPath.row] ?? ""
        cell.filtered = filters[indexPath.section]?[indexPath.row] ?? false
        cell.setContentCompressionResistancePriority(.required, for: .horizontal)
        return cell
    }
    
}

extension FilterBarCollectionView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let filtered = filters[indexPath.section]?[indexPath.row] {
            filters[indexPath.section]?[indexPath.row] = !filtered
            reloadData()
        }
        foodieDelegate?.filterItem(indexPath)
    }
}
