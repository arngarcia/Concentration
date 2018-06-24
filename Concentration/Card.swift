//
//  Card.swift
//  Concentration
//
//  Created by Arnold Louie C. Garcia on 22/06/2018.
//  Copyright © 2018 Arnold Louie C. Garcia. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int {return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
/*structs and classes are very same
 2 major differences:
 (1) structs do not have inheritance while classes do;
 (2) structs are value types and classes are reference types (Most important)
 - Value type: It gets copied
 - Reference type: Lives in the heap. You pass pointers to the same object.
 */

/*
 structs get a free initializer that initialzes all their vars
 */
    var isFaceUp = false //determines if a card is face up or down (down by default)
    var isMatched = false //determines if a card has already been matched with another
    var wasMisMatched = false //determines whether or note a card has been mismatched
    private var identifier: Int //an identifier for the card
    
    private static var identifierFactory = 0 //global variable for cards
    
    private static func getUniqueIdentifier() -> Int {
        // a function that you can't send to a card. the type card understands this message
        // tied to the type
        identifierFactory += 1 //everytime you get a unique identifier you add + 1 and return it
        return identifierFactory
    }
    
    init (){
        self.identifier = Card.getUniqueIdentifier() //it is a relatively unique identifier
    }
}
