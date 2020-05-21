//
//  Sushi.swift
//  SushiLover
//
//  Created by Derrick Park on 5/20/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

struct Sushi: Decodable {
  let name: String
  let category: Category
  
  enum Category: Decodable {
    case all
    case nigiri
    case sashimi
    case maki
  }
}

extension Sushi.Category: CaseIterable { }

extension Sushi.Category: RawRepresentable {
  typealias RawValue = String
  
  init?(rawValue: String) {
    switch rawValue {
      case "All": self = .all
      case "Nigiri": self = .nigiri
      case "Sashimi": self = .sashimi
      case "Maki": self = .maki
      default:
        return nil
    }
  }
  
  var rawValue: String {
    switch self {
      case .all: return "All"
      case .nigiri: return "Nigiri"
      case .sashimi: return "Sashimi"
      case .maki: return "Maki"
    }
  }
}

extension Sushi {
  static func sushis() -> [Sushi] {
    guard
      let url = Bundle.main.url(forResource: "sushi", withExtension: "json"),
      let data = try? Data(contentsOf: url)
      else { return [] }
    
    do {
      return try JSONDecoder().decode([Sushi].self, from: data)
    } catch {
      return []
    }
  }
}
