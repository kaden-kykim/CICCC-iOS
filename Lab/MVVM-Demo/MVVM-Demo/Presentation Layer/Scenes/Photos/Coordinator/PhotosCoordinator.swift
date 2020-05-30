//
//  PhotosCoordinator.swift
//  MVVM-Demo
//
//  Created by Kaden Kim on 2020-05-29.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

protocol PhotosCoordinator: class {
    func pushToPhotoDetail(with photoId: String)
}

class PhotosCoordinatorImplementation: Coordinator {
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let photosViewController = PhotosViewController()
//        let photosViewModel = PhotosViewModelImplementation(
    }
}
