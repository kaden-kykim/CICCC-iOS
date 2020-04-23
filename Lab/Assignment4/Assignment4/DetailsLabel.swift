//
//  DetailsTitleLabel.swift
//  Assignment4
//
//  Created by Kaden Kim on 2020-04-23.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit

class DetailsTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        self.text = title.capitalized
        self.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DetailsContentLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(content: String) {
        self.init(frame: .zero)
        self.text = content
        self.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
