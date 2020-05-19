//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by Kaden Kim on 2020-05-19.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    private let padding: CGFloat = 8
    
    override func loadView() {
        super.loadView()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

// MARK: - CollectionView data source
extension ViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PersonCollectionViewCell
        cell.imageView.image = UIImage(named: indexPath.item % 2 == 0 ? "billgates" : "melinda")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let view = collectionView.dequeueReusableSupplementaryView(ofKind: , withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
    }
    
}

// MARK: - CollectionView delegate flow layout
extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 2 * padding) / 3.0
        // Similar to TableView
//        let size = collectionView.frame.width - 2 * padding
        return CGSize(width: size, height: size)
    }
    
}

// MARK: - CollectionView delegate
extension ViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}
