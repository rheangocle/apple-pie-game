//
//  ViewController.swift
//  Apple Pie
//
//  Created by Rhea Le on 1/2/24.
//

import UIKit

class ViewController: UIViewController {

    var listOfWords = ["cat", "dog", "bird", "bunny", "hamster", "rat", "gerbil", "guinea pig", "snake", ]
    let incorrectMovesAllowed = 7
    var totalWins = 0
    var totalLosses = 0
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        newGame()
    }
    
    func newGame() {
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
        
    }
    
    func updateUI() {
        correctWordLabel.text = currentGame.currentGuessedWord
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateUI()
    }
}

