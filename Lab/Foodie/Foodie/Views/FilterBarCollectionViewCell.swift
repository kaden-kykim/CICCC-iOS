//
//  FilterBarCollectionViewCell.swift
//  Foodie
//
//  Created by Kaden Kim on 2020-05-20.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class FilterBarCollectionViewCell: UICollectionViewCell {
    
    let filterLabel: UILabel = {
        let fl = UILabel()
        fl.translatesAutoresizingMaskIntoConstraints = false
        fl.textAlignment = .center
        fl.font = .systemFont(ofSize: 15)
        return fl
    }()
    
    var filtered = false {
        didSet {
            self.contentView.backgroundColor = (filtered) ? .systemBlue : .systemBackground
            filterLabel.textColor = (filtered) ? .systemBackground : .systemBlue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(filterLabel)
        contentView.layer.cornerRadius = 5.0
        filterLabel.matchParent(padding: .init(top: 8, left: 12, bottom: 8, right: 12))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
