//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Kaden Kim on 2020-05-02.
//  Copyright © 2020 CICCC. All rights reserved.
//

import Foundation

struct Emoji {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    init(symbol: String, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
}
