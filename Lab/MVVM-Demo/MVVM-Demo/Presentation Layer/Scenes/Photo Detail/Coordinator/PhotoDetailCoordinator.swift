//
//  PhotoDetailCoordinator.swift
//  MVVM-Demo
//
//  Created by Kaden Kim on 2020-05-30.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

protocol PhotoDetailCoordinator: class {}

class PhotoDetailCoordinatorImplementation: Coordinator {
    unowned let navigationController: UINavigationController
    let photoId: String
    
    init(navigationController: UINavigationController, photoId: String) {
        self.navigationController = navigationController
        self.photoId = photoId
    }
    
    func start() {
        let photoDetailViewController = PhotoDetailViewController()
        let photoDetailViewModel = PhotoDetailViewModelImplementation(
            photosService: UnsplashPhotosServiceImplementation(),
            photoLoadingService: DataLoadingServiceImplementation(),
            dataToImageService: DataToImageConversionServiceImplementation(),
            coordinator: self, photoId: photoId)
        photoDetailViewController.viewModel = photoDetailViewModel
        navigationController.pushViewController(photoDetailViewController, animated: true)
    }
}

extension PhotoDetailCoordinatorImplementation: PhotoDetailCoordinator {}
