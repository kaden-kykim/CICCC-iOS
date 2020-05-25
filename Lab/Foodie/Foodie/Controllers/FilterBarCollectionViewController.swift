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
    
    var filters = Categories() {
        didSet { self.reloadData() }
    }
    
    private let cellId = "FilterBarCell"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    convenience init(delegate: UICollectionViewDelegate) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = .init(top: 12, left: 10, bottom: 12, right: 10)
        layout.minimumInteritemSpacing = itemSpacing
        self.init(frame: .zero, collectionViewLayout: layout)
        showsHorizontalScrollIndicator = false
        backgroundColor = .systemGray6
        self.dataSource = self
        self.delegate = delegate
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
            return filters.time.count
        } else if section == 1 {
            return filters.food.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FilterBarCollectionViewCell
        cell.filterLabel.text = {
            switch indexPath.section {
            case 0:
                return filters.time[indexPath.row]
            case 1:
                return filters.food[indexPath.row]
            default:
                return ""
            }
        }()
        cell.filtered = false
        return cell
    }
    
}
