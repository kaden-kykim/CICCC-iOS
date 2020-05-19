//
//  HeaderView.swift
//  CollectionViewDemo
//
//  Created by Kaden Kim on 2020-05-19.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let textLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 30)
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        textLabel.text = "Microsoft!"
        addSubview(textLabel)
        textLabel.matchParent(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
