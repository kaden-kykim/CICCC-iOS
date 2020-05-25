//
//  ViewController.swift
//  Foodie
//
//  Created by Kaden Kim on 2020-05-20.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let filterBarCollectionView: FilterBarCollectionView = {
        let filterBarCV = FilterBarCollectionView()
        filterBarCV.translatesAutoresizingMaskIntoConstraints = false
        filterBarCV.constraintHeight(equalToConstant: 60)
        return filterBarCV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .systemFill
        
        navigationItem.title = "Foodie"
        navigationItem.largeTitleDisplayMode = .never
        
        setupFilterBarCollectionView()
    }
    
    private func setupFilterBarCollectionView() {
        FoodieController.shared.fetchCategories {
            self.filterBarCollectionView.filters = $0
        }
        view.addSubview(filterBarCollectionView)
        filterBarCollectionView.anchors(topAnchor: view.safeAreaLayoutGuide.topAnchor, leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor, trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor, bottomAnchor: nil)
    }
    
}

extension FilterBarCollectionView : UICollectionViewDelegate {
    
}
