//
//  Articles.swift
//  BreakingNews
//
//  Created by Derrick Park on 5/25/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

struct Articles: Codable {
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    struct Source: Codable {
        let name: String
    }
    let source: Source
    let author: String?
    let title: String
    let url: URL
    let urlToImage: String?
}

extension Article: Hashable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
