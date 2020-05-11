//
//  StepperTableViewCell.swift
//  RegistrationForm
//
//  Created by Kaden Kim on 2020-05-11.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class StepperTableViewCell: UITableViewCell {
    
    private let guestLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return lb
    }()
    
    private let numberLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.setContentHuggingPriority(.required, for: .horizontal)
        return lb
    }()
    
    private lazy var stepper: UIStepper = {
        let sp = UIStepper()
        sp.translatesAutoresizingMaskIntoConstraints = false
        sp.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        return sp
    }()
    
    var getNumberOfGuests: Int {
        return Int(stepper.value)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(guestType: String) {
        self.init()
        guestLabel.text = guestType
        numberLabel.text = "0"
        //        let hs = HorizontalStackView(arrangedSubvies: [
        //               guestLabel, numberLabel, stepper
        //        ], spacing: 15, alignment: .center, distribution: .fill)
        //        contentView.addSubview(hs)
        //        hs.anchors(topAnchor: contentView.topAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, bottomAnchor: contentView.bottomAnchor)
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        numberLabel.text = "\(Int(stepper.value))"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
