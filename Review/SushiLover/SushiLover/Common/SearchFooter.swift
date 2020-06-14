//
//  SearchFooter.swift
//  SushiLover
//
//  Created by Derrick Park on 5/21/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit

class SearchFooter: UIView {
  private let label = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func draw(_ rect: CGRect) { /// No need to call super.draw(_ rect: CGRect)
    label.frame = bounds
  }
  
  func isNotFiltering() {
    label.text = ""
    hideFooter()
  }
  
  func isFilteringToShow(filteredItemCount: Int, of totalItemCount: Int) {
    if (filteredItemCount == totalItemCount) {
      isNotFiltering()
    } else if (filteredItemCount == 0) {
      label.text = "No items match your query"
      showFooter()
    } else {
      label.text = "Filtering \(filteredItemCount) of \(totalItemCount)"
      showFooter()
    }
  }
  
  private func setupView() {
    backgroundColor = .mainRed
    alpha = 0.0
    label.textAlignment = .center
    label.textColor = .white
    addSubview(label)
  }
  
  private func hideFooter() {
    UIView.animate(withDuration: 0.7) {
      self.alpha = 0.0
    }
  }
  
  private func showFooter() {
    UIView.animate(withDuration: 0.7) {
      self.alpha = 1.0
    }
  }
}
