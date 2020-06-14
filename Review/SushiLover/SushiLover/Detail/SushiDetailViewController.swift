//
//  SushiDetailViewController.swift
//  SushiLover
//
//  Created by Derrick Park on 5/21/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit

class SushiDetailViewController: UIViewController {
  
  var sushi: Sushi! {
    didSet {
      updateView()
    }
  }
  
  private let nameLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = true
    lb.font = .preferredFont(forTextStyle: .largeTitle)
    lb.textColor = .darkGray
    lb.adjustsFontForContentSizeCategory = true
    lb.setContentHuggingPriority(.required, for: .vertical)
    return lb
  }()
  
  private let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    iv.translatesAutoresizingMaskIntoConstraints = true
    iv.setContentHuggingPriority(.defaultHigh, for: .vertical)
    return iv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainRed]
    
    setupView()
  }
  
  private func setupView() {
    let vStack = VerticalStackView(arrangedSubviews: [
      nameLabel,
      imageView
    ], spacing: 16, alignment: .center, distribution: .fill)
    view.addSubview(vStack)
    vStack.anchors(topAnchor: view.safeAreaLayoutGuide.topAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, padding: .init(top: 32, left: 16, bottom: 16, right: 32))
  }

  private func updateView() {
    nameLabel.text = sushi.name
    imageView.image = UIImage(named: sushi.name)
    title = sushi.category.rawValue
  }
}
