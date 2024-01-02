//
//  Game.swift
//  Apple Pie
//
//  Created by Rhea Le on 1/2/24.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedState: [Character: Bool]
    
    init(word: String, incorrectMovesRemaining: Int) {
        self.word = word
        self.incorrectMovesRemaining = incorrectMovesRemaining
        self.guessedState = [:]
        
        for letter in word {
            guessedState[letter] = false
        }
    }
    
    mutating func playerGuessed(letter: Character) {
        if word.contains(letter) {
            guessedState[letter] = true
        } else {
            incorrectMovesRemaining -= 1
        }
    }
    
    var currentGuessedWord: String {
        var displayedWord = ""
        
        for letter in word {
            if guessedState[letter, default: false] {
                displayedWord += "\(letter)"
            } else {
                displayedWord += "_"
            }
        }
        return displayedWord
    }
    
//    mutating func playerGuessed(letter: Character) {
//        guessedLetters.append(letter)
//        if !word.contains(letter) {
//            incorrectMovesRemaining -= 1
//        }
//    }
//    var formattedWord: String {
//        var guessedWord = ""
//        for letter in word {
//            if guessedLetters.contains(letter) {
//                guessedWord += "\(letter)"
//            } else {
//                guessedWord += "_"
//            }
//        }
//        return guessedWord
//    }
}
