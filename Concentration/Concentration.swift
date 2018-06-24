//
//  Concentration.swift
//  Concentration
//
//  Created by Arnold Louie C. Garcia on 22/06/2018.
//  Copyright © 2018 Arnold Louie C. Garcia. All rights reserved.
//

import Foundation

struct Concentration
{
    /*
    Application Programming Interface (API)
    What is it? A list of all methods and instance variables
    Tip? Create an API that gets to the essentials of what this thing does
     */
    
    private(set) var cards = [Card]() //creates an array containing the type "Card"
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices  {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    //creates an optional which is some value or nothing
    
    mutating func chooseCard(at index:Int) {
        /*
         Description: When you choose a card, it is either matched, or unmatched.
         This function receives an index and uses this index to see whether or not a card has already been matched
         
         if without Mutated ... it assumes it doesn't change the card game
         */
        assert(cards.indices.contains(index),"Concentration.chooseCard(at \(index)): chosen index not in cards")
        if !cards[index].isMatched{
            /*
                Assuming, it is not matched, evaluate whether or not indexofOneandOnlyFaceUpCard (if it exists) matches with the index passed to this function.
            */
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                /*
                 TAKE NOTE: THE FIRST CARD IS ALREADY CHOSEN AND YOU'VE PICKED A SECOND CARD
                */
                if cards[matchIndex].identifier == cards[index].identifier
                {
                    /*
                     TAKE NOTE: MATCHED SCENARIO
                    */
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2 //correct
                } else {
                    /*
                     TAKE NOTE: MISMATCH SCENARIO
                    */
                    if cards[matchIndex].wasMisMatched {
                        gameScore += -1
                    }
                    if cards[index].wasMisMatched {
                        gameScore += -1
                    }
                    cards[matchIndex].wasMisMatched = true
                    cards[index].wasMisMatched = true
                }
                cards[index].isFaceUp = true //ok
                indexOfOneAndOnlyFaceUpCard = nil //reset the matchIndex
                
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards>0,"Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards.")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        /*
         Item #4:
            This code shuffles the cards.
        */
        var shuffledCards = [Card]()
        for _ in cards {
            let shuffleIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let removedCard = cards.remove(at: shuffleIndex)
            shuffledCards += [removedCard]
        }
        cards = shuffledCards
    }
  
    var gameScore = 0
    var flipCount = 0
    
}

