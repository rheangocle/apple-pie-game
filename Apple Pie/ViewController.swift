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
    var maxRounds = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    func newGame() {
        fetchRandomWord { randomWord in
            DispatchQueue.main.async {
                if let newWord = randomWord {
                    self.currentGame = Game(word: newWord, incorrectMovesRemaining: self.incorrectMovesAllowed)
                    self.updateUI()
                } else {
                    
                }
    
            }
        }
    }

//    func newGame() {
//        let newWord = listOfWords.removeFirst()
//        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
//        updateUI()
//    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.currentGuessedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState() {
        maxRounds -= 1
        if currentGame.incorrectMovesRemaining == 0 {
            correctWordLabel.text = currentGame.word
            totalLosses += 1
        } else if currentGame.word == currentGame.currentGuessedWord {
            correctWordLabel.text = currentGame.word
            totalWins += 1
        } else {
            updateUI()
        }
    }

    func newRound() {
        if maxRounds != 0 {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
            enableLetterButtons(true)
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func fetchRandomWord(completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://random-word-api.herokuapp.com/word?number=1")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching word: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }

            do {
                if let words = try JSONSerialization.jsonObject(with: data, options: []) as? [String], let word = words.first {
                    DispatchQueue.main.async {
                        completion(word)
                    }
                } else {
                    print("Invalid response format")
                    completion(nil)
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
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
        updateGameState()
    }
}

