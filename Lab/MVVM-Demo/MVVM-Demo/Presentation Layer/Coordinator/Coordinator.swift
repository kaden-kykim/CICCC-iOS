//
//  Coordinator.swift
//  MVVM-Demo
//
//  Created by Kaden Kim on 2020-05-29.
//  Copyright © 2020 CICCC. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
