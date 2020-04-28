//
//  ZoomViewController.swift
//  ScrollingForm
//
//  Created by Kaden Kim on 2020-04-28.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        updateZoom()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func updateZoom() {
        let widthScale = view.bounds.size.width / imageView.bounds.size.width
        let heightScale = view.bounds.size.height / imageView.bounds.size.height
        let minScale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }

}
