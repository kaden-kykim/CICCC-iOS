//
//  FilterBarCollectionViewController.swift
//  Foodie
//
//  Created by Kaden Kim on 2020-05-20.
//  Copyright © 2020 CICCC. All rights reserved.
//

import Foundation
import UIKit

private let itemSpacing: CGFloat = 8

class FilterBarCollectionView: UICollectionView {
    
    private let cellId = "FilterBarCell"
    
    private var timeFilters = [String]()
    private var foodFilters = [String]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = itemSpacing
        self.init(frame: .zero, collectionViewLayout: layout)
        register(FilterBarCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FilterBarCollectionView : UICollectionViewDataSource {
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return FoodieController.shared.timeCategories.count
        } else if section == 1 {
            return FoodieController.shared.foodCategories.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }

}

extension FilterBarCollectionView : UICollectionViewDelegate {
    
}
