//
//  DataToImageConversionService.swift
//  MVVM-Demo
//
//  Created by Kaden Kim on 2020-05-29.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

protocol DataToImageConversionService: class {
    func getImage(from data: Data) -> UIImage?
}

class DataToImageConversionServiceImplementation: DataToImageConversionService {
    func getImage(from data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
