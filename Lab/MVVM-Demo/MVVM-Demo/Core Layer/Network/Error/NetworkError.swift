//
//  NetworkError.swift
//  MVVM-Demo
//
//  Created by Kaden Kim on 2020-05-29.
//  Copyright © 2020 CICCC. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingFailed
    case unknown
}
