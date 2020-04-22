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
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            guessedWord += guessedLetters.contains(letter) ? "\(letter)" : "_"
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMoveRemaining -= 1
        }
    }
}
