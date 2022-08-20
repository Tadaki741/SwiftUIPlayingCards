//
//  ContentView.swift
//  SwiftUIPlayingCards
//
//  Created by Chris Mash on 15/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    private var gameState = GameState()
    @Namespace private var animation
    
    
    //Match decision side
    @State private var computerTurn: Bool = false;
    @State private var userTurn: Bool = false;
    private var userPoint: Int = 0;
    private var computerPoint: Int = 0;
    
    var body: some View {
        VStack {
            //MARK: Master Deck on the top
            DeckView(deck: gameState.deck,namespace: animation)
            Spacer();
            
            //MARK: Computer side is in the middle, User side is on the bottom
            // Draw each player's hand of cards
            ForEach(gameState.hands) { hand in
                VStack{
                    
                    HStack {
                        

                        
    //                    // Include a button to pull a card from the deck into this hand
    //                    Button("Add") {
    //                        addCard(to: hand)
    //                    }.padding()
                        
                        HandView(hand: hand,namespace: animation)
                        
                    }.padding()
                    
                    //Options for the user
                    if(hand.type == "user"){
                        Button("Pick another"){
                            addCard(to: hand)
                        }
                        Button("Deal"){
                            userDealCard()
                        }
                    }
                    
                }
                Spacer();
                
            }
            
        }
    }
    
    //MARK: Game main function
    private func addCard(to hand: Hand) {
        withAnimation {
            guard let card = gameState.deck.cards.popLast() else {
                print("Deck is empty!")
                return
            }
            
            hand.cards.append(card)
            hand.getHandTotalCard()
            print("\(hand.type) total point is: \(hand.calculateTotalPointOfCards())")
        }
    }
    
    private func remove(card: Card, from hand: Hand) {
        withAnimation {
            // Put the card back in the deck
            guard let index = hand.cards.firstIndex(of: card) else {
                fatalError("Failed to find tapped card in hand")
            }
            
            hand.cards.remove(at: index)
            gameState.deck.cards.append(card)
        }
    }
    
    //MARK: Function used for user
    private func userDealCard(){
        //Now we will calculate the user's points and then compare it with the computer's point
        
        //If the user's point is higher than the computer then the user will win the match
        
        //We will keep gambling until we ran out of money
    }
    
    //MARK: Function used for computer, it's gonna be huge -_-
    //Computer moves only has, pick more card or stop picking, only the user can deal the card
    private func pickMoreCard(){
        addCard(to: hand.type == "computer");
    }
    
    private func stopPicking(){
        
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
