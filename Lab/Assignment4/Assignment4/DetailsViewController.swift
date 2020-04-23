//
//  DetailsViewController.swift
//  Assignment4
//
//  Created by Kaden Kim on 2020-04-23.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var details: City!
    
    let vStackView: UIStackView = {
        let vsView = UIStackView()
        vsView.translatesAutoresizingMaskIntoConstraints = false
        vsView.axis = .vertical
        vsView.distribution = .equalSpacing
        return vsView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        vStackView.addArrangedSubview(DetailsTitleLabel(title: "Country"))
        vStackView.addArrangedSubview(DetailsContentLabel(content: convertFlagUni(from: details.nationCode)))
        vStackView.addArrangedSubview(DetailsTitleLabel(title: "City"))
        vStackView.addArrangedSubview(DetailsContentLabel(content: details.name))
        vStackView.addArrangedSubview(DetailsTitleLabel(title: "Temperature"))
        vStackView.addArrangedSubview(DetailsContentLabel(content: String.init(format: "%.1f", details.temp)))
        vStackView.addArrangedSubview(DetailsTitleLabel(title: "Summary"))
        vStackView.addArrangedSubview(DetailsContentLabel(content: details.summary))
        
        view.addSubview(vStackView)
        vStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
    }
    
    fileprivate func convertFlagUni(from country: String?) -> String {
        let base : UInt32 = 127397
        var s = ""
        if let country = country {
            for v in country.uppercased().unicodeScalars {
                s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
            }
        }
        return s
    }
    
    @objc func goPrevViewController() {
        navigationController?.popViewController(animated: true)
    }
    
}
