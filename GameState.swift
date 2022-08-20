//
//  GameState.swift
//  SwiftUIPlayingCards
//
//  Created by Chris Mash on 15/02/2022.
//

import Foundation
import SwiftUI
import CoreData

// A representation of a playing card
struct Card: Identifiable, Equatable {
    let id = UUID()
    let number: Int
    
    var cardImage: Image{
            Image(String(number))
    }
    
}

// A representation of a player's hand of cards
class Hand: ObservableObject, Identifiable {
    
    //Dictionary for the system to calculate point, calculate the total cards value the user and computer are holding
    private var valueDictionary:[Int:Int] = [
    
        0 : 10, // Ace
        1 : 2,
        2 : 3,
        3 : 4,
        4 : 5,
        5 : 6,
        6 : 7,
        7 : 8,
        8 : 9,
        9: 10,
        10 : 10, // Jack
        11 : 10, // Queen
        12 : 10, // King
        13 : 10, // Ace
        14 : 2 ,
        15 : 3 ,
        16 : 4 ,
        17 : 5 ,
        18 : 6 ,
        19 : 7 ,
        20 : 8 ,
        21 : 9 ,
        22 : 10,
        23 : 10, // Jack
        24 : 10, // Queen
        25 : 10, // King
        26 : 10, // Ace
        27 : 2 ,
        28 : 3 ,
        29 : 4 ,
        30 : 5 ,
        31 : 6 ,
        32 : 7 ,
        33 : 8 ,
        34 : 9 ,
        35 : 10,
        36 : 10, // Jack
        37 : 10, //Queen
        38 : 10, //King
        39 : 10, //Ace
        40 : 2 ,
        41 : 3 ,
        42 : 4 ,
        43 : 5 ,
        44 : 6 ,
        45 : 7 ,
        46 : 8 ,
        47 : 9 ,
        48 : 10 ,
        49 : 10 , // Jack
        50 : 10 , //Queen
        51 : 10 , //King
        
        
    ]
    
    let id = UUID()
    //Contains all cards in hands as array
    @Published var cards = [Card]()
    //To know is this a user hand or a computer hand
    var type = "";
    
    //function to print out all cards available in hand
    public func getHandTotalCard(){
        print("[",terminator: "")
        for card in cards {
            print(card.number,terminator: " ")
        }
        print("]",terminator: "")
    }
    
    //function to calculate all points available for the cards, we will need a dictionary for this
    public func calculateTotalPointOfCards() -> Int{
        var cardPoint = 0;
        //Loop through the array of cards
        for card in cards {
            cardPoint += valueDictionary[card.number] ?? 0;
        }
        
        return cardPoint;
    }
}

// A representation of the current state of the game,
// including which cards each player has and the deck
// of cards that can be picked up from
class GameState {
    
    //This is the game master deck to contain all the cards
    private(set) var deck = Hand()
    
    
    //2 hands in the game, 1 is for the user, 1 is for the computer
    private(set) var hands = [Hand]()
    
    init() {
        // Fill the deck with 52 cards, shuffled
        for i in 0...51 {
            deck.cards.append(Card(number: i))
        }
        deck.cards.shuffle()
        
        // Setup two hands of cards with one card each from the deck
        for i in 0..<2 {
            //Create a hand
            let hand = Hand()
            
            //Assign the type of hand
            if(i % 2 == 0){
                hand.type = "computer"
            }
            else {
                hand.type = "user"
            }
            
            //Fill the hand with 2 cards first
            for _ in 0..<2 {
                guard let card = deck.cards.popLast() else {
                    fatalError("Tried to deal more cards than in the deck")
                }
                
                hand.cards.append(card)
            }
            
            //Add the hand into the game
            hands.append(hand)
        }
    }
    
}
