//
//  Game.swift
//  ApplePie
//
//  Created by Kaden Kim on 2020-04-22.
//  Copyright © 2020 CICCC. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMoveRemaining: Int
    var guessedLetters: [Character]
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMoveRemaining -= 1
        }
    }
}
