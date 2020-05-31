//
//  PhotoDetailViewModel.swift
//  MVVM-Demo
//
//  Created by Kaden Kim on 2020-05-30.
//  Copyright © 2020 CICCC. All rights reserved.
//

import RxSwift
import RxCocoa

/// View Model interface that is visible to the PhotoDetailViewController
protocol PhotoDetailViewModel: class {
    // Input
    var viewDidLoad: PublishRelay<Void> { get }
    
    // Output
    var isLoading: BehaviorRelay<Bool> { get }
    var imageRetrievedError: PublishRelay<Void> { get }
    var imageRetrievedSuccess: PublishRelay<UIImage> { get }
    var description: PublishRelay<String> { get }
}

final class PhotoDetailViewModelImplementation: PhotoDetailViewModel {
    
    // MARK: - Input
    let viewDidLoad = PublishRelay<Void>()
    
    // MARK: - Output
    let isLoading = BehaviorRelay<Bool>(value: false)
    let imageRetrievedError = PublishRelay<Void>()
    let imageRetrievedSuccess = PublishRelay<UIImage>()
    let description = PublishRelay<String>()
    
    // MARK: - Private Properties
    private let photosService: UnsplashPhotoService
    private let photoLoadingService: DataLoadingService
    private let dataToImageService: DataToImageConversionService
    private let coordinator: PhotoDetailCoordinator
    
    private let disposeBag = DisposeBag()
    private let unsplashPhoto = PublishRelay<UnsplashPhoto>()
    private let photoId: String
    
    // MARK: - Initialization
    init(photosService: UnsplashPhotoService,
         photoLoadingService: DataLoadingService,
         dataToImageService: DataToImageConversionService,
         coordinator: PhotoDetailCoordinator,
         photoId: String) {
        self.photosService = photosService
        self.photoLoadingService = photoLoadingService
        self.dataToImageService = dataToImageService
        self.coordinator = coordinator
        self.photoId = photoId
        
        bindOnViewDidLoad()
        bindOnPhotoRetrieval()
    }
    
    private func bindOnViewDidLoad() {
        viewDidLoad
            .do(onNext: { [unowned self] _ in self.getPhoto() })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func bindOnPhotoRetrieval() {
        // Bind to description
        unsplashPhoto
            .flatMap({ unsplashPhoto -> Observable<String?> in
                var description: String?
                
                if let photoDescription = unsplashPhoto.description {
                    description = photoDescription
                } else if let alternativeDescription = unsplashPhoto.altDescription {
                    description = alternativeDescription
                }
                
                return Observable.just(description)
            })
            .compactMap { $0 }
            .bind(to: description)
            .disposed(by: disposeBag)
        
        unsplashPhoto
            .flatMap({ [weak self] photo -> Observable<(Data?, Error?)> in
                guard let self = self else { return.empty() }
                
                if let photoURL = photo.urls?.regular {
                    return self.photoLoadingService
                        .loadData(for: photoURL)
                        .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                } else {
                    self.imageRetrievedError.accept(())
                    return Observable.of((nil, NetworkError.decodingFailed))
                }
            })
            .do(onNext: { [weak self] _ in self?.isLoading.accept(false) })
            .map ({ (data, error) -> (UIImage?, Error?) in
                if let imageData = data, let image = self.dataToImageService.getImage(from: imageData) {
                    return (image, nil)
                } else {
                    self.imageRetrievedError.accept(())
                    return (nil, NetworkError.decodingFailed)
                }
            })
            .compactMap { $0.0 }
            .bind(to: imageRetrievedSuccess)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Service Methods
    private func getPhoto() {
        isLoading.accept(true)
        
        photosService.getPhoto(id: photoId)
            .compactMap ({ [weak self] (unsplashPhoto, error) in
                guard let photo = unsplashPhoto, error == nil else {
                    self?.imageRetrievedError.accept(())
                    return nil
                }
                return photo
            })
            .bind(to: unsplashPhoto)
            .disposed(by: disposeBag)
    }
    
}
