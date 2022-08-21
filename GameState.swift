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
    //Left side are the index of the card, right side is their according value
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
    
    //These are for convenience when checking card conditions
    private var JackQueenKingCardContainer: [Int] = [10,11,12,23,24,25,36,37,38,49,50,51]
    private var AceLocationContainer: [Int] = [0,13,26,39]
    
    let id = UUID()
    //Contains all cards in hands as array
    @Published var cards = [Card]()
    //To know is this a user hand or a computer hand
    var type = "";
    
    //function to print out all cards available in hand
    public func getHandTotalCard(){
        print("[ ",terminator: "")
        for card in cards {
            print(card.number,terminator: " ")
        }
        print("]",terminator: "")
    }
    
    //Function to check if the cards in hand contain an Ace
    public func containsAce() -> Bool{
        for card in cards {
            //These numbers are the location of Ace card inside the dictionary
            if(card.number == 0 || card.number == 13 || card.number == 26 || card.number == 39){
                return true;
            }
        }
        return false;
    }
    
    
    //function to calculate all points available for the cards, we will need a dictionary for this
    public func calculateTotalPointOfCards() -> String{
        //Here we need to calculate the best possible value, the Ace can be 1,11 or 10, based on the number of our cards available
        var bestCardPointPossible = 0;
        let hasAce = containsAce();
        //We need to divide into 2 different situation, one with the Ace and one without the Ace
        //Initial stage when just enter the game, we have 2 cards
        //Base case, strongest case
        if(self.cards.count == 2){
            //CASE 1: If there is a presense of double Ace, they automatically win that round
            if(hasAce){
                //Double ace
                if(AceLocationContainer.contains(cards[0].number) && AceLocationContainer.contains(cards[1].number)){
                    return "Xi Ban"
                }
                //CASE 2: Xi Ban Case, One Ace and One J/K/Q/10
                else if( (AceLocationContainer.contains(cards[0].number) && JackQueenKingCardContainer.contains(cards[1].number)) || (AceLocationContainer.contains(cards[1].number) && JackQueenKingCardContainer.contains(cards[0].number))) {
                    return "Xi Dach"
                }
                else {
                    //If we have no Ace, we just loop through the beginning till the end and calculate sum with no condition
                    //Loop through the array of cards
                    for card in cards {
                        //We need to check if the cards including the Ace in there
                        bestCardPointPossible += valueDictionary[card.number] ?? 0;
                    }
                }
            }
            
            
            else {
                //If we have no Ace, we just loop through the beginning till the end and calculate sum with no condition
                //Loop through the array of cards
                for card in cards {
                    //We need to check if the cards including the Ace in there
                    bestCardPointPossible += valueDictionary[card.number] ?? 0;
                }
                return String(bestCardPointPossible);
            }
        }
        
        else{
            
            //If the cards quantity is larger than 2, we need to identify Ngu Linh case, then the Ace value will be 1 only
            if(hasAce){
                
                //If the cards quantity is equals to 5 and it has Ace in there, we will calculate for Ngu Linh
                if(self.cards.count == 5){
                    for card in cards {
                        //If we found an Ace, we will plus 1 only
                        if(AceLocationContainer.contains(card.number)){
                            bestCardPointPossible += 1;
                        }
                        else {
                            bestCardPointPossible += valueDictionary[card.number] ?? 0;
                        }
                    }
                    //Check again after calculating
                    if(bestCardPointPossible > 21){
                        return "Quach";
                    }
                    else if(bestCardPointPossible <= 21){
                        return "Ngu Linh";
                    }
                }
                //If the number of cards smaller than 5, like 4 for example, and if it has ace, the value will still be count as 1
                //Otherwise, we just need to calculate the normal sum, and the Ace will have the value of 10
                else {
                    for card in cards{
                        //If we found an Ace, we will plus 1 only
                        if(AceLocationContainer.contains(card.number)){
                            bestCardPointPossible += 1;
                        }
                        else {
                            bestCardPointPossible += valueDictionary[card.number] ?? 0;
                        }
                    }
                    //Check again after calculating
                    if(bestCardPointPossible > 21){
                        return "Quach";
                    }
                }
            }
            
            //If we do not have an Ace, we just need to loop through all cards and calculate sum
            else {
                for card in cards {
                    bestCardPointPossible += valueDictionary[card.number] ?? 0;
                }
                if(bestCardPointPossible > 21){
                    return "Quach";
                }
            }
            
            
        }
        return String(bestCardPointPossible);
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
