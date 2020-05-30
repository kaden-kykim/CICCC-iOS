//
//  UnsplashPhotosService.swift
//  MVVM-Demo
//
//  Created by Kaden Kim on 2020-05-29.
//  Copyright © 2020 CICCC. All rights reserved.
//

import RxSwift

protocol UnsplashPhotoService: class {
    /// Returns by default 10 photos
    func getPhotos() -> Observable<([UnsplashPhoto]?, Error?)>
    /// Specify a different count
    func getPhotos(pageNumber: Int, perPage: Int) -> Observable<([UnsplashPhoto]?, Error?)>
    
    /// Returns random photos
    func getRandomPhotos(count: Int) -> Observable<([UnsplashPhoto]?, Error?)>
    
    /// Returns a photo by the given **id**
    func getPhoto(id: String) -> Observable<(UnsplashPhoto?, Error?)>
}

class UnsplashPhotosServiceImplementation: UnsplashPhotoService {
    private let networkClient = NetworkClient(baseUrlString: BaseURLs.unsplash)
    
    func getPhotos() -> Observable<([UnsplashPhoto]?, Error?)> {
        self.networkClient.getArray([UnsplashPhoto].self, UnsplashEndpoints.getPhotos)
    }
    
    func getPhotos(pageNumber: Int, perPage: Int) -> Observable<([UnsplashPhoto]?, Error?)> {
        return Observable.deferred {
            let parameter = ["page": String(pageNumber),
                             "per_page": String(perPage),
                             "order_by": "popular"]
            return self.networkClient.getArray([UnsplashPhoto].self, UnsplashEndpoints.getPhotos, parameters: parameter)
        }
    }
    
    func getRandomPhotos(count: Int) -> Observable<([UnsplashPhoto]?, Error?)> {
        return Observable.deferred {
            let parameter = ["count": String(count)]
            return self.networkClient.getArray([UnsplashPhoto].self, UnsplashEndpoints.getRandomPhotos, parameters: parameter)
        }
    }
    
    func getPhoto(id: String) -> Observable<(UnsplashPhoto?, Error?)> {
        return Observable.deferred {
            return self.networkClient.get(UnsplashPhoto.self, "\(UnsplashEndpoints.getPhotoById)\(id)", printURL: true)
        }
    }
}
