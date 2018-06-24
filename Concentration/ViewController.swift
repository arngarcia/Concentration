//
//  ViewController.swift
//  Concentration
//
//  Created by Arnold Louie C. Garcia on 20/06/2018.
//  Copyright © 2018 Arnold Louie C. Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairOfCards)
    /*
     Classes get a free init only if all vars are initialized
     - Normally all instance variables have to be initialized
     
     Lazy Instantiation:
        1. As soon as someone tries to use game, then it initializes.
        2. Cannot have a didSet
    */
    
    var numberOfPairOfCards: Int {
        return (cardButtons.count + 1)/2
    }

    @IBOutlet var cardButtons: [UIButton]! //Collection forming the basis for the index
    
    /*
        The lines below show the flip count and the score on the UI
    */
    
    @IBOutlet private weak var showScore: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel! //Creates a property (instance variable)
    
    @IBAction private func touchCard(_ sender: UIButton) {
        game.flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choose another card")
        }
    }
    
    private func updateViewFromModel() {
        //This configures the UI. OK
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji (for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 0.4223701585) : #colorLiteral(red: 1, green: 0.8128198981, blue: 0.5168927908, alpha: 1)
            }
            showScore.text = "Score: \(game.gameScore)"
            flipCountLabel.text = "Count: \(game.flipCount)"
        }
    }
    
    @IBAction func createNewGame(_ sender: UIButton) {
        /*
         Item #3:
            A new game should be greated (model should be refreshed)
            UI Should be updated (all facedown + flipcount should be reset to 0)
         
         Main Logic:
            1. Create a new Concentration Game
            2. Set Flipcount to 0
            3. Generate a random number based on the count of emojilists and use this to set the global emojiChoices variable.
            4. Update the View
         
         //EXTRA CREDIT WAS TOO EASY
        */
        self.game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
        let iconIndex = Int(arc4random_uniform(UInt32(emojiDictionary.count)))
        self.emojiChoices = Array(emojiDictionary.values)[iconIndex]
        view.backgroundColor = Array(emojiDictionary.keys)[iconIndex]
        updateViewFromModel()
    }
    
    /*
     Item #6: Declare emoji dictionary in one line of code
    */
    private var emojiDictionary = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : "🦇😱🙀😈🎃👻🍭🍬🍎", #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1): "🇨🇱🇻🇦🇻🇳🇪🇺🇬🇧🇸🇬🇿🇦🇸🇪🇸🇭",#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1): "🍏🍎🍐🍊🍋🍌🍉🍇🍓",#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1): "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓",#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1): "🐶🐱🐭🐹🐰🦊🐻🐼🐨",#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1): "🚗🚕🚙🚌🚎🏎🚓🚑🚒"]
    
    private var emojiChoices = "🍏🍎🍐🍊🍋🍌🍉🍇🍓" //default view
    
    private var emoji = [Card:String]()
    
    private func emoji (for card:Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            //swift never has automatic type conversion
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex,offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?" //IMPT: optional defaulting operator
    }

}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}


