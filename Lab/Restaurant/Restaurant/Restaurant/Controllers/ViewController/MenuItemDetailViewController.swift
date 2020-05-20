//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Kaden Kim on 2020-05-16.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var detailTextLabel: UILabel!
    @IBOutlet var addToOrderButton: UIButton!
    
    var menuItem: MenuItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToOrderButton.layer.cornerRadius = 5.0
        updateUI()
    }
    
    private func updateUI() {
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$ %.2f", menuItem.price)
        detailTextLabel.text = menuItem.detailText
    }
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.addToOrderButton.transform = .identity
            MenuController.shared.order.menuItems.append(self.menuItem)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
